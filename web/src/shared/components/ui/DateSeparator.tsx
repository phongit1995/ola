import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { createDateFormatter } from '@lib';

interface DateSeparatorProps {
  iso: string;
}

export function DateSeparator({ iso }: DateSeparatorProps) {
  const { i18n } = useTranslation();
  const formatDate = useMemo(
    () => createDateFormatter(i18n.language),
    [i18n.language]
  );
  return (
    <div className="flex justify-center py-1">
      <span className="rounded-full bg-black/35 px-3 py-0.5 text-xs text-white">
        {formatDate(iso)}
      </span>
    </div>
  );
}
