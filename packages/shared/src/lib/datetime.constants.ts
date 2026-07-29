import type { TimeLabels } from '../types/lib.type';

export const VI_TIME_LABELS: TimeLabels = {
  justNow: 'vừa tức thì',
  minute: (n) => `${n} phút`,
  hour: (n) => `${n} giờ`,
  today: 'hôm nay',
  yesterday: 'hôm qua',
  dayBefore: 'hôm kia',
  weekdays: [
    'Chủ Nhật',
    'thứ Hai',
    'thứ Ba',
    'thứ Tư',
    'thứ Năm',
    'thứ Sáu',
    'thứ Bảy',
  ],
};

export const EN_TIME_LABELS: TimeLabels = {
  justNow: 'now',
  minute: (n) => `${n} ${n > 1 ? 'mins' : 'min'}`,
  hour: (n) => `${n} ${n > 1 ? 'hrs' : 'hr'}`,
  today: 'today',
  yesterday: 'yesterday',
  dayBefore: '2 days',
  weekdays: [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ],
};
