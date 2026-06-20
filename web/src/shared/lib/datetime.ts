import dayjs from 'dayjs';
import localizedFormat from 'dayjs/plugin/localizedFormat';
import 'dayjs/locale/vi';

dayjs.extend(localizedFormat);

function resolveLocale(locale: string): string {
  return locale.startsWith('vi') ? 'vi' : 'en';
}

export function formatDateDMY(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  return `${day}-${month}-${date.getFullYear()}`;
}

export function createDateFormatter(locale: string): (iso: string) => string {
  const lang = resolveLocale(locale);
  return (iso: string) => {
    const date = dayjs(iso);
    return date.isValid() ? date.locale(lang).format('L') : iso;
  };
}

interface TimeLabels {
  justNow: string;
  minute: (n: number) => string;
  hour: (n: number) => string;
  today: string;
  yesterday: string;
  dayBefore: string;
  weekdays: string[];
}

const VI_LABELS: TimeLabels = {
  justNow: 'vừa tức thì',
  minute: (n) => `${n} phút`,
  hour: (n) => `${n} giờ`,
  today: 'hôm nay',
  yesterday: 'hôm qua',
  dayBefore: 'hôm kia',
  weekdays: ['Chủ Nhật', 'thứ Hai', 'thứ Ba', 'thứ Tư', 'thứ Năm', 'thứ Sáu', 'thứ Bảy'],
};

const EN_LABELS: TimeLabels = {
  justNow: 'now',
  minute: (n) => `${n} ${n > 1 ? 'mins' : 'min'}`,
  hour: (n) => `${n} ${n > 1 ? 'hrs' : 'hr'}`,
  today: 'today',
  yesterday: 'yesterday',
  dayBefore: '2 days',
  weekdays: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
};

export function createTimeFormatter(locale: string): (iso: string) => string {
  const labels = resolveLocale(locale) === 'vi' ? VI_LABELS : EN_LABELS;
  return (iso: string) => {
    const then = dayjs(iso);
    if (!then.isValid()) return '';
    const now = dayjs();
    const time = then.format('HH:mm');
    const ageSeconds = Math.max(0, now.diff(then, 'second'));

    if (then.isSame(now, 'day')) {
      if (ageSeconds <= 60) return labels.justNow;
      const minutes = Math.floor(ageSeconds / 60);
      if (minutes < 60) return labels.minute(minutes);
      const hours = Math.floor(minutes / 60);
      if (hours < 7) return labels.hour(hours);
      return `${time} ${labels.today}`;
    }

    const days = now.startOf('day').diff(then.startOf('day'), 'day');
    if (days === 1) return `${time} ${labels.yesterday}`;
    if (days === 2) return `${time} ${labels.dayBefore}`;
    if (days >= 3 && days <= 6) return `${time} ${labels.weekdays[then.day()] ?? ''}`;

    if (then.year() === now.year()) return `${time} ${then.format('DD/MM')}`;
    return `${time} ${then.format('DD/MM/YYYY')}`;
  };
}
