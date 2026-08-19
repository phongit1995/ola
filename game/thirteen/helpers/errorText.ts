const ERROR_TEXT: Record<string, string> = {
  ALREADY_IN_ROOM: 'Bạn đang ở trong một bàn khác',
  BET_NOT_ALLOWED: 'Bàn này không cho phép cược Ken',
  WRONG_PASSWORD: 'Sai mật khẩu',
  ROOM_NOT_FOUND: 'Bàn không còn nữa',
  OWN_ROOM: 'Không thể vào bàn của bạn',
  ROOM_BUSY: 'Bàn đang được cập nhật, vui lòng thử lại',
  ROOM_CREATE_FAILED: 'Không thể tạo bàn, vui lòng thử lại',
  ROOM_FULL: 'Bàn đã đủ người',
  ROOM_JOIN_FAILED: 'Không thể vào bàn, vui lòng thử lại',
  ROOM_LEAVE_FAILED: 'Không thể rời bàn, vui lòng thử lại',
  ROOM_LIST_FAILED: 'Không thể tải danh sách bàn',
  ROOM_MEMBER_NOT_FOUND: 'Người chơi không còn trong bàn',
  ROOM_MISMATCH: 'Bàn hiện tại không khớp',
  ROOM_NOT_FULL: 'Bàn cần thêm người chơi',
  ROOM_NOT_READY: 'Còn người chơi chưa sẵn sàng',
  ROOM_START_FAILED: 'Không thể bắt đầu ván, vui lòng thử lại',
  ROOM_UPDATE_FAILED: 'Không thể cập nhật bàn, vui lòng thử lại',
  NOT_ROOM_OWNER: 'Chỉ chủ bàn mới thực hiện được thao tác này',
  NOT_ROOM_MEMBER: 'Bạn không còn ở trong bàn này',
  IN_ROOM: 'Hãy rời bàn hiện tại trước',
  INVALID_BET: 'Thiết lập bàn không hợp lệ',
  INVALID_PASSWORD: 'Mật khẩu bàn không hợp lệ',
  INSUFFICIENT_KEN: 'Bạn không đủ Ken để tham gia',
  MATCH_START_FAILED: 'Không thể bắt đầu ván, vui lòng thử lại',
  UNKNOWN_GAME: 'Trò chơi không hợp lệ',
  INVALID_MOVE: 'Nước đánh không hợp lệ',
  MATCH_MISMATCH: 'Dữ liệu ván đấu không khớp',
  NO_MATCH: 'Ván đấu không còn hoạt động',
  NOT_YOUR_TURN: 'Chưa đến lượt của bạn',
  STATE_SAVE_FAILED: 'Không lưu được nước đánh, hãy thử lại',
  CHAT_RATE_LIMITED: 'Bạn gửi tin nhắn quá nhanh',
  CHAT_TOO_LONG: 'Tin nhắn tối đa 120 ký tự',
  INVALID_CHAT: 'Tin nhắn không hợp lệ',
  INVALID_REACTION: 'Cảm xúc không hợp lệ',
  REACTION_RATE_LIMITED: 'Bạn thả cảm xúc quá nhanh',
  USER_INFO_FAILED: 'Không tải được thông tin người chơi',
};

export function errorText(code: string): string {
  return ERROR_TEXT[code] ?? 'Có lỗi xảy ra, vui lòng thử lại';
}

const ROOM_CLOSED_TEXT: Record<string, string> = {
  owner_left: 'Chủ bàn đã rời bàn',
  owner_disconnected: 'Chủ bàn mất kết nối',
  owner_busy: 'Chủ bàn đang bận',
  guest_left: 'Bạn đã rời bàn',
};

export function roomClosedText(reason: string): string {
  return ROOM_CLOSED_TEXT[reason] ?? 'Bàn đã đóng';
}
