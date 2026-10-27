import { useEffect, useRef, useState, type TouchEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { activeMomentGroups } from '@lib';
import type { MomentTrayGroup, MomentViewerSession } from '@app-types';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useMomentTray } from '@ola/shared/stores/moment/useMomentTray';
import { useScrollEdges } from '../useScrollEdges';
import { MomentAddCard, MomentTrayCard } from './MomentTrayCard';
import { MomentChevronIcon } from './MomentIcons';
import { MomentViewer } from './MomentViewer';
import { MomentComposer } from './MomentComposer';

const SCROLL_STEP_PX = 300;

function keepTouchInTray(event: TouchEvent) {
  event.stopPropagation();
}

export function MomentTray() {
  const { t } = useTranslation();
  const tick = useMomentStore((s) => s.tick);
  const flushSeen = useMomentStore((s) => s.flushSeen);
  const flushReactions = useMomentStore((s) => s.flushReactions);
  const loadMore = useMomentStore((s) => s.loadMore);
  const hasMore = useMomentStore((s) => s.nextCursor != null);
  const pagingBusy = useMomentStore((s) => s.loadingMore || s.refreshing);
  const tray = useMomentTray();
  const [session, setSession] = useState<MomentViewerSession | null>(null);
  const [composerOpen, setComposerOpen] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);
  const endRef = useRef<HTMLSpanElement>(null);

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
  const { canScrollPrev, canScrollNext } = useScrollEdges(
    scrollRef,
    tray.groups.length + (latestMine ? 1 : 0)
  );

  function scrollBy(direction: 1 | -1) {
    scrollRef.current?.scrollBy({
      left: direction * SCROLL_STEP_PX,
      behavior: 'smooth',
    });
  }

  function openViewer(
    groups: MomentTrayGroup[],
    authorId: string,
    own: boolean
  ) {
    const active = activeMomentGroups(groups, Date.now());
    const startIndex = active.findIndex(
      (group) => group.author.id === authorId
    );
    tick();
    if (startIndex >= 0) setSession({ groups: active, startIndex, own });
  }

  function closeViewer() {
    setSession(null);
    tick();
    void flushSeen();
    void flushReactions();
  }

  return (
    <section className="group relative mb-2 bg-white py-3 shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
      <div
        ref={scrollRef}
        onTouchStart={keepTouchInTray}
        onTouchMove={keepTouchInTray}
        onTouchEnd={keepTouchInTray}
        className="flex gap-2 overflow-x-auto px-3 [scrollbar-width:none]"
      >
        <MomentAddCard onClick={() => setComposerOpen(true)} />
        {latestMine && (
          <MomentTrayCard
            moment={latestMine}
            label={t('moment.mine')}
            ringed={false}
            onClick={() =>
              openViewer(
                [{ author: latestMine.author, moments: tray.mine }],
                latestMine.author.id,
                true
              )
            }
          />
        )}
        {tray.groups.map((group) => {
          const first = group.moments[0];
          if (!first) return null;
          return (
            <MomentTrayCard
              key={group.author.id}
              moment={first}
              label={group.author.fullName || group.author.username}
              ringed
              onClick={() => openViewer(tray.groups, group.author.id, false)}
            />
          );
        })}
        {hasMore && <span ref={endRef} className="block h-px w-px shrink-0" />}
      </div>

      {canScrollPrev && (
        <button
          type="button"
          aria-label={t('moment.scrollPrev')}
          onClick={() => scrollBy(-1)}
          className="absolute top-1/2 left-1 hidden h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white text-black/70 opacity-0 shadow-md transition group-hover:opacity-100 md:flex"
        >
          <MomentChevronIcon direction="left" />
        </button>
      )}
      {canScrollNext && (
        <button
          type="button"
          aria-label={t('moment.scrollNext')}
          onClick={() => scrollBy(1)}
          className="absolute top-1/2 right-1 hidden h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white text-black/70 opacity-0 shadow-md transition group-hover:opacity-100 md:flex"
        >
          <MomentChevronIcon direction="right" />
        </button>
      )}

      {session && <MomentViewer session={session} onClose={closeViewer} />}
      {composerOpen && (
        <MomentComposer onClose={() => setComposerOpen(false)} />
      )}
    </section>
  );
}
