import { GAME_ERROR_CODE, type GameErrorCode } from '../../src/sdk';

const ERROR_TEXT = new Map<GameErrorCode, string>([
  [GAME_ERROR_CODE.NotYourTurn, 'Chưa đến lượt của bạn'],
  [GAME_ERROR_CODE.InvalidMove, 'Nước đi không hợp lệ'],
  [GAME_ERROR_CODE.NoMatch, 'Trận đấu không còn hoạt động'],
  [GAME_ERROR_CODE.MatchMismatch, 'Dữ liệu trận đấu không khớp'],
  [GAME_ERROR_CODE.MatchStartFailed, 'Không thể bắt đầu trận, vui lòng thử lại'],
  [GAME_ERROR_CODE.InsufficientKen, 'Bạn không đủ Ken để tham gia'],
  [GAME_ERROR_CODE.ChatRateLimited, 'Bạn gửi tin nhắn quá nhanh'],
  [GAME_ERROR_CODE.ChatTooLong, 'Tin nhắn tối đa 120 ký tự'],
  [GAME_ERROR_CODE.InvalidChat, 'Tin nhắn không hợp lệ'],
  [GAME_ERROR_CODE.StateSaveFailed, 'Không thể lưu nước đi, vui lòng thử lại'],
  [GAME_ERROR_CODE.UserInfoFailed, 'Không thể tải thông tin người chơi'],
  [GAME_ERROR_CODE.UnknownGame, 'Trò chơi không hợp lệ'],
  [GAME_ERROR_CODE.AlreadyInRoom, 'Bạn đang ở trong bàn khác'],
  [GAME_ERROR_CODE.InRoom, 'Bạn đang ở trong bàn'],
  [GAME_ERROR_CODE.WrongPassword, 'Sai mật khẩu'],
  [GAME_ERROR_CODE.RoomNotFound, 'Bàn không tồn tại hoặc đã đóng'],
  [GAME_ERROR_CODE.OwnRoom, 'Đây là bàn của bạn'],
  [GAME_ERROR_CODE.RoomBusy, 'Bàn đang trong trận'],
  [GAME_ERROR_CODE.RoomFull, 'Bàn đã đủ người'],
  [GAME_ERROR_CODE.RoomNotFull, 'Bàn chưa đủ người'],
  [GAME_ERROR_CODE.RoomNotReady, 'Khách chưa sẵn sàng'],
  [GAME_ERROR_CODE.NotRoomOwner, 'Chỉ chủ bàn mới làm được điều này'],
  [GAME_ERROR_CODE.NotRoomMember, 'Bạn không ở trong bàn này'],
  [GAME_ERROR_CODE.RoomMemberNotFound, 'Người chơi không còn trong bàn'],
  [GAME_ERROR_CODE.RoomMismatch, 'Dữ liệu bàn không khớp'],
  [GAME_ERROR_CODE.InvalidBet, 'Mức cược không hợp lệ'],
  [GAME_ERROR_CODE.InvalidPassword, 'Mật khẩu không hợp lệ'],
  [GAME_ERROR_CODE.BetNotAllowed, 'Mức cược này không được phép'],
  [GAME_ERROR_CODE.RoomCreateFailed, 'Không thể tạo bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomJoinFailed, 'Không thể vào bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomLeaveFailed, 'Không thể rời bàn, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomListFailed, 'Không thể tải danh sách bàn'],
  [GAME_ERROR_CODE.RoomStartFailed, 'Không thể bắt đầu trận, vui lòng thử lại'],
  [GAME_ERROR_CODE.RoomUpdateFailed, 'Không thể cập nhật bàn, vui lòng thử lại'],
]);

export function errorText(code: string): string {
  return ERROR_TEXT.get(code as GameErrorCode) ?? 'Có lỗi xảy ra';
}
