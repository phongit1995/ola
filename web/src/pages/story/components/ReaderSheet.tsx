import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import type { ReaderPalette } from '../interface';

interface ReaderSheetProps {
  title: string;
  palette: ReaderPalette;
  onClose: () => void;
  children: ReactNode;
}

export function ReaderSheet({
  title,
  palette,
  onClose,
  children,
}: ReaderSheetProps) {
  const { t } = useTranslation();
  return (
    <div className="absolute inset-0 z-10 flex flex-col justify-end">
      <button
        type="button"
        aria-label={t('story.close')}
        onClick={onClose}
        className="absolute inset-0 bg-black/40"
      />
      <div
        role="dialog"
        aria-label={title}
        className="relative mx-auto flex max-h-[75%] w-full max-w-2xl flex-col rounded-t-2xl shadow-[0_-4px_16px_rgba(0,0,0,.2)]"
        style={{ backgroundColor: palette.panel, color: palette.text }}
      >
        <div className="flex items-center justify-between px-4 pt-3 pb-2">
          <h2 className="text-base font-bold">{title}</h2>
          <button
            type="button"
            onClick={onClose}
            className="rounded-full px-2 py-1 text-sm"
            style={{ color: palette.muted }}
          >
            {t('story.close')}
          </button>
        </div>
        {children}
      </div>
    </div>
  );
}
