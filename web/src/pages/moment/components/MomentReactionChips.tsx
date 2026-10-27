import { useTranslation } from 'react-i18next';
import {
  formatCompactCount,
  MOMENT_REACTION_LABEL_KEY,
  REACTION_IMAGE,
} from '@lib';
import type { MomentReactionCount } from '@app-types';

const SUMMARY_ICONS = 3;

export function MomentReactionCounts({
  reactions,
}: {
  reactions: MomentReactionCount[];
}) {
  const { t, i18n } = useTranslation();
  return (
    <span className="flex shrink-0 items-center gap-2">
      {reactions.map(({ type, count }) => (
        <span
          key={type}
          className="inline-flex items-center gap-0.5 text-xs font-semibold text-black/70"
        >
          <img
            src={REACTION_IMAGE[type]}
            alt={t(MOMENT_REACTION_LABEL_KEY[type])}
            className="h-5 w-5 object-contain"
          />
          {formatCompactCount(count, i18n.language)}
        </span>
      ))}
    </span>
  );
}

export function MomentReactionSummary({
  reactions,
  total,
  onClick,
}: {
  reactions: MomentReactionCount[];
  total: number;
  onClick?: () => void;
}) {
  const { t, i18n } = useTranslation();
  const label = t('moment.reactionTotal', { count: total });
  const content = (
    <>
      <span className="flex -space-x-1.5">
        {reactions.slice(0, SUMMARY_ICONS).map(({ type }) => (
          <img
            key={type}
            src={REACTION_IMAGE[type]}
            alt=""
            className="h-5 w-5 rounded-full bg-white object-contain ring-2 ring-white"
          />
        ))}
      </span>
      {formatCompactCount(total, i18n.language)}
    </>
  );

  if (onClick == null) {
    return (
      <span
        title={label}
        className="inline-flex shrink-0 items-center gap-1 px-1 text-xs font-semibold text-black/54"
      >
        {content}
      </span>
    );
  }
  return (
    <button
      type="button"
      title={label}
      aria-label={label}
      onClick={onClick}
      className="pointer-events-auto relative inline-flex shrink-0 items-center gap-1 rounded-full bg-ola-primary-light py-1 pr-2.5 pl-1.5 text-xs font-semibold text-ola-primary-ink transition-colors hover:bg-ola-primary/15"
    >
      {content}
    </button>
  );
}
