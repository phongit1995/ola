import { useTranslation } from 'react-i18next';
import vipCrownIcon from '@/assets/icons/apps/vip-crown.webp';
import type { StoryAccess } from '@app-types';
import type { ReaderPalette } from '../types';

interface StoryLockedPanelProps {
  chapterTitle: string;
  access: StoryAccess;
  palette: ReaderPalette;
  onBuyVip: () => void;
  onComment: () => void;
}

export function StoryLockedPanel({
  chapterTitle,
  access,
  palette,
  onBuyVip,
  onComment,
}: StoryLockedPanelProps) {
  const { t } = useTranslation();
  return (
    <section className="mx-auto flex w-full max-w-md flex-col items-center px-6 pt-10 pb-12 text-center font-sans">
      <span className="text-sm" style={{ color: palette.muted }}>
        {chapterTitle}
      </span>
      <img
        src={vipCrownIcon}
        alt=""
        className="mt-6 h-16 w-16 object-contain"
      />
      <h2 className="mt-4 text-lg leading-snug font-bold">
        {t('story.lockedTitle')}
      </h2>
      <p className="mt-2 text-sm leading-6" style={{ color: palette.muted }}>
        {t('story.lockedMessage', { count: access.freeLimit })}
      </p>
      <button
        type="button"
        onClick={onBuyVip}
        className="mt-6 flex min-h-11 w-full max-w-xs items-center justify-center rounded-full bg-ola-button px-4 py-2 text-sm font-semibold text-ola-on-primary active:opacity-90"
      >
        {t('story.lockedVip')}
      </button>
      <button
        type="button"
        onClick={onComment}
        className="mt-3 flex min-h-11 w-full max-w-xs items-center justify-center rounded-full border border-ola-primary px-4 py-2 text-sm text-ola-primary-ink active:bg-ola-primary/10"
      >
        {t('story.lockedComment')}
      </button>
    </section>
  );
}
