import { ERROR_PREFIX } from '../logic/constants';

const RULE_TEXT: Record<string, string> = {
  wrong_phase: 'Chưa đến lúc làm việc này',
  not_your_turn: 'Chưa đến lượt bạn',
  not_active: 'Bạn không còn trong ván',
  finished: 'Ván đã kết thúc',
  no_cash: 'Không đủ tiền',
  not_takeover: 'Không mua lại được ô này',
  takeover_hotel: 'Ô đã lên Khách sạn, không mua lại được',
  no_jail_card: 'Bạn không có thẻ ra tù',
  not_street: 'Chỉ xây được trên ô thành phố',
  not_owner: 'Ô này không phải của bạn',
  not_group_owner: 'Cần sở hữu trọn nhóm mới được nâng cấp',
  max_houses: 'Đã đạt cấp tối đa',
  build_uneven: 'Phải nâng đều các ô trong nhóm',
  no_houses: 'Ô này đang là đất trống',
  sell_uneven: 'Phải hạ đều các ô trong nhóm',
  invalid_tile: 'Ô không hợp lệ',
  invalid_move: 'Thao tác không hợp lệ',
  unknown_move: 'Thao tác không hợp lệ',
};

const ERROR_TEXT: Record<string, string> = {
  ALREADY_IN_ROOM: 'Bạn đang ở trong một bàn khác',
  BET_NOT_ALLOWED: 'Bàn này không cho phép cược KEN',
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
  NOT_ROOM_OWNER: 'Chỉ chủ bàn mới làm được việc này',
  NOT_ROOM_MEMBER: 'Bạn không còn ở trong bàn này',
  IN_ROOM: 'Hãy rời bàn hiện tại trước',
  INVALID_BET: 'Mức cược không hợp lệ',
  INVALID_PASSWORD: 'Mật khẩu bàn không hợp lệ',
  INSUFFICIENT_KEN: 'Bạn không đủ KEN để tham gia',
  MATCH_START_FAILED: 'Không thể bắt đầu ván, vui lòng thử lại',
  UNKNOWN_GAME: 'Trò chơi không hợp lệ',
  INVALID_MOVE: 'Thao tác không hợp lệ',
  MATCH_MISMATCH: 'Dữ liệu ván không khớp',
  NO_MATCH: 'Ván không còn hoạt động',
  NOT_YOUR_TURN: 'Chưa đến lượt bạn',
  STATE_SAVE_FAILED: 'Không lưu được nước đi, hãy thử lại',
  CHAT_RATE_LIMITED: 'Bạn gửi tin nhắn quá nhanh',
  REACTION_RATE_LIMITED: 'Bạn thả cảm xúc quá nhanh',
  CHAT_TOO_LONG: 'Tin nhắn tối đa 120 ký tự',
  INVALID_CHAT: 'Tin nhắn không hợp lệ',
  USER_INFO_FAILED: 'Không tải được thông tin người chơi',
  MATCH_NOT_FOUND: 'Ván đã kết thúc',
};

export function ruleText(code: string): string {
  return RULE_TEXT[code] ?? RULE_TEXT.invalid_move;
}

export function errorText(code: string, message = ''): string {
  if (message.startsWith(ERROR_PREFIX)) return ruleText(message.slice(ERROR_PREFIX.length));
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
