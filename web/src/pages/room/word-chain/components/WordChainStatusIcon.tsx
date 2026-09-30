import { useTranslation } from 'react-i18next';
import correctIcon from '@/assets/icons/word-chain/status/correct.png';
import winIcon from '@/assets/icons/word-chain/status/win.png';
import warningIcon from '@/assets/icons/word-chain/status/warning.png';
import errorIcon from '@/assets/icons/word-chain/status/error.png';
import type { WordChainMoveStatus } from './wordChainStatus';

const STATUS_ICONS = {
  correct: { src: correctIcon, label: 'wordChain.statusCorrect' },
  win: { src: winIcon, label: 'wordChain.statusWin' },
  warning: { src: warningIcon, label: 'wordChain.statusWarning' },
  error: { src: errorIcon, label: 'wordChain.statusError' },
} as const;

const STATUS_ICON_FILTER = 'saturate(0.85) brightness(1.04)';

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
      style={{ filter: STATUS_ICON_FILTER }}
      className={`shrink-0 object-contain ${className}`}
    />
  );
}
