import {
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
  type PointerEvent,
  type TouchEvent,
} from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  ConfirmDialog,
  ListOptionDialog,
  ReportDialog,
  type ListOption,
} from '@components';
import {
  REEL_HOLD_TO_PAUSE_MS,
  REEL_PREV_TAP_ZONE,
  REEL_SEEN_AFTER_MS,
  REEL_SLIDE_MS,
  REEL_STATUS,
  REEL_SWIPE_CLOSE_PX,
  REEL_SWIPE_GROUP_PX,
  REEL_TYPE,
  REPORT_TARGET_TYPE,
} from '@constants';
import {
  colorForName,
  createTimeFormatter,
  portalRoot,
  reelExpiresInMs,
  reelGroupStep,
  reelItemStep,
  reelMedia,
  toast,
} from '@lib';
import type { ReelPosition, ReelViewerSession, ReportTarget } from '@app-types';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import { useReelTray } from '@ola/shared/stores/reel/useReelTray';
import { ReelCanvas, ReelStage } from './ReelCanvas';
import {
  ReelChevronIcon,
  ReelCloseIcon,
  ReelEyeIcon,
  ReelMoreIcon,
  ReelPauseIcon,
  ReelPlayIcon,
  ReelSoundIcon,
} from './ReelIcons';
import { ReelViewersDialog } from './ReelViewersDialog';

interface PressGesture {
  x: number;
  y: number;
  holdTimer: number;
}

type MediaStatus = 'loading' | 'ready' | 'error';

interface MediaState {
  reelId: string;
  status: MediaStatus;
}

function keepTouchInViewer(event: TouchEvent) {
  event.stopPropagation();
}

interface ReelViewerProps {
  session: ReelViewerSession;
  onClose: () => void;
}

