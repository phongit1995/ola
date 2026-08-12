import { Container } from 'pixi.js';
import {
  GAME_ERROR_CODE,
  type ErrorData,
  type GameSession,
  type RoomClosedData,
  type RoomInfo,
  type RoomKickedData,
  type RoomListData,
  type RoomRemovedData,
  type RoomStateData,
  type RoomUpsertData,
  type RoomWaitingData,
  type UserInfoData,
} from '../src/sdk';
import { errorText } from './logic/error-text';
import {
  buildRoomListPopup,
  hideRoomListPopup,
  isRoomListPopupOpen,
  layoutRoomListPopup,
  openRoomListPopup,
  renderRoomList,
  setRoomListUser,
} from './screens/lobby/rooms/list-popup';
import {
  buildCreateRoomPopup,
  hideCreateRoomPopup,
  isCreateRoomPopupOpen,
  layoutCreateRoomPopup,
  openCreateRoomPopup,
} from './screens/lobby/rooms/create-popup';
import {
  buildPasswordPopup,
  hidePasswordPopup,
  isPasswordPopupOpen,
  layoutPasswordPopup,
  openPasswordPopup,
} from './screens/lobby/rooms/password-popup';
import {
  buildWaitingPopup,
  hideWaitingPopup,
  isWaitingPopupOpen,
  layoutWaitingPopup,
  openWaitingPopup,
  renderWaitingRoom,
} from './screens/lobby/rooms/waiting-popup';
import {
  buildRoomsConfirm,
  hideRoomsConfirm,
  isRoomsConfirmOpen,
  layoutRoomsConfirm,
  openRoomsConfirm,
  openRoomsNotice,
} from './screens/lobby/rooms/confirm';

export interface RoomsDeps {
  getSession(): GameSession | null;
  getUserInfo(): UserInfoData | null;
  toast(msg: string): void;
}

const ROOM_ERROR_CODES = new Set<string>([
  GAME_ERROR_CODE.AlreadyInRoom,
  GAME_ERROR_CODE.BetNotAllowed,
  GAME_ERROR_CODE.WrongPassword,
  GAME_ERROR_CODE.RoomNotFound,
  GAME_ERROR_CODE.OwnRoom,
  GAME_ERROR_CODE.RoomBusy,
  GAME_ERROR_CODE.RoomCreateFailed,
  GAME_ERROR_CODE.RoomFull,
  GAME_ERROR_CODE.RoomJoinFailed,
  GAME_ERROR_CODE.RoomLeaveFailed,
  GAME_ERROR_CODE.RoomListFailed,
  GAME_ERROR_CODE.RoomMemberNotFound,
  GAME_ERROR_CODE.RoomMismatch,
  GAME_ERROR_CODE.RoomNotReady,
  GAME_ERROR_CODE.RoomNotFull,
  GAME_ERROR_CODE.RoomStartFailed,
  GAME_ERROR_CODE.RoomUpdateFailed,
  GAME_ERROR_CODE.NotRoomOwner,
  GAME_ERROR_CODE.NotRoomMember,
  GAME_ERROR_CODE.InRoom,
  GAME_ERROR_CODE.InvalidBet,
  GAME_ERROR_CODE.InvalidPassword,
  GAME_ERROR_CODE.InsufficientKen,
]);

const CLOSE_REASON_TEXT: Record<string, string> = {
  owner_left: 'Chủ bàn đã rời bàn',
  owner_disconnected: 'Chủ bàn mất kết nối',
  owner_busy: 'Chủ bàn đang bận',
  guest_left: 'Khách đã rời bàn',
  member_left: 'Khách đã rời bàn',
};

let deps: RoomsDeps | null = null;
let wired: GameSession | null = null;
let offs: Array<() => void> = [];
const roomMap = new Map<string, RoomInfo>();
let roomOrder: string[] = [];
let currentRoomId = '';
let currentBet = 0;
let currentState: RoomStateData | null = null;
let inMatch = false;
let pendingUntil = 0;
let refreshUntil = 0;
let joinTarget: RoomInfo | null = null;
let selfLeftAt = 0;

function toast(msg: string): void {
  deps?.toast(msg);
}

function tryLock(): boolean {
  if (Date.now() < pendingUntil) return false;
  pendingUntil = Date.now() + 1000;
  return true;
}

function currentRooms(): RoomInfo[] {
  const rooms: RoomInfo[] = [];
  for (const id of roomOrder) {
    const room = roomMap.get(id);
    if (room) rooms.push(room);
  }
  return rooms;
}

function anyRoomsPopupVisible(): boolean {
  return (
    isRoomListPopupOpen() ||
    isCreateRoomPopupOpen() ||
    isPasswordPopupOpen() ||
    isWaitingPopupOpen() ||
    isRoomsConfirmOpen()
  );
}

function renderIfListOpen(): void {
  if (isRoomListPopupOpen()) renderRoomList(currentRooms());
}

function showWaiting(): void {
  hideRoomListPopup();
  hideCreateRoomPopup();
  hidePasswordPopup();
  hideRoomsConfirm();
  if (!isWaitingPopupOpen()) openWaitingPopup();
  renderWaitingRoom(currentState, currentRoomId ? { roomId: currentRoomId, bet: currentBet } : null);
}

