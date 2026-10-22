import { GAME_ERROR_CODE } from '../../src/sdk';
import { MOCK_PROFILE } from './profile';
import { NETWORK_ERROR, roomAction, roomMaxPlayers, type CreateRoomInput, type TycoonRoom } from './room';

export class RoomRequestError extends Error {
  constructor(readonly code: string) {
    super(code);
  }
}

const LATENCY_MS = 650;
const MOCK_PASSWORD = '1234';

const SEED_ROOMS: TycoonRoom[] = [
  { id: 'r-minhanh', owner: 'minhanh', ownerVipType: '3', bet: 0, locked: false, players: 2, maxPlayers: 4, status: 'waiting' },
  { id: 'r-linh', owner: 'linh', ownerVipType: '7', bet: 500, locked: true, players: 1, maxPlayers: 2, status: 'waiting' },
  { id: 'r-khoa', owner: 'khoa', ownerVipType: '12', bet: 1_000, locked: false, players: 3, maxPlayers: 4, status: 'waiting' },
  { id: 'r-trang', owner: 'trang', ownerVipType: '5', bet: 2_000, locked: false, players: 4, maxPlayers: 4, status: 'waiting' },
  { id: 'r-nam', owner: 'nam', ownerVipType: '18', bet: 5_000, locked: false, players: 4, maxPlayers: 4, status: 'playing', matchId: 'm-nam', allowSpectators: true },
  { id: 'r-ha', owner: 'ha', ownerVipType: null, bet: 0, locked: false, players: 2, maxPlayers: 3, status: 'waiting' },
  { id: 'r-tuan', owner: 'tuan', ownerVipType: '9', bet: 10_000, locked: true, players: 1, maxPlayers: 4, status: 'waiting' },
  { id: 'r-vy', owner: 'vy', ownerVipType: '2', bet: 500, locked: false, players: 3, maxPlayers: 3, status: 'playing', matchId: 'm-vy' },
  { id: 'r-long', owner: 'long', ownerVipType: '15', bet: 0, locked: false, players: 2, maxPlayers: 4, status: 'waiting' },
  { id: 'r-bao', owner: 'baongoc', ownerVipType: '21', bet: 20_000, locked: false, players: 1, maxPlayers: 4, status: 'waiting' },
  { id: 'r-quan', owner: 'quan', ownerVipType: '4', bet: 0, locked: true, players: 3, maxPlayers: 4, status: 'waiting' },
  { id: 'r-mai', owner: 'mai', ownerVipType: '11', bet: 3_000, locked: false, players: 3, maxPlayers: 3, status: 'playing', matchId: 'm-mai', allowSpectators: true },
  { id: 'r-phuc', owner: 'phucthinh_rat_dai_ten', ownerVipType: '8', bet: 1_500, locked: false, players: 1, maxPlayers: 2, status: 'waiting' },
  { id: 'r-an', owner: 'an', ownerVipType: null, bet: 0, locked: false, players: 2, maxPlayers: 2, status: 'waiting' },
  { id: 'r-duc', owner: 'duc', ownerVipType: '14', bet: 800, locked: true, players: 2, maxPlayers: 4, status: 'playing', matchId: 'm-duc', allowSpectators: true },
  { id: 'r-thao', owner: 'thao', ownerVipType: '6', bet: 0, locked: false, players: 1, maxPlayers: 4, status: 'waiting' },
  { id: 'r-hieu', owner: 'hieu', ownerVipType: '19', bet: 7_500, locked: false, players: 2, maxPlayers: 3, status: 'waiting' },
  { id: 'r-lan', owner: 'lan', ownerVipType: '1', bet: 0, locked: false, players: 4, maxPlayers: 4, status: 'playing', matchId: 'm-lan' },
  { id: 'r-son', owner: 'son', ownerVipType: '10', bet: 2_500, locked: false, players: 2, maxPlayers: 4, status: 'waiting' },
  { id: 'r-kim', owner: 'kim', ownerVipType: '16', bet: 0, locked: true, players: 1, maxPlayers: 3, status: 'waiting' },
  { id: 'r-tam', owner: 'tam', ownerVipType: '13', bet: 1_000, locked: false, players: 3, maxPlayers: 4, status: 'waiting' },
  { id: 'r-yen', owner: 'yen', ownerVipType: '20', bet: 4_000, locked: false, players: 2, maxPlayers: 2, status: 'playing', matchId: 'm-yen', allowSpectators: true },
  { id: 'r-viet', owner: 'viet', ownerVipType: null, bet: 0, locked: false, players: 1, maxPlayers: 4, status: 'waiting' },
  { id: 'r-hoa', owner: 'hoa', ownerVipType: '17', bet: 600, locked: false, players: 2, maxPlayers: 3, status: 'waiting' },
  { id: 'r-dat', owner: 'dat', ownerVipType: '22', bet: 12_000, locked: false, players: 3, maxPlayers: 4, status: 'waiting' },
];