export function ReelViewer({ session, onClose }: ReelViewerProps) {
  const { t, i18n } = useTranslation();
  const markSeen = useReelStore((s) => s.markSeen);
  const removeReel = useReelStore((s) => s.remove);
  const ownReels = useReelTray().mine;
  const groups = useMemo(() => {
    const ownAuthor = session.groups[0]?.author;
    if (!session.own || ownAuthor == null) return session.groups;
    return ownReels.length > 0 ? [{ author: ownAuthor, reels: ownReels }] : [];
  }, [session, ownReels]);
  const [groupIndex, setGroupIndex] = useState(session.startIndex);
  const [itemIndex, setItemIndex] = useState(0);
  const [anchorId, setAnchorId] = useState(
    () => groups[session.startIndex]?.reels[0]?.id ?? null
  );
  const [playId, setPlayId] = useState(0);
  const [progress, setProgress] = useState(0);
  const [holding, setHolding] = useState(false);
  const [userPaused, setUserPaused] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [viewersOpen, setViewersOpen] = useState(false);
  const [confirmDelete, setConfirmDelete] = useState(false);
  const [reportTarget, setReportTarget] = useState<ReportTarget | null>(null);
  const [muted, setMuted] = useState(false);
  const [mediaState, setMediaState] = useState<MediaState | null>(null);
  const [pageHidden, setPageHidden] = useState(() => document.hidden);
  const elapsedRef = useRef(0);
  const pressRef = useRef<PressGesture | null>(null);
  const videoRef = useRef<HTMLVideoElement>(null);
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  const group = groups[groupIndex];
  const anchoredIndex = group?.reels.findIndex((item) => item.id === anchorId) ?? -1;
  const currentIndex =
    anchoredIndex >= 0 ? anchoredIndex : Math.min(itemIndex, (group?.reels.length ?? 1) - 1);
  const reel = group?.reels[currentIndex];
  const shownReelId = reel?.id;
  const [progressReelId, setProgressReelId] = useState(shownReelId);
  if (progressReelId !== shownReelId) {
    setProgressReelId(shownReelId);
    setProgress(0);
  }
  const media = useMemo(() => (reel ? reelMedia(reel) : null), [reel]);
  const mediaStatus: MediaStatus =
    media == null
      ? 'ready'
      : mediaState != null && mediaState.reelId === reel?.id
        ? mediaState.status
        : 'loading';
  const dialogOpen = menuOpen || viewersOpen || confirmDelete || reportTarget != null;
  const paused = holding || userPaused || dialogOpen || pageHidden;
  const waitingForMedia = mediaStatus === 'loading';
  const followsVideo = media?.type === REEL_TYPE.video && mediaStatus !== 'error';

  const goTo = useCallback(
    (nextGroup: number, nextItem: number) => {
      elapsedRef.current = 0;
      if (videoRef.current != null) videoRef.current.currentTime = 0;
      setProgress(0);
      setGroupIndex(nextGroup);
      setItemIndex(nextItem);
      setAnchorId(groups[nextGroup]?.reels[nextItem]?.id ?? null);
      setPlayId((id) => id + 1);
    },
    [groups]
  );

  const moveTo = useCallback(
    (position: ReelPosition | null) => {
      if (position == null) onClose();
      else goTo(position.groupIndex, position.itemIndex);
    },
    [goTo, onClose]
  );

  const jumpGroup = useCallback(
    (direction: 1 | -1) => moveTo(reelGroupStep(groups.length, groupIndex, direction)),
    [groups.length, groupIndex, moveTo]
  );

  const advance = useCallback(
    (direction: 1 | -1) =>
      moveTo(reelItemStep(groups, { groupIndex, itemIndex: currentIndex }, direction)),
    [groups, groupIndex, currentIndex, moveTo]
  );

  useEffect(() => {
    if (group == null) onClose();
  }, [group, onClose]);

  useEffect(() => {
    const onVisibility = () => setPageHidden(document.hidden);
    document.addEventListener('visibilitychange', onVisibility);
    return () => document.removeEventListener('visibilitychange', onVisibility);
  }, []);

  useEffect(() => {
    if (reel == null || pageHidden) return;
    const timer = window.setTimeout(() => advance(1), reelExpiresInMs(reel, Date.now()));
    return () => window.clearTimeout(timer);
  }, [reel, pageHidden, advance]);

  useEffect(() => {
    elapsedRef.current = 0;
  }, [shownReelId]);

  useEffect(() => {
    if (paused || reel == null || waitingForMedia) return;
    let frame = 0;
    if (followsVideo) {
      const follow = () => {
        const video = videoRef.current;
        if (video != null && video.duration > 0) {
          setProgress(video.currentTime / video.duration);
        }
        frame = requestAnimationFrame(follow);
      };
      frame = requestAnimationFrame(follow);
      return () => cancelAnimationFrame(frame);
    }
    const startedAt = performance.now() - elapsedRef.current;
    const step = (now: number) => {
      const elapsed = now - startedAt;
      elapsedRef.current = elapsed;
      if (elapsed >= REEL_SLIDE_MS) {
        advance(1);
        return;
      }
      setProgress(elapsed / REEL_SLIDE_MS);
      frame = requestAnimationFrame(step);
    };
    frame = requestAnimationFrame(step);
    return () => cancelAnimationFrame(frame);
  }, [paused, reel, playId, followsVideo, waitingForMedia, advance]);

  useEffect(() => {
    const video = videoRef.current;
    if (video == null) return;
    video.muted = muted;
    if (paused) {
      video.pause();
      return;
    }
    video.play().catch(() => {
      if (!video.muted) setMuted(true);
    });
  }, [paused, reel, muted]);

  useEffect(() => {
    if (session.own || reel == null || paused || mediaStatus !== 'ready') return;
    const id = reel.id;
    const timer = window.setTimeout(() => markSeen(id), REEL_SEEN_AFTER_MS);
    return () => window.clearTimeout(timer);
  }, [session.own, reel, paused, mediaStatus, markSeen]);

  useEffect(() => {
    if (dialogOpen) return;
    const onKey = (event: KeyboardEvent) => {
      if (event.key === 'Escape') onClose();
      else if (event.key === 'ArrowRight') advance(1);
      else if (event.key === 'ArrowLeft') advance(-1);
      else if (event.key === ' ') {
        event.preventDefault();
        setUserPaused((value) => !value);
      }
    };
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [dialogOpen, advance, onClose]);

  if (group == null || reel == null) return null;

  function handlePointerDown(event: PointerEvent<HTMLDivElement>) {
    const holdTimer = window.setTimeout(() => setHolding(true), REEL_HOLD_TO_PAUSE_MS);
    pressRef.current = { x: event.clientX, y: event.clientY, holdTimer };
  }

  function handlePointerUp(event: PointerEvent<HTMLDivElement>) {
    const press = pressRef.current;
    pressRef.current = null;
    if (press == null) return;
    window.clearTimeout(press.holdTimer);
    const wasHolding = holding;
    setHolding(false);
    const dx = event.clientX - press.x;
    const dy = event.clientY - press.y;
    if (dy > REEL_SWIPE_CLOSE_PX && Math.abs(dy) > Math.abs(dx)) {
      onClose();
      return;
    }
    if (Math.abs(dx) > REEL_SWIPE_GROUP_PX) {
      jumpGroup(dx < 0 ? 1 : -1);
      return;
    }
    if (wasHolding) return;
    const rect = event.currentTarget.getBoundingClientRect();
    advance(event.clientX - rect.left < rect.width * REEL_PREV_TAP_ZONE ? -1 : 1);
  }

  function handlePointerCancel() {
    if (pressRef.current) window.clearTimeout(pressRef.current.holdTimer);
    pressRef.current = null;
    setHolding(false);
  }

  async function deleteCurrent() {
    if (group == null || reel == null) return;
    try {
      await removeReel(reel.id);
    } catch {
      toast.error(t('reel.deleteFailed'));
      return;
    }
    toast.success(t('reel.deleted'));
    const last = group.reels.length - 1;
    if (last === 0) {
      onClose();
      return;
    }
    goTo(groupIndex, currentIndex < last ? currentIndex + 1 : currentIndex - 1);
  }

  const menuOptions: ListOption[] = session.own
    ? [
        {
          key: 'viewers',
          label: t('reel.viewers'),
          onSelect: () => setViewersOpen(true),
        },
        {
          key: 'delete',
          label: t('reel.delete'),
          danger: true,
          onSelect: () => setConfirmDelete(true),
        },
      ]
    : [
        {
          key: 'report',
          label: t('reel.report'),
          onSelect: () => setReportTarget({ type: REPORT_TARGET_TYPE.reel, id: reel.id }),
        },
      ];

  const author = group.author;
  const authorName = author.fullName || author.username;
  const isVideo = media?.type === REEL_TYPE.video;
  const processing = reel.status === REEL_STATUS.processing;
  const hasManyGroups = groups.length > 1;
  const reelId = reel.id;

  return createPortal(
    <div
      className="fixed inset-0 z-[100] flex flex-col bg-black text-white select-none"
      onTouchStart={keepTouchInViewer}
      onTouchMove={keepTouchInViewer}
      onTouchEnd={keepTouchInViewer}
    >
      <ReelStage className="sm:py-4">
        <ReelCanvas
          fit
          background={reel.background}
          media={media}
          overlays={reel.overlays}
          videoMode="controlled"
          videoRef={videoRef}
          onVideoEnded={() => advance(1)}
          onMediaReady={() => setMediaState({ reelId, status: 'ready' })}
          onMediaError={() => setMediaState({ reelId, status: 'error' })}
          className="max-sm:rounded-none"
        >
          <div
            className="absolute inset-0 touch-none"
            onPointerDown={handlePointerDown}
            onPointerUp={handlePointerUp}
            onPointerCancel={handlePointerCancel}
            onContextMenu={(event) => event.preventDefault()}
          />
          <div className="pointer-events-none absolute inset-x-0 top-0 h-28 bg-gradient-to-b from-black/55 to-transparent" />
          <div className="pointer-events-none absolute inset-x-0 top-0 px-3 pt-3">
            <div className="flex gap-1">
              {group.reels.map((item, index) => (
                <span
                  key={item.id}
                  className="h-[3px] flex-1 overflow-hidden rounded-full bg-white/35"
                >
                  <span
                    className="block h-full rounded-full bg-white"
                    style={{
                      width: `${index < currentIndex ? 100 : index === currentIndex ? progress * 100 : 0}%`,
                    }}
                  />
                </span>
              ))}
            </div>
            <div className="mt-3 flex items-center gap-2">
              <Avatar
                name={authorName}
                color={colorForName(author.username)}
                src={author.avatar ?? undefined}
                size={36}
              />
              <div className="min-w-0 flex-1">
                <p className="truncate text-sm font-semibold">{authorName}</p>
                <p className="text-xs text-white/75">
                  {formatTime(reel.createdAt)}
                </p>
              </div>
              {isVideo && (
                <button
                  type="button"
                  aria-label={muted ? t('reel.unmute') : t('reel.mute')}
                  onClick={() => setMuted((value) => !value)}
                  className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
                >
                  <ReelSoundIcon muted={muted} />
                </button>
              )}
              <button
                type="button"
                aria-label={userPaused ? t('reel.play') : t('reel.pause')}
                onClick={() => setUserPaused((value) => !value)}
                className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
              >
                {userPaused ? <ReelPlayIcon /> : <ReelPauseIcon />}
              </button>
              <button
                type="button"
                aria-label={t('reel.menu')}
                onClick={() => setMenuOpen(true)}
                className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
              >
                <ReelMoreIcon />
              </button>
              <button
                type="button"
                aria-label={t('dialog.close')}
                onClick={onClose}
                className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
              >
                <ReelCloseIcon />
              </button>
            </div>
          </div>
          {(processing || mediaStatus === 'error') && (
            <p className="pointer-events-none absolute inset-x-6 bottom-20 rounded-lg bg-black/55 px-3 py-2 text-center text-sm">
              {t(processing ? 'reel.processing' : 'reel.mediaError')}
            </p>
          )}
          {waitingForMedia && !processing && (
            <span className="pointer-events-none absolute top-1/2 left-1/2 h-8 w-8 -translate-x-1/2 -translate-y-1/2 animate-spin rounded-full border-2 border-white/30 border-t-white" />
          )}
          {session.own && (
            <button
              type="button"
              onClick={() => setViewersOpen(true)}
              className="absolute bottom-4 left-4 flex items-center gap-1.5 rounded-full bg-black/45 px-3 py-1.5 text-sm font-medium hover:bg-black/60"
            >
              <ReelEyeIcon className="h-4 w-4" />
              {t('reel.viewerCount', { count: reel.viewerCount ?? 0 })}
            </button>
          )}
        </ReelCanvas>
      </ReelStage>

      {hasManyGroups && (
        <>
          <button
            type="button"
            aria-label={t('common.prev')}
            onClick={() => jumpGroup(-1)}
            disabled={groupIndex === 0}
            className="absolute top-1/2 left-4 hidden h-11 w-11 -translate-y-1/2 items-center justify-center rounded-full bg-white/15 hover:bg-white/25 disabled:opacity-30 md:flex"
          >
            <ReelChevronIcon direction="left" className="h-6 w-6" />
          </button>
          <button
            type="button"
            aria-label={t('common.next')}
            onClick={() => jumpGroup(1)}
            className="absolute top-1/2 right-4 hidden h-11 w-11 -translate-y-1/2 items-center justify-center rounded-full bg-white/15 hover:bg-white/25 md:flex"
          >
            <ReelChevronIcon direction="right" className="h-6 w-6" />
          </button>
        </>
      )}

      <ListOptionDialog
        open={menuOpen}
        title={t('reel.menu')}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      <ReelViewersDialog
        open={viewersOpen}
        reelId={reel.id}
        onClose={() => setViewersOpen(false)}
      />
      <ConfirmDialog
        open={confirmDelete}
        title={t('reel.deleteTitle')}
        message={t('reel.deleteMessage')}
        confirmLabel={t('common.delete')}
        cancelLabel={t('common.cancel')}
        danger
        onConfirm={() => {
          setConfirmDelete(false);
          void deleteCurrent();
        }}
        onCancel={() => setConfirmDelete(false)}
      />
      {reportTarget && (
        <ReportDialog target={reportTarget} onClose={() => setReportTarget(null)} />
      )}
    </div>,
    portalRoot()
  );
}
