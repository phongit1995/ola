import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import olaLogo from '@/assets/images/ola-logo.png';
import { PillCloseButton } from '@components';
import { createTimeFormatter } from '@lib';
import {
  announcementPublishedAt,
  selectFeedAnnouncement,
  useAnnouncementStore,
} from '@ola/shared/stores/announcementStore';
import { PostContent } from './PostContent';

export function MeAnnouncementCard() {
  const { t, i18n } = useTranslation();
  const announcement = useAnnouncementStore(selectFeedAnnouncement);
  const dismissFromFeed = useAnnouncementStore((s) => s.dismissFromFeed);
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  if (announcement == null) return null;

  return (
    <article className="mb-2 bg-ola-primary-light pb-3 shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
      <div className="flex items-start gap-4 px-4 pt-4">
        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-ola-primary">
          <img src={olaLogo} alt="" className="h-6 w-6 object-contain" />
        </span>
        <div className="min-w-0 flex-1">
          <div className="flex items-center gap-1">
            <span className="truncate text-base text-black/87">
              {t('announcement.feedAuthor')}
            </span>
            <span className="flex h-3.5 w-3.5 shrink-0 items-center justify-center rounded-full bg-ola-primary text-[9px] leading-none font-bold text-ola-on-primary">
              ✓
            </span>
            <span className="ml-1 shrink-0 rounded-full bg-ola-primary px-2 py-px text-[11px] font-medium text-ola-on-primary">
              {t('announcement.feedBadge')}
            </span>
          </div>
          <span className="mt-0.5 block text-xs text-black/54">
            {formatTime(announcementPublishedAt(announcement))}
          </span>
        </div>
        <PillCloseButton
          label={t('announcement.dismiss')}
          onClick={dismissFromFeed}
        />
      </div>

      <p className="px-4 pt-3 text-sm font-bold text-black/87">
        {announcement.title}
      </p>
      {announcement.content !== '' && (
        <PostContent
          key={announcement.id}
          content={announcement.content}
          onMention={() => undefined}
          collapsible
        />
      )}
      {announcement.link !== '' && (
        <button
          type="button"
          onClick={() =>
            window.open(announcement.link, '_blank', 'noopener,noreferrer')
          }
          className="mt-2 px-4 text-sm font-medium text-ola-primary-ink"
        >
          {t('announcement.feedOpenLink')}
        </button>
      )}
    </article>
  );
}