const JOIN_FAILURES = new Map<string, string>([
  ['r-tuan', GAME_ERROR_CODE.RoomFull],
  ['r-long', GAME_ERROR_CODE.RoomNotFound],
  ['r-son', GAME_ERROR_CODE.RoomBusy],
]);

const SPECTATE_FAILURES = new Map<string, string>([
  ['r-mai', GAME_ERROR_CODE.MatchNotFound],
  ['r-yen', GAME_ERROR_CODE.SpectateFull],
]);

const scenario = new URLSearchParams(window.location.search).get('rooms');
const onceNetworkFailures = new Set(['r-ha']);

let rooms: TycoonRoom[] = scenario === 'empty' ? [] : SEED_ROOMS.map((room) => ({ ...room }));
let listFailures = scenario === 'error' ? 1 : 0;
let createdCount = 0;

const delay = (ms: number): Promise<void> => new Promise((resolve) => setTimeout(resolve, ms));

function findRoom(roomId: string): TycoonRoom {
  const room = rooms.find((item) => item.id === roomId);
  if (!room) throw new RoomRequestError(GAME_ERROR_CODE.RoomNotFound);
  return room;
}

function dropRoom(roomId: string): void {
  rooms = rooms.filter((room) => room.id !== roomId);
}

export async function mockFetchRooms(): Promise<TycoonRoom[]> {
  await delay(LATENCY_MS);
  if (listFailures > 0) {
    listFailures -= 1;
    throw new RoomRequestError(NETWORK_ERROR);
  }
  return rooms.map((room) => ({ ...room }));
}

export async function mockJoinRoom(roomId: string, password?: string): Promise<TycoonRoom> {
  await delay(LATENCY_MS);
  if (onceNetworkFailures.delete(roomId)) throw new RoomRequestError(NETWORK_ERROR);
  const room = findRoom(roomId);
  if (room.owner === MOCK_PROFILE.username) throw new RoomRequestError(GAME_ERROR_CODE.OwnRoom);
  if (room.locked && password !== MOCK_PASSWORD) throw new RoomRequestError(GAME_ERROR_CODE.WrongPassword);
  const failure = JOIN_FAILURES.get(roomId);
  if (failure === GAME_ERROR_CODE.RoomNotFound) dropRoom(roomId);
  if (failure === GAME_ERROR_CODE.RoomFull) room.players = roomMaxPlayers(room);
  if (failure) throw new RoomRequestError(failure);
  if (roomAction(room) !== 'join') throw new RoomRequestError(GAME_ERROR_CODE.RoomFull);
  return { ...room };
}

export async function mockSpectate(roomId: string): Promise<TycoonRoom> {
  await delay(LATENCY_MS);
  const room = findRoom(roomId);
  const failure = SPECTATE_FAILURES.get(roomId);
  if (failure === GAME_ERROR_CODE.MatchNotFound) dropRoom(roomId);
  if (failure) throw new RoomRequestError(failure);
  if (!room.allowSpectators) throw new RoomRequestError('SPECTATE_NOT_ALLOWED');
  return { ...room };
}

export async function mockCreateRoom(input: CreateRoomInput): Promise<TycoonRoom> {
  await delay(LATENCY_MS);
  createdCount += 1;
  const room: TycoonRoom = {
    id: `r-new-${createdCount}`,
    owner: MOCK_PROFILE.username,
    ownerVipType: MOCK_PROFILE.vipType,
    bet: input.bet,
    locked: input.password.length > 0,
    players: 1,
    maxPlayers: input.maxPlayers,
    status: 'waiting',
    allowSpectators: input.allowSpectators,
  };
  rooms = [room, ...rooms];
  return { ...room };
}
