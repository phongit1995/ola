import { useLayoutEffect } from 'react';
import { useTranslation } from 'react-i18next';
import {
  selectVisibleAnnouncement,
  useAnnouncementStore,
} from '@ola/shared/stores/announcementStore';
import { useMegaphoneStore } from '@ola/shared/stores/megaphone/megaphoneStore';
import type { Megaphone } from '@app-types';
import megaphoneImage from '@/assets/images/member-megaphone.webp';
import { PillCloseButton } from '../ui/PillCloseButton';
import { isMegaphoneCovered } from './megaphoneCover';
import { MegaphoneText } from './MegaphoneText';
import { useMegaphoneMarquee } from './useMegaphoneMarquee';

const COVER_CHECK_MS = 500;

export function MegaphoneBar() {
  const megaphone = useMegaphoneStore((s) => s.current);
  const stop = useMegaphoneStore((s) => s.stop);
  const announcing = useAnnouncementStore((s) => selectVisibleAnnouncement(s) != null);
  const id = megaphone?.id;

  useLayoutEffect(() => {
    if (id == null) return;
    const stopIfCovered = () => {
      if (isMegaphoneCovered()) stop(id);
    };
    stopIfCovered();
    const timer = window.setInterval(stopIfCovered, COVER_CHECK_MS);
    return () => window.clearInterval(timer);
  }, [id, stop]);

  if (megaphone == null || announcing) return null;
  return (
    <div className="pointer-events-none absolute inset-x-6 top-14 z-50">
      <MegaphonePill key={megaphone.id} megaphone={megaphone} />
    </div>
  );
}

function MegaphonePill({ megaphone }: { megaphone: Megaphone }) {
  const { t } = useTranslation();
  const markSeen = useMegaphoneStore((s) => s.markSeen);
  const { clipRef, trackRef, startMarquee } = useMegaphoneMarquee(megaphone);
  const { id } = megaphone;

  return (
    <div
      onAnimationEnd={(event) => {
        if (event.animationName === 'ola-banner-expand') void startMarquee();
      }}
      className="mx-auto flex h-9 max-w-xs animate-ola-banner-expand items-center gap-1 overflow-hidden rounded-full bg-white pr-1 pl-3 shadow-[0_4px_14px_rgba(0,0,0,0.22)] ring-1 ring-black/10"
    >
      <img
        src={megaphoneImage}
        alt=""
        aria-hidden="true"
        className="h-6 w-6 shrink-0 object-contain select-none drop-shadow-[0_1px_2px_rgba(0,0,0,0.2)]"
        draggable={false}
      />
      <div ref={clipRef} className="flex h-full min-w-0 flex-1 items-center overflow-hidden text-left">
        <span
          ref={trackRef}
          className="inline-flex items-center gap-1 text-sm whitespace-nowrap will-change-transform motion-reduce:flex motion-reduce:truncate"
        >
          <MegaphoneText megaphone={megaphone} />
        </span>
      </div>
      <PillCloseButton label={t('megaphone.dismiss')} onClick={() => markSeen(id)} />
    </div>
  );
}
