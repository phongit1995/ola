import { useTranslation } from 'react-i18next';
import correctIcon from '@/assets/icons/word-chain/status/correct.webp';
import winIcon from '@/assets/icons/word-chain/status/win.webp';
import warningIcon from '@/assets/icons/word-chain/status/warning.webp';
import errorIcon from '@/assets/icons/word-chain/status/error.webp';
import type { WordChainMoveStatus } from '@app-types';

const STATUS_ICONS = {
  correct: { src: correctIcon, label: 'wordChain.statusCorrect' },
  win: { src: winIcon, label: 'wordChain.statusWin' },
  warning: { src: warningIcon, label: 'wordChain.statusWarning' },
  error: { src: errorIcon, label: 'wordChain.statusError' },
} as const satisfies Record<
  WordChainMoveStatus,
  { src: string; label: string }
>;

export function WordChainStatusIcon({
  status,
  className = 'h-7 w-7',
  decorative = false,
}: {
  status: WordChainMoveStatus;
  className?: string;
  decorative?: boolean;
}) {
  const { t } = useTranslation();
  const icon = STATUS_ICONS[status];
  const label = t(icon.label);

  return (
    <img
      src={icon.src}
      alt={decorative ? '' : label}
      title={decorative ? undefined : label}
      aria-hidden={decorative || undefined}
      draggable={false}
      className={`shrink-0 object-contain ${className}`}
    />
  );
}
