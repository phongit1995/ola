import { GAME_ERROR_CODE, type GameErrorCode } from '../../src/sdk';

const ROOM_ERROR_TEXT = new Map<GameErrorCode, string>([
  [GAME_ERROR_CODE.WrongPassword, 'Sai mật khẩu'],
  [GAME_ERROR_CODE.RoomNotFound, 'Bàn không còn nữa'],
  [GAME_ERROR_CODE.OwnRoom, 'Không thể vào bàn của bạn'],
]);

const CHAT_ERROR_TEXT = new Map<GameErrorCode, string>([
  [GAME_ERROR_CODE.ChatRateLimited, 'Bạn gửi tin nhắn quá nhanh'],
  [GAME_ERROR_CODE.ChatTooLong, 'Tin nhắn tối đa 120 ký tự'],
  [GAME_ERROR_CODE.InvalidChat, 'Tin nhắn không hợp lệ'],
  [GAME_ERROR_CODE.RoomNotFull, 'Cần đủ hai người trong bàn để chat'],
  [GAME_ERROR_CODE.NotRoomMember, 'Bạn không còn ở trong bàn này'],
]);

export function roomErrorText(code: string): string | null {
  return ROOM_ERROR_TEXT.get(code as GameErrorCode) ?? null;
}

export function chatErrorText(code: string): string | null {
  return CHAT_ERROR_TEXT.get(code as GameErrorCode) ?? null;
}
