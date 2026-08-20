import { GAME_ERROR_CODE } from '../../src/sdk';

const ERROR_TEXT = new Map<string, string>([
  [GAME_ERROR_CODE.AlreadyInRoom, 'Bạn đang ở trong một bàn khác'],
  [GAME_ERROR_CODE.BetNotAllowed, 'Mức cược không được chấp nhận'],
  [GAME_ERROR_CODE.WrongPassword, 'Sai mật khẩu'],
  [GAME_ERROR_CODE.RoomNotFound, 'Bàn không còn tồn tại'],
  [GAME_ERROR_CODE.OwnRoom, 'Đây là bàn của bạn'],
  [GAME_ERROR_CODE.RoomBusy, 'Bàn đang bận, thử lại sau'],
  [GAME_ERROR_CODE.RoomCreateFailed, 'Không tạo được bàn'],
  [GAME_ERROR_CODE.RoomFull, 'Bàn đã đủ người'],
  [GAME_ERROR_CODE.RoomJoinFailed, 'Không vào được bàn'],
  [GAME_ERROR_CODE.RoomLeaveFailed, 'Không rời được bàn'],
  [GAME_ERROR_CODE.RoomListFailed, 'Không tải được danh sách bàn'],
  [GAME_ERROR_CODE.RoomMemberNotFound, 'Người chơi không còn trong bàn'],
  [GAME_ERROR_CODE.RoomMismatch, 'Bàn không khớp, thử làm mới'],
  [GAME_ERROR_CODE.RoomNotReady, 'Đối thủ chưa sẵn sàng'],
  [GAME_ERROR_CODE.RoomStartFailed, 'Không bắt đầu được ván'],
  [GAME_ERROR_CODE.NotRoomOwner, 'Chỉ chủ bàn mới làm được thao tác này'],
  [GAME_ERROR_CODE.InvalidBet, 'Số Ken cược không hợp lệ'],
  [GAME_ERROR_CODE.InvalidPassword, 'Mật khẩu không hợp lệ'],
  [GAME_ERROR_CODE.InsufficientKen, 'Bạn không đủ Ken'],
  [GAME_ERROR_CODE.ChatRateLimited, 'Bạn chat quá nhanh'],
  [GAME_ERROR_CODE.ChatTooLong, 'Tin nhắn quá dài'],
  [GAME_ERROR_CODE.InvalidChat, 'Tin nhắn không hợp lệ'],
  [GAME_ERROR_CODE.InvalidReaction, 'Cảm xúc không hợp lệ'],
  [GAME_ERROR_CODE.RoomNotFull, 'Chưa đủ người để bắt đầu'],
  [GAME_ERROR_CODE.NotRoomMember, 'Bạn không ở trong bàn này'],
  [GAME_ERROR_CODE.InvalidMove, 'Nước đi không hợp lệ'],
  [GAME_ERROR_CODE.MatchMismatch, 'Ván đấu không khớp'],
  [GAME_ERROR_CODE.NoMatch, 'Ván đấu đã kết thúc'],
  [GAME_ERROR_CODE.NotYourTurn, 'Chưa đến lượt bạn'],
  [GAME_ERROR_CODE.ReactionRateLimited, 'Bạn thả cảm xúc quá nhanh'],
  [GAME_ERROR_CODE.StateSaveFailed, 'Máy chủ gặp sự cố, nước đi chưa được ghi'],
  [GAME_ERROR_CODE.UnknownGame, 'Game chưa được bật trên máy chủ'],
]);

export function errorText(code: string, fallback = 'Có lỗi xảy ra, thử lại sau'): string {
  return ERROR_TEXT.get(code) ?? fallback;
}