function showList(refresh: boolean): void {
  hideCreateRoomPopup();
  hidePasswordPopup();
  hideWaitingPopup();
  if (!isRoomListPopupOpen()) openRoomListPopup();
  setRoomListUser(deps?.getUserInfo() ?? null);
  renderRoomList(currentRooms());
  if (refresh) activeSession()?.listRooms();
}

const handleList = (data: RoomListData): void => {
  pendingUntil = 0;
  refreshUntil = 0;
  roomMap.clear();
  roomOrder = [];
  for (const room of data.rooms) {
    roomMap.set(room.id, room);
    roomOrder.push(room.id);
  }
  renderIfListOpen();
};

const handleUpsert = (data: RoomUpsertData): void => {
  if (!roomMap.has(data.room.id)) roomOrder.unshift(data.room.id);
  roomMap.set(data.room.id, data.room);
  renderIfListOpen();
};

const handleRemoved = (data: RoomRemovedData): void => {
  if (!roomMap.delete(data.roomId)) return;
  roomOrder = roomOrder.filter((id) => id !== data.roomId);
  renderIfListOpen();
};

const handleWaiting = (data: RoomWaitingData): void => {
  pendingUntil = 0;
  currentRoomId = data.roomId;
  currentBet = data.bet;
  if (currentState && currentState.roomId !== data.roomId) currentState = null;
  inMatch = false;
  joinTarget = null;
  if (anyRoomsPopupVisible()) showWaiting();
};

const handleState = (data: RoomStateData): void => {
  pendingUntil = 0;
  currentRoomId = data.roomId;
  currentState = data;
  currentBet = data.bet;
  inMatch = false;
  joinTarget = null;
  if (isWaitingPopupOpen()) {
    renderWaitingRoom(data, { roomId: data.roomId, bet: data.bet });
  } else if (anyRoomsPopupVisible()) {
    showWaiting();
  }
};

const handleClosed = (data: RoomClosedData): void => {
  if (data.roomId !== currentRoomId) return;
  pendingUntil = 0;
  currentRoomId = '';
  currentState = null;
  currentBet = 0;
  inMatch = false;
  const msg = CLOSE_REASON_TEXT[data.reason];
  if (msg && Date.now() - selfLeftAt > 3000) toast(msg);
  if (isWaitingPopupOpen() || isRoomsConfirmOpen()) {
    hideRoomsConfirm();
    showList(true);
  }
};

const handleKicked = (data: RoomKickedData): void => {
  if (currentRoomId && data.roomId !== currentRoomId) return;
  pendingUntil = 0;
  currentRoomId = '';
  currentState = null;
  currentBet = 0;
  inMatch = false;
  if (anyRoomsPopupVisible()) {
    hideWaitingPopup();
    hideRoomsConfirm();
    openRoomsNotice('Bạn bị mời khỏi bàn', () => showList(true));
  } else {
    toast('Bạn bị mời khỏi bàn');
  }
};

const handleMatchFound = (): void => {
  pendingUntil = 0;
  inMatch = true;
  hideAllRoomPopups();
};

const handleError = (data: ErrorData): void => {
  if (!ROOM_ERROR_CODES.has(data.code)) return;
  const engaged = anyRoomsPopupVisible() || pendingUntil > Date.now();
  pendingUntil = 0;
  if (!engaged) return;
  toast(errorText(data.code));
  if (data.code === GAME_ERROR_CODE.WrongPassword && isPasswordPopupOpen()) return;
  if (isPasswordPopupOpen()) {
    joinTarget = null;
    showList(true);
    return;
  }
  if (
    isRoomListPopupOpen() &&
    (data.code === GAME_ERROR_CODE.RoomNotFound ||
      data.code === GAME_ERROR_CODE.RoomFull ||
      data.code === GAME_ERROR_CODE.RoomBusy)
  ) {
    activeSession()?.listRooms();
  }
};

function wire(): void {
  if (!deps) return;
  const next = deps.getSession();
  if (next === wired) return;
  for (const off of offs) off();
  offs = [];
  if (wired) {
    currentRoomId = '';
    currentState = null;
    currentBet = 0;
    inMatch = false;
    joinTarget = null;
    pendingUntil = 0;
    refreshUntil = 0;
    roomMap.clear();
    roomOrder = [];
  }
  wired = next;
  if (!next) return;
  offs.push(
    next.onRoomList(handleList),
    next.onRoomUpsert(handleUpsert),
    next.onRoomRemoved(handleRemoved),
    next.onRoomWaiting(handleWaiting),
    next.onRoomState(handleState),
    next.onRoomClosed(handleClosed),
    next.onRoomKicked(handleKicked),
    next.onMatchFound(handleMatchFound),
    next.onError(handleError),
  );
}

function activeSession(): GameSession | null {
  wire();
  return wired;
}

function refreshRooms(): void {
  const now = Date.now();
  if (now < refreshUntil) return;
  refreshUntil = now + 800;
  activeSession()?.listRooms();
}

