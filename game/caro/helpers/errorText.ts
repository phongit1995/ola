import { GAME_ERROR_CODE, type GameErrorCode } from '../../src/sdk';

const ROOM_ERROR_TEXT = new Map<GameErrorCode, string>([
  [GAME_ERROR_CODE.AlreadyInRoom, 'Bạn đang ở trong một bàn khác'],
  [GAME_ERROR_CODE.BetNotAllowed, 'Bàn này không cho phép cược Ken'],
  [GAME_ERROR_CODE.WrongPassword, 'Sai mật khẩu'],
  [GAME_ERROR_CODE.RoomNotFound, 'Bàn không còn nữa'],
  [GAME_ERROR_CODE.OwnRoom, 'Không thể vào bàn của bạn'],
  [GAME_ERROR_CODE.RoomBusy, 'Bàn đang được cập nhật, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomCreateFailed, 'Không thể tạo bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomFull, 'Bàn đã đủ người'],
  [GAME_ERROR_CODE.RoomJoinFailed, 'Không thể vào bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomLeaveFailed, 'Không thể rời bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomListFailed, 'Không thể tải danh sách bàn'],
  [GAME_ERROR_CODE.RoomMemberNotFound, 'Người chơi không còn trong bàn'],
  [GAME_ERROR_CODE.RoomMismatch, 'Bàn hiện tại không khớp'],
  [GAME_ERROR_CODE.RoomNotFull, 'Cần đủ hai người trong bàn'],
  [GAME_ERROR_CODE.RoomNotReady, 'Đối thủ chưa sẵn sàng'],
  [GAME_ERROR_CODE.RoomStartFailed, 'Không thể bắt đầu trận, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomUpdateFailed, 'Không thể cập nhật bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.NotRoomOwner, 'Chỉ chủ phòng mới thực hiện được thao tác này'],
  [GAME_ERROR_CODE.NotRoomMember, 'Bạn không còn ở trong bàn này'],
  [GAME_ERROR_CODE.InRoom, 'Hãy rời bàn hiện tại trước'],
  [GAME_ERROR_CODE.InvalidBet, 'Số Ken cược không hợp lệ'],
  [GAME_ERROR_CODE.InvalidPassword, 'Mật khẩu bàn không hợp lệ'],
  [GAME_ERROR_CODE.InsufficientKen, 'Bạn không đủ Ken để tham gia'],
  [GAME_ERROR_CODE.MatchStartFailed, 'Không thể bắt đầu trận, vui lòng thử lại'],
  [GAME_ERROR_CODE.UnknownGame, 'Trò chơi không hợp lệ'],
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

const MATCH_ERROR_TEXT = new Map<GameErrorCode, string>([
  [GAME_ERROR_CODE.InvalidMove, 'Nước đi không hợp lệ'],
  [GAME_ERROR_CODE.MatchMismatch, 'Dữ liệu trận đấu không khớp'],
  [GAME_ERROR_CODE.NoMatch, 'Trận đấu không còn hoạt động'],
  [GAME_ERROR_CODE.NotYourTurn, 'Chưa đến lượt của bạn'],
  [GAME_ERROR_CODE.StateSaveFailed, 'Không thể lưu nước đi, vui lòng thử lại'],
  [GAME_ERROR_CODE.UserInfoFailed, 'Không thể tải thông tin người chơi'],
]);

export function matchErrorText(code: string): string | null {
  return MATCH_ERROR_TEXT.get(code as GameErrorCode) ?? null;
}
