import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { VipIcon } from '@components';
import { formatKen } from '@lib';
import type { WheelPlayerOption, WheelPlayerSegment } from '@app-types';
import {
  giftCloseButtonUrl,
  giftCloseMarkUrl,
  spinCoinUrl,
  wheelIconUrl,
} from './spinWheelAssets';
import { giftOptionVisual } from './spinWheelReward';
import {
  GIFT_AMOUNT_STYLE,
  GIFT_SUBTITLE_STYLE,
  GIFT_TITLE_STYLE,
  TEXT_SHADOW,
} from './spinWheelStyles';

const CARD_CLASS = 'rounded-2xl border-2 border-[#ffd24a] bg-[#3457c4]';

const SCROLL_CLASS =
  'min-h-0 flex-1 overflow-y-auto pr-1 [scrollbar-color:#ffd24a_transparent] [scrollbar-width:thin] [&::-webkit-scrollbar]:w-1.5 [&::-webkit-scrollbar-track]:bg-transparent [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-thumb]:bg-[#ffd24a] hover:[&::-webkit-scrollbar-thumb]:bg-[#ffe89a]';

interface GiftListDialogProps {
  segments: WheelPlayerSegment[];
  onClose: () => void;
}

function KenRandomCard({ segment }: { segment: WheelPlayerSegment }) {
  const { t } = useTranslation();
  return (
    <div className={`${CARD_CLASS} flex items-center gap-3 px-3 py-3`}>
      <img src={spinCoinUrl} alt="" className="h-16 w-16 shrink-0" />
      <div className="flex min-w-0 flex-1 flex-col items-center gap-1 text-center">
        <span
          className="text-lg font-extrabold uppercase text-white"
          style={TEXT_SHADOW}
        >
          {t('wheelGame.kenRandomTitle')}
        </span>
        <span className="text-xl font-extrabold" style={GIFT_AMOUNT_STYLE}>
          {t('wheelGame.kenRange', {
            min: formatKen(segment.kenMin ?? 0),
            max: formatKen(segment.kenMax ?? 0),
          })}
        </span>
      </div>
    </div>
  );
}

function GiftOptionCell({ option }: { option: WheelPlayerOption }) {
  const { t } = useTranslation();
  const visual = giftOptionVisual(t, option);
  return (
    <div
      className={`${CARD_CLASS} flex min-h-16 items-center gap-2 px-2 py-2`}
    >
      <div className="flex h-12 w-12 shrink-0 items-center justify-center overflow-hidden rounded-full border-2 border-[#ffd24a] bg-[#26409e]">
        {visual.vipTypeId != null ? (
          <VipIcon typeId={visual.vipTypeId} className="h-full w-full" />
        ) : visual.iconUrl != null ? (
          <img src={visual.iconUrl} alt="" className="h-9 w-9 object-contain" />
        ) : null}
      </div>
      <span
        className="min-w-0 flex-1 text-center text-sm font-extrabold leading-tight text-white"
        style={TEXT_SHADOW}
      >
        {visual.text}
      </span>
    </div>
  );
}

function VipRandomSection({ segment }: { segment: WheelPlayerSegment }) {
  const { t } = useTranslation();
  const options = segment.options ?? [];
  return (
    <div className="flex flex-col items-center gap-2.5">
      <span
        className="rounded-full border-2 border-[#ffd24a] bg-[#1ec9a0] px-8 py-1.5 text-base font-extrabold uppercase text-white"
        style={TEXT_SHADOW}
      >
        {t('wheelGame.vipRandomTitle')}
      </span>
      <div className="grid w-full grid-cols-2 gap-2.5">
        {options.map((option, index) => (
          <GiftOptionCell key={`${segment.id}-${index}`} option={option} />
        ))}
      </div>
    </div>
  );
}

export function GiftListDialog({ segments, onClose }: GiftListDialogProps) {
  const { t } = useTranslation();

  useEffect(() => {
    function handleKey(event: KeyboardEvent) {
      if (event.key === 'Escape') onClose();
    }
    document.addEventListener('keydown', handleKey);
    return () => document.removeEventListener('keydown', handleKey);
  }, [onClose]);

  const randomSegments = segments.filter(
    (segment) =>
      segment.kind === 'ken_random' ||
      (segment.kind === 'vip_random' && (segment.options?.length ?? 0) > 0)
  );

  return (
    <div
      className="font-game fixed inset-0 z-70 flex items-center justify-center bg-black/55 px-3"
      onClick={onClose}
    >
      <div
        className="relative flex max-h-[86vh] w-[min(92vw,420px)] flex-col gap-3 rounded-[28px] border-[3px] border-[#ffd24a] bg-linear-to-b from-[#3f63d6] to-[#2743ad] p-3"
        onClick={(event) => event.stopPropagation()}
      >
        <div className="relative shrink-0 rounded-2xl border-2 border-[#ffd24a] px-13 py-2.5 text-center">
          <img
            src={wheelIconUrl}
            alt=""
            className="pointer-events-none absolute left-1 top-1/2 h-12 w-12 -translate-y-1/2"
          />
          <p className="text-xl font-extrabold" style={GIFT_TITLE_STYLE}>
            {t('wheelGame.giftListTitle')}
          </p>
          <p className="text-[10px] font-extrabold" style={GIFT_SUBTITLE_STYLE}>
            {t('wheelGame.giftListSubtitle')}
          </p>
          <img
            src={wheelIconUrl}
            alt=""
            className="pointer-events-none absolute right-1 top-1/2 h-12 w-12 -translate-y-1/2"
          />
        </div>

        <div className={`flex flex-col gap-3 ${SCROLL_CLASS}`}>
          {randomSegments.length === 0 ? (
            <p
              className="py-10 text-center text-sm font-bold text-white"
              style={TEXT_SHADOW}
            >
              {t('wheelGame.giftListEmpty')}
            </p>
          ) : (
            randomSegments.map((segment) =>
              segment.kind === 'ken_random' ? (
                <KenRandomCard key={segment.id} segment={segment} />
              ) : (
                <VipRandomSection key={segment.id} segment={segment} />
              )
            )
          )}
        </div>

        <button
          type="button"
          onClick={onClose}
          aria-label={t('wheelGame.close')}
          className="absolute -right-2 -top-2 h-11 w-11 active:scale-95"
        >
          <img
            src={giftCloseButtonUrl}
            alt=""
            className="absolute inset-0 h-full w-full"
          />
          <img
            src={giftCloseMarkUrl}
            alt=""
            className="absolute left-1/2 top-1/2 w-[42%] -translate-x-1/2 -translate-y-1/2"
          />
        </button>
      </div>
    </div>
  );
}
