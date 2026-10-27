import { GAME_ERROR_CODE, type RoomInfo } from '../../src/sdk/protocol';
import { formatKen } from './format';

export type TycoonRoom = RoomInfo & { allowSpectators?: boolean };

export type RoomAction = 'join' | 'full' | 'watch' | 'playing';

export type CreateRoomField = 'bet' | 'password';

export interface CreateRoomInput {
  maxPlayers: number;
  bet: number;
  password: string;
  allowSpectators: boolean;
}

export interface FieldError {
  field: CreateRoomField;
  text: string;
}

export const ROOM_PAGE_SIZE = 9;
export const ROOM_PASSWORD_MAX_LENGTH = 64;
export const ROOM_PLAYER_OPTIONS = [2, 3, 4] as const;
export const DEFAULT_MAX_PLAYERS = 4;
export const NETWORK_ERROR = 'NETWORK';
export const ROOM_RESYNC_MIN_MS = 90_000;
export const ROOM_RESYNC_JITTER_MS = 30_000;

export const BET_INVALID_TEXT = 'Số KEN cược không hợp lệ';
export const BET_OVER_BALANCE_TEXT = 'Bạn không đủ KEN để tạo bàn';
export const BET_NOT_ALLOWED_TEXT = 'Tài khoản chưa thể tạo bàn có cược KEN';
export const PASSWORD_REQUIRED_TEXT = 'Nhập mật khẩu hoặc tắt Khóa bàn';
export const PASSWORD_TOO_LONG_TEXT = `Mật khẩu tối đa ${ROOM_PASSWORD_MAX_LENGTH} ký tự`;
export const WRONG_PASSWORD_TEXT = 'Sai mật khẩu';

const ROOM_TOAST_TEXT = new Map<string, string>([
  [GAME_ERROR_CODE.RoomFull, 'Bàn đã đủ người'],
  [GAME_ERROR_CODE.RoomNotFound, 'Bàn không còn nữa'],
  [GAME_ERROR_CODE.RoomBusy, 'Bàn đang được cập nhật, vui lòng thử lại'],
  [GAME_ERROR_CODE.AlreadyInRoom, 'Bạn đang ở trong một bàn khác'],
  [GAME_ERROR_CODE.InRoom, 'Bạn đang ở trong một bàn khác'],
  [GAME_ERROR_CODE.OwnRoom, 'Đây là bàn của bạn'],
  [GAME_ERROR_CODE.RoomJoinFailed, 'Không thể vào bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomCreateFailed, 'Không thể tạo bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.SpectateFull, 'Bàn đã đủ người xem'],
  [GAME_ERROR_CODE.SpectateOwnMatch, 'Bạn đang trong một ván khác'],
  [GAME_ERROR_CODE.MatchNotFound, 'Ván đã kết thúc'],
  ['SPECTATE_NOT_ALLOWED', 'Bàn này không cho người ngoài xem'],
]);

export function roomToastText(code: string): string {
  return ROOM_TOAST_TEXT.get(code) ?? 'Không thể vào bàn, vui lòng thử lại';
}

export function roomMaxPlayers(room: TycoonRoom): number {
  return room.maxPlayers ?? DEFAULT_MAX_PLAYERS;
}

export function roomSeatsLabel(room: TycoonRoom): string {
  return `${room.players}/${roomMaxPlayers(room)}`;
}

export function roomAction(room: TycoonRoom): RoomAction {
  if (room.status === 'playing') return room.allowSpectators ? 'watch' : 'playing';
  return room.full || room.players >= roomMaxPlayers(room) ? 'full' : 'join';
}

export function roomBetLabel(bet: number): string {
  return bet > 0 ? `${formatKen(bet)} KEN` : 'Giao lưu';
}

export function pageCount(total: number): number {
  return Math.max(1, Math.ceil(total / ROOM_PAGE_SIZE));
}

export function parseBetInput(text: string): number {
  const digits = text.replace(/\D/g, '');
  return digits ? Number(digits) : 0;
}

export function formatBetInput(text: string): string {
  const digits = text.replace(/\D/g, '').replace(/^0+(?=\d)/, '');
  return digits ? formatKen(Number(digits)) : '';
}

export function createRoomError(input: CreateRoomInput, locked: boolean, ken: number, maxBet: number | null): FieldError | null {
  const { bet, password } = input;
  if (!Number.isSafeInteger(bet) || bet < 0 || (maxBet != null && bet > maxBet)) return { field: 'bet', text: BET_INVALID_TEXT };
  if (bet > ken) return { field: 'bet', text: BET_OVER_BALANCE_TEXT };
  if (locked && password.length === 0) return { field: 'password', text: PASSWORD_REQUIRED_TEXT };
  if (password.length > ROOM_PASSWORD_MAX_LENGTH) return { field: 'password', text: PASSWORD_TOO_LONG_TEXT };
  return null;
}