function joinRoomFromList(room: RoomInfo): void {
  if (room.full === true || room.players >= 2) return;
  const info = deps?.getUserInfo() ?? null;
  if (info && room.bet > info.ken) {
    toast('Bạn không đủ Ken để vào bàn này');
    return;
  }
  if (room.locked) {
    joinTarget = room;
    hideRoomListPopup();
    openPasswordPopup(room.owner);
    return;
  }
  if (!tryLock()) return;
  joinTarget = room;
  activeSession()?.joinRoom(room.id);
}

function submitCreateRoom(bet: number, password: string): void {
  if (!Number.isInteger(bet) || bet < 0) {
    toast('Mức cược không hợp lệ');
    return;
  }
  const info = deps?.getUserInfo() ?? null;
  if (info) {
    if (bet > info.ken) {
      toast('Bạn không đủ Ken cho mức cược này');
      return;
    }
    const maxBet = info.maxBet ?? 0;
    if (maxBet > 0 && bet > maxBet) {
      toast(`Mức cược tối đa ${maxBet.toLocaleString('vi-VN')} KEN`);
      return;
    }
  }
  if (password.length > 64) {
    toast('Mật khẩu tối đa 64 ký tự');
    return;
  }
  const s = activeSession();
  if (!s) {
    toast('Chưa kết nối máy chủ');
    return;
  }
  if (!tryLock()) return;
  s.createRoom(bet, password.length > 0 ? password : undefined);
}

function submitPassword(password: string): void {
  const target = joinTarget;
  if (!target) {
    showList(true);
    return;
  }
  if (password.length === 0) {
    toast('Vui lòng nhập mật khẩu');
    return;
  }
  if (!tryLock()) return;
  activeSession()?.joinRoom(target.id, password);
}

function toggleReady(): void {
  const state = currentState;
  if (!state) return;
  const me = state.members.find((m) => m.id === state.youId);
  if (!me || me.owner) return;
  if (!tryLock()) return;
  activeSession()?.setRoomReady(state.roomId, !me.ready);
}

function startMatch(): void {
  const state = currentState;
  if (!state) return;
  const guest = state.members.find((m) => !m.owner);
  if (guest?.ready !== true) {
    toast('Khách chưa sẵn sàng');
    return;
  }
  if (!tryLock()) return;
  activeSession()?.startRoom(state.roomId);
}

function confirmKick(userId: string): void {
  const roomId = currentRoomId;
  if (!roomId) return;
  openRoomsConfirm('Mời người chơi này\nra khỏi bàn?', () => {
    activeSession()?.kickRoomMember(roomId, userId);
  });
}

function confirmLeave(): void {
  const roomId = currentRoomId;
  if (!roomId) return;
  openRoomsConfirm('Bạn có chắc muốn\nrời bàn?', () => {
    selfLeftAt = Date.now();
    activeSession()?.leaveRoom(roomId);
  });
}

export function initRooms(nextDeps: RoomsDeps): void {
  deps = nextDeps;
  wire();
}

export function buildRoomsLayer(): Container {
  const layer = new Container();
  layer.addChild(
    buildRoomListPopup({
      onCreate: () => {
        hideRoomListPopup();
        openCreateRoomPopup();
      },
      onRefresh: refreshRooms,
      onJoin: joinRoomFromList,
      onTopUp: () => toast('Nạp Ken trong app Ola nhé!'),
    }),
    buildCreateRoomPopup({
      onSubmit: submitCreateRoom,
      onCancel: () => showList(false),
    }),
    buildPasswordPopup({
      onSubmit: submitPassword,
      onCancel: () => {
        joinTarget = null;
        showList(false);
      },
    }),
    buildWaitingPopup({
      onToggleReady: toggleReady,
      onStart: startMatch,
      onKick: confirmKick,
      onLeave: confirmLeave,
    }),
    buildRoomsConfirm(),
  );
  return layer;
}

export function layoutRooms(designH: number, insetTop: number, insetBottom: number): void {
  layoutRoomListPopup(designH, insetTop, insetBottom);
  layoutCreateRoomPopup(designH, insetTop, insetBottom);
  layoutPasswordPopup(designH, insetTop, insetBottom);
  layoutWaitingPopup(designH, insetTop, insetBottom);
  layoutRoomsConfirm(designH);
}

export function openRoomList(): void {
  const s = activeSession();
  if (!s) {
    toast('Chưa kết nối máy chủ');
    return;
  }
  if (hasActiveRoom()) {
    showWaiting();
    return;
  }
  hideAllRoomPopups();
  openRoomListPopup();
  setRoomListUser(deps?.getUserInfo() ?? null);
  renderRoomList(currentRooms());
  s.listRooms();
}

export function hasActiveRoom(): boolean {
  return currentRoomId !== '' && !inMatch;
}

export function openWaitingRoom(): void {
  if (!activeSession()) return;
  if (!hasActiveRoom()) {
    openRoomList();
    return;
  }
  showWaiting();
}

export function hideAllRoomPopups(): void {
  hideRoomListPopup();
  hideCreateRoomPopup();
  hidePasswordPopup();
  hideWaitingPopup();
  hideRoomsConfirm();
}
