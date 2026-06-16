const RELATIVE_TIME_UNITS: Array<[Intl.RelativeTimeFormatUnit, number]> = [
  ['year', 31536000],
  ['month', 2592000],
  ['day', 86400],
  ['hour', 3600],
  ['minute', 60],
  ['second', 1],
];

export function createDateFormatter(locale: string): (iso: string) => string {
  const formatter = new Intl.DateTimeFormat(locale, {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
  });
  return (iso: string) => {
    const date = new Date(iso);
    return Number.isNaN(date.getTime()) ? iso : formatter.format(date);
  };
}

export function createTimeFormatter(locale: string): (iso: string) => string {
  const rtf = new Intl.RelativeTimeFormat(locale, { numeric: 'auto' });
  return (iso: string) => {
    const then = new Date(iso).getTime();
    if (Number.isNaN(then)) return '';
    const diffSeconds = Math.round((then - Date.now()) / 1000);
    const abs = Math.abs(diffSeconds);
    for (const [unit, secs] of RELATIVE_TIME_UNITS) {
      if (abs >= secs || unit === 'second') {
        return rtf.format(Math.round(diffSeconds / secs), unit);
      }
    }
    return '';
  };
}
