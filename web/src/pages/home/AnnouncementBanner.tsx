import { useLayoutEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { selectVisibleAnnouncement } from '@ola/shared/stores/announcementStore';
import { useAnnouncementStore } from '@/store/announcementStore';
import announcementMegaphone from '@/assets/images/announcement-megaphone.png';

const MARQUEE_SPEED_PX_PER_SECOND = 40;
const MARQUEE_MIN_DURATION_SECONDS = 8;
const MARQUEE_MAX_DURATION_SECONDS = 45;

export function AnnouncementBanner() {
  const { t } = useTranslation();
  const announcement = useAnnouncementStore((s) => s.announcement);
  const visible = useAnnouncementStore(selectVisibleAnnouncement);
  const detailOpen = useAnnouncementStore((s) => s.detailOpen);
  const openDetail = useAnnouncementStore((s) => s.openDetail);
  const closeDetail = useAnnouncementStore((s) => s.closeDetail);
  const hide = useAnnouncementStore((s) => s.hide);
  const dismiss = useAnnouncementStore((s) => s.dismiss);
  const marqueeRef = useRef<HTMLSpanElement>(null);

  const applyMarqueeMetrics = () => {
    const marquee = marqueeRef.current;
    const clip = marquee?.parentElement;
    if (marquee == null || clip == null || clip.clientWidth <= 0) return;
    const clipWidth = clip.clientWidth;
    const textWidth = marquee.scrollWidth;
    const durationSeconds = Math.min(
      MARQUEE_MAX_DURATION_SECONDS,
      Math.max(
        MARQUEE_MIN_DURATION_SECONDS,
        (clipWidth + textWidth) / MARQUEE_SPEED_PX_PER_SECOND,
      ),
    );
    marquee.style.setProperty('--ola-marquee-from', `${clipWidth}px`);
    marquee.style.setProperty('--ola-marquee-to', `${-textWidth}px`);
    marquee.style.animationDuration = `${durationSeconds}s`;
  };

  useLayoutEffect(applyMarqueeMetrics, [visible]);

  if (announcement == null) return null;

  return (
    <>
      {visible != null && (
      <div className="pointer-events-none absolute inset-x-6 top-14 z-50">
        <div
          onAnimationEnd={(event) => {
            if (event.animationName === 'ola-banner-expand') applyMarqueeMetrics();
          }}
          className="pointer-events-auto mx-auto flex h-9 max-w-xs animate-ola-banner-expand items-center gap-1 overflow-hidden rounded-full bg-white/95 pl-3 pr-1 shadow-[0_4px_14px_rgba(0,0,0,0.22)] ring-1 ring-black/10"
        >
          <img
            src={announcementMegaphone}
            alt=""
            aria-hidden="true"
            className="h-6 w-6 shrink-0 select-none drop-shadow-[0_1px_2px_rgba(0,0,0,0.2)]"
            draggable={false}
          />
          <button
            type="button"
            onClick={openDetail}
            className="block min-w-0 flex-1 overflow-hidden text-left"
          >
            <span
              ref={marqueeRef}
              onAnimationEnd={(event) => {
                if (event.animationName === 'ola-marquee') hide();
              }}
              className="inline-block min-w-full animate-ola-marquee-once whitespace-nowrap text-sm font-semibold text-ola-primary-ink will-change-transform"
            >
              {visible.title}
            </span>
          </button>
          <button
            type="button"
            onClick={dismiss}
            aria-label={t('announcement.dismiss')}
            className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-ola-primary-ink/70 transition-colors hover:bg-black/10"
          >
            <svg
              viewBox="0 0 24 24"
              className="h-3.5 w-3.5"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              aria-hidden="true"
            >
              <path d="M6 6l12 12M18 6L6 18" strokeLinecap="round" />
            </svg>
          </button>
        </div>
      </div>
      )}
      <Dialog
        open={detailOpen}
        onClose={closeDetail}
        title={t('announcement.detailTitle')}
        showClose
        footer={
          announcement.link ? (
            <DialogButton
              variant="green"
              onClick={() =>
                window.open(announcement.link, '_blank', 'noopener,noreferrer')
              }
            >
              {t('announcement.openLink')}
            </DialogButton>
          ) : undefined
        }
      >
        <p className="mb-1 font-bold text-[#3a3839]">{announcement.title}</p>
        {announcement.content && (
          <p className="whitespace-pre-line">{announcement.content}</p>
        )}
      </Dialog>
    </>
  );
}
