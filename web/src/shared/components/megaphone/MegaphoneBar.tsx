import { useLayoutEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { MEGAPHONE_MARQUEE_SPEED_PX_PER_SEC, MEGAPHONE_MARQUEE_START_DELAY_MS } from '@constants';
import { activeVipTypeId, colorForName, megaphoneSenderName } from '@lib';
import { useCurrentMegaphone } from '@ola/shared/stores/megaphone/useCurrentMegaphone';
import type { Megaphone } from '@app-types';
import megaphoneImage from '@/assets/images/announcement-megaphone.png';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { Avatar } from '../ui/Avatar';
import { VipBadge } from '../ui/VipBadge';

const REDUCED_MOTION_QUERY = '(prefers-reduced-motion: reduce)';
const MS_PER_SECOND = 1000;

interface MegaphoneBarProps {
  clickable?: boolean;
}

export function MegaphoneBar({ clickable = true }: MegaphoneBarProps) {
  const megaphone = useCurrentMegaphone();
  if (megaphone == null) return null;
  return <MegaphoneBarItem key={megaphone.id} megaphone={megaphone} clickable={clickable} />;
}

interface MegaphoneBarItemProps {
  megaphone: Megaphone;
  clickable: boolean;
}

function MegaphoneBarItem({ megaphone, clickable }: MegaphoneBarItemProps) {
  const { t } = useTranslation();
  const openOverlay = useAppOverlayStore((s) => s.push);
  const clipRef = useRef<HTMLDivElement>(null);
  const trackRef = useRef<HTMLSpanElement>(null);
  const name = megaphoneSenderName(megaphone);
  const vipTypeId = activeVipTypeId(megaphone.sender.vipUsed, megaphone.sender.vipEndTime);

  useLayoutEffect(() => {
    const clip = clipRef.current;
    const track = trackRef.current;
    if (clip == null || track == null) return;
    const overflow = track.scrollWidth - clip.clientWidth;
    if (overflow <= 0 || window.matchMedia(REDUCED_MOTION_QUERY).matches) return;
    const animation = track.animate(
      [{ transform: 'translateX(0)' }, { transform: `translateX(${-overflow}px)` }],
      {
        duration: (overflow / MEGAPHONE_MARQUEE_SPEED_PX_PER_SEC) * MS_PER_SECOND,
        delay: MEGAPHONE_MARQUEE_START_DELAY_MS,
        easing: 'linear',
        fill: 'forwards',
      }
    );
    return () => animation.cancel();
  }, []);

  return (
    <button
      type="button"
      aria-label={clickable ? t('megaphone.open') : undefined}
      disabled={!clickable}
      onClick={() => openOverlay('megaphone')}
      className="flex h-10 w-full shrink-0 animate-ola-rise-in items-center gap-2 border-b border-ola-megaphone-line bg-ola-megaphone-soft px-2.5 text-left disabled:cursor-default"
    >
      <img src={megaphoneImage} alt="" className="h-6 w-6 shrink-0 object-contain" draggable={false} />
      <Avatar name={name} src={megaphone.sender.avatar} color={colorForName(name)} size={24} />
      <span className="flex max-w-[40%] shrink-0 items-center text-sm">
        <b className="truncate font-semibold text-ola-megaphone-ink">{name}</b>
        {vipTypeId != null && <VipBadge typeId={vipTypeId} className="ml-0.5 h-4 w-4" />}
        <span className="text-ola-megaphone-ink">:</span>
      </span>
      <div ref={clipRef} className="min-w-0 flex-1 overflow-hidden">
        <span
          ref={trackRef}
          className="inline-block whitespace-nowrap text-sm text-black/87 will-change-transform motion-reduce:block motion-reduce:truncate"
        >
          {megaphone.content}
        </span>
      </div>
    </button>
  );
}
