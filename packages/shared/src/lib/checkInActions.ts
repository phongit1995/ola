export interface CheckInAction {
  text: string;
  icon: string;
}

export const CHECK_IN_ACTIONS: CheckInAction[] = [
  { icon: '🍜', text: 'Đang ăn' },
  { icon: '☕', text: 'Đang uống cà phê' },
  { icon: '🍺', text: 'Đang nhậu' },
  { icon: '🎬', text: 'Đang xem phim' },
  { icon: '🎵', text: 'Đang nghe nhạc' },
  { icon: '🎮', text: 'Đang chơi game' },
  { icon: '💼', text: 'Đang làm việc' },
  { icon: '📚', text: 'Đang học' },
  { icon: '✈️', text: 'Đang du lịch' },
  { icon: '🛍️', text: 'Đang mua sắm' },
  { icon: '💪', text: 'Đang tập gym' },
  { icon: '🏠', text: 'Đang ở nhà' },
  { icon: '🚗', text: 'Đang di chuyển' },
  { icon: '🎉', text: 'Đang đi chơi' },
  { icon: '📷', text: 'Đang chụp ảnh' },
  { icon: '😴', text: 'Đang nghỉ ngơi' },
];

export function findActionIcon(text: string): string {
  return CHECK_IN_ACTIONS.find((action) => action.text === text)?.icon ?? '';
}
