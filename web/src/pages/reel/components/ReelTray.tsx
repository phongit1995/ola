import { useEffect, useRef, useState, type TouchEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { activeReelGroups } from '@lib';
import type { ReelTrayGroup, ReelViewerSession } from '@app-types';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import { useReelTray } from '@ola/shared/stores/reel/useReelTray';
import { ReelAddCard, ReelTrayCard } from './ReelTrayCard';
import { ReelChevronIcon } from './ReelIcons';
import { ReelViewer } from './ReelViewer';
import { ReelComposer } from './ReelComposer';

const SCROLL_STEP_PX = 300;

type ReelTrayLayout = 'row' | 'grid';

const SECTION_CLASS: Record<ReelTrayLayout, string> = {
  row: 'group relative mb-2 bg-white py-3 shadow-[0_1px_2px_rgba(0,0,0,0.18)]',
  grid: 'mx-auto w-full max-w-3xl p-3',
};

const LIST_CLASS: Record<ReelTrayLayout, string> = {
  row: 'flex gap-2 overflow-x-auto px-3 [scrollbar-width:none]',
  grid: 'grid grid-cols-3 gap-2 sm:grid-cols-4',
};

function keepTouchInTray(event: TouchEvent) {
  event.stopPropagation();
}

export function ReelTray({ layout = 'row' }: { layout?: ReelTrayLayout }) {
  const { t } = useTranslation();
  const tick = useReelStore((s) => s.tick);
  const flushSeen = useReelStore((s) => s.flushSeen);
  const loadMore = useReelStore((s) => s.loadMore);
  const hasMore = useReelStore((s) => s.nextCursor != null);
  const pagingBusy = useReelStore((s) => s.loadingMore || s.refreshing);
  const tray = useReelTray();
  const [session, setSession] = useState<ReelViewerSession | null>(null);
  const [composerOpen, setComposerOpen] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  const endRef = useRef<HTMLSpanElement>(null);
  const fluid = layout === 'grid';

  useEffect(() => {
    const end = endRef.current;
    if (!hasMore || pagingBusy || end == null) return;
    const observer = new IntersectionObserver((entries) => {
      if (entries.some((entry) => entry.isIntersecting)) void loadMore();
    });
    observer.observe(end);
    return () => observer.disconnect();
  }, [hasMore, pagingBusy, loadMore, tray.groups.length]);

  const latestMine = tray.mine[tray.mine.length - 1];

  function scrollBy(direction: 1 | -1) {
    scrollRef.current?.scrollBy({
      left: direction * SCROLL_STEP_PX,
      behavior: 'smooth',
    });
  }

  function openViewer(groups: ReelTrayGroup[], authorId: string, own: boolean) {
    const active = activeReelGroups(groups, Date.now());
    const startIndex = active.findIndex((group) => group.author.id === authorId);
    tick();
    if (startIndex >= 0) setSession({ groups: active, startIndex, own });
  }

  function closeViewer() {
    setSession(null);
    tick();
    void flushSeen();
  }

  return (
    <section className={SECTION_CLASS[layout]}>
      <div
        ref={scrollRef}
        onTouchStart={keepTouchInTray}
        onTouchMove={keepTouchInTray}
        onTouchEnd={keepTouchInTray}
        className={LIST_CLASS[layout]}
      >
        <ReelAddCard fluid={fluid} onClick={() => setComposerOpen(true)} />
        {latestMine && (
          <ReelTrayCard
            reel={latestMine}
            label={t('reel.mine')}
            ringed={false}
            fluid={fluid}
            onClick={() =>
              openViewer(
                [{ author: latestMine.author, reels: tray.mine }],
                latestMine.author.id,
                true
              )
            }
          />
        )}
        {tray.groups.map((group) => {
          const first = group.reels[0];
          if (!first) return null;
          return (
            <ReelTrayCard
              key={group.author.id}
              reel={first}
              label={group.author.fullName || group.author.username}
              ringed
              fluid={fluid}
              onClick={() => openViewer(tray.groups, group.author.id, false)}
            />
          );
        })}
        {hasMore && (
          <span ref={endRef} className="col-span-full block h-px w-px shrink-0" />
        )}
      </div>

      {fluid && tray.groups.length === 0 && (
        <p className="px-4 py-8 text-center text-sm text-black/50">
          {t('reel.friendsEmpty')}
        </p>
      )}

      {!fluid && (
        <>
          <button
            type="button"
            aria-label={t('reel.scrollPrev')}
            onClick={() => scrollBy(-1)}
            className="absolute top-1/2 left-1 hidden h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white text-black/70 opacity-0 shadow-md transition group-hover:opacity-100 md:flex"
          >
            <ReelChevronIcon direction="left" />
          </button>
          <button
            type="button"
            aria-label={t('reel.scrollNext')}
            onClick={() => scrollBy(1)}
            className="absolute top-1/2 right-1 hidden h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white text-black/70 opacity-0 shadow-md transition group-hover:opacity-100 md:flex"
          >
            <ReelChevronIcon direction="right" />
          </button>
        </>
      )}

      {session && <ReelViewer session={session} onClose={closeViewer} />}
      {composerOpen && <ReelComposer onClose={() => setComposerOpen(false)} />}
    </section>
  );
}
