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
  ListOptionDialog,
  ReportDialog,
  type ListOption,
} from '@components';
import {
  MOMENT_HOLD_TO_PAUSE_MS,
  MOMENT_PREV_TAP_ZONE,
  MOMENT_SEEN_AFTER_MS,
  MOMENT_SLIDE_MS,
  MOMENT_SWIPE_CLOSE_PX,
  MOMENT_SWIPE_GROUP_PX,
  MOMENT_TURN_EDGE_RESISTANCE,
  MOMENT_TURN_MIN_FRACTION,
  MOMENT_TURN_MS,
  MOMENT_TYPE,
  REPORT_TARGET_TYPE,
} from '@constants';
import {
  createTimeFormatter,
  isMomentHiddenByAdmin,
  portalRoot,
  momentExpiresInMs,
  momentGroupStep,
  momentItemStep,
  momentMedia,
  momentPreloadUrl,
} from '@lib';
import type { MomentPosition, MomentViewerSession, ReportTarget } from '@app-types';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useMomentHiddenToggle } from '@ola/shared/stores/moment/useMomentHiddenToggle';
import { useMomentTray } from '@ola/shared/stores/moment/useMomentTray';
import { useMomentViewerGroups } from '@ola/shared/stores/moment/useMomentViewerGroups';
import { MOMENT_FIT_STYLE } from '../constants';
import type { MomentMediaStatus } from '../types';
import { MomentStage } from './MomentCanvas';
import { MomentChevronIcon } from './MomentIcons';
import { MomentViewerFace } from './MomentViewerFace';

const DRAG_START_PX = 10;

interface PressGesture {
  x: number;
  y: number;
  width: number;
  axis: 'x' | 'y' | null;
  holdTimer: number;
}

function keepTouchInViewer(event: TouchEvent) {
  event.stopPropagation();
}

function easeOutCubic(value: number): number {
  return 1 - (1 - value) ** 3;
}

interface MomentViewerProps {
  session: MomentViewerSession;
  onClose: () => void;
}

export function MomentViewer({ session, onClose }: MomentViewerProps) {
  const { t, i18n } = useTranslation();
  const markSeen = useMomentStore((s) => s.markSeen);
  const react = useMomentStore((s) => s.react);
  const history = useMomentStore((s) => s.history);
  const ownMoments = useMomentTray().mine;
  const baseGroups = useMemo(() => {
    const ownAuthor = session.groups[0]?.author;
    if (!session.own || ownAuthor == null) return session.groups;
    const moments = session.archive ? history : ownMoments;
    return moments.length > 0 ? [{ author: ownAuthor, moments }] : [];
  }, [session, ownMoments, history]);
  const { toggleHidden } = useMomentHiddenToggle();
  const [groupIndex, setGroupIndex] = useState(session.startIndex);
  const groups = useMomentViewerGroups(baseGroups, groupIndex, !session.own);
  const [itemIndex, setItemIndex] = useState(0);
  const [anchorId, setAnchorId] = useState(
    () => session.startMomentId ?? groups[session.startIndex]?.moments[0]?.id ?? null
  );
  const [playId, setPlayId] = useState(0);
  const [progress, setProgress] = useState(0);
  const [shift, setShift] = useState(0);
  const [turning, setTurning] = useState(false);
  const [holding, setHolding] = useState(false);
  const [userPaused, setUserPaused] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [reportTarget, setReportTarget] = useState<ReportTarget | null>(null);
  const [muted, setMuted] = useState(false);
  const [mediaStatuses, setMediaStatuses] = useState<Record<string, MomentMediaStatus>>({});
  const [pageHidden, setPageHidden] = useState(() => document.hidden);
  const elapsedRef = useRef(0);
  const pressRef = useRef<PressGesture | null>(null);
  const turnRef = useRef({ frame: 0 });
  const videoRef = useRef<HTMLVideoElement>(null);
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  const group = groups[groupIndex];
  const anchoredIndex = group?.moments.findIndex((item) => item.id === anchorId) ?? -1;
  const currentIndex =
    anchoredIndex >= 0 ? anchoredIndex : Math.min(itemIndex, (group?.moments.length ?? 1) - 1);
  const moment = group?.moments[currentIndex];
  const shownMomentId = moment?.id;
  const [progressMomentId, setProgressMomentId] = useState(shownMomentId);
  if (progressMomentId !== shownMomentId) {
    setProgressMomentId(shownMomentId);
    setProgress(0);
  }
  const media = useMemo(() => (moment ? momentMedia(moment) : null), [moment]);
  const mediaStatus: MomentMediaStatus =
    media == null || moment == null ? 'ready' : (mediaStatuses[moment.id] ?? 'loading');
  const upcoming = group?.moments[currentIndex + 1];
  const preloadUrl = upcoming ? momentPreloadUrl(upcoming) : undefined;
  const dialogOpen = menuOpen || reportTarget != null;
  const paused = holding || turning || userPaused || dialogOpen || pageHidden;
  const waitingForMedia = mediaStatus === 'loading';
  const followsVideo = media?.type === MOMENT_TYPE.video && mediaStatus !== 'error';
  const hasPrev = groupIndex > 0;
  const hasNext = groupIndex < groups.length - 1;

  const goTo = useCallback(
    (nextGroup: number, nextItem: number) => {
      elapsedRef.current = 0;
      if (videoRef.current != null) videoRef.current.currentTime = 0;
      setProgress(0);
      setGroupIndex(nextGroup);
      setItemIndex(nextItem);
      setAnchorId(groups[nextGroup]?.moments[nextItem]?.id ?? null);
      setPlayId((id) => id + 1);
    },
    [groups]
  );

  const turn = useCallback(
    (from: number, direction: 1 | -1 | 0) => {
      const state = turnRef.current;
      cancelAnimationFrame(state.frame);
      setTurning(true);
      const duration =
        MOMENT_TURN_MS * Math.max(Math.abs(direction - from), MOMENT_TURN_MIN_FRACTION);
      const startedAt = performance.now();
      const step = (now: number) => {
        const done = Math.min(1, (now - startedAt) / duration);
        if (done < 1) {
          setShift(from + (direction - from) * easeOutCubic(done));
          state.frame = requestAnimationFrame(step);
          return;
        }
        setShift(0);
        setTurning(false);
        if (direction !== 0) goTo(groupIndex + direction, 0);
      };
      state.frame = requestAnimationFrame(step);
    },
    [goTo, groupIndex]
  );

  const moveTo = useCallback(
    (position: MomentPosition | null) => {
      if (turning) return;
      if (position == null) onClose();
      else if (Math.abs(position.groupIndex - groupIndex) === 1) {
        turn(0, position.groupIndex > groupIndex ? 1 : -1);
      } else goTo(position.groupIndex, position.itemIndex);
    },
    [turning, groupIndex, turn, goTo, onClose]
  );

  const jumpGroup = useCallback(
    (direction: 1 | -1) => moveTo(momentGroupStep(groups.length, groupIndex, direction)),
    [groups.length, groupIndex, moveTo]
  );

  const advance = useCallback(
    (direction: 1 | -1) =>
      moveTo(momentItemStep(groups, { groupIndex, itemIndex: currentIndex }, direction)),
    [groups, groupIndex, currentIndex, moveTo]
  );

  const recordMediaStatus = useCallback((momentId: string, status: MomentMediaStatus) => {
    setMediaStatuses((current) =>
      current[momentId] === status ? current : { ...current, [momentId]: status }
    );
  }, []);

  useEffect(() => {
    const state = turnRef.current;
    return () => cancelAnimationFrame(state.frame);
  }, []);

  useEffect(() => {
    if (group == null) onClose();
  }, [group, onClose]);

  useEffect(() => {
    const onVisibility = () => setPageHidden(document.hidden);
    document.addEventListener('visibilitychange', onVisibility);
    return () => document.removeEventListener('visibilitychange', onVisibility);
  }, []);

  useEffect(() => {
    if (!preloadUrl) return;
    const image = new Image();
    image.src = preloadUrl;
  }, [preloadUrl]);

  useEffect(() => {
    if (moment == null || pageHidden || session.archive) return;
    const timer = window.setTimeout(() => advance(1), momentExpiresInMs(moment, Date.now()));
    return () => window.clearTimeout(timer);
  }, [moment, pageHidden, session.archive, advance]);

  useEffect(() => {
    elapsedRef.current = 0;
  }, [shownMomentId]);

  useEffect(() => {
    if (paused || moment == null || waitingForMedia) return;
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
      if (elapsed >= MOMENT_SLIDE_MS) {
        advance(1);
        return;
      }
      setProgress(elapsed / MOMENT_SLIDE_MS);
      frame = requestAnimationFrame(step);
    };
    frame = requestAnimationFrame(step);
    return () => cancelAnimationFrame(frame);
  }, [paused, moment, playId, followsVideo, waitingForMedia, advance]);

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
  }, [paused, moment, muted]);

  useEffect(() => {
    if (session.own || moment == null || paused || mediaStatus !== 'ready') return;
    const id = moment.id;
    const timer = window.setTimeout(() => markSeen(id), MOMENT_SEEN_AFTER_MS);
    return () => window.clearTimeout(timer);
  }, [session.own, moment, paused, mediaStatus, markSeen]);

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

  if (group == null || moment == null) return null;

  function dragShift(dx: number, width: number): number {
    const raw = Math.max(-1, Math.min(1, -dx / width));
    const blocked = (raw > 0 && !hasNext) || (raw < 0 && !hasPrev);
    return blocked ? raw * MOMENT_TURN_EDGE_RESISTANCE : raw;
  }

  function releaseTurn(dx: number, width: number) {
    const from = dragShift(dx, width);
    const direction = dx < 0 ? 1 : -1;
    if (Math.abs(dx) > MOMENT_SWIPE_GROUP_PX) {
      const target = momentGroupStep(groups.length, groupIndex, direction);
      if (target == null) {
        onClose();
        return;
      }
      if (target.groupIndex !== groupIndex) {
        turn(from, direction);
        return;
      }
    }
    turn(from, 0);
  }

  function handlePointerDown(event: PointerEvent<HTMLDivElement>) {
    if (turning) return;
    event.currentTarget.setPointerCapture(event.pointerId);
    const holdTimer = window.setTimeout(() => setHolding(true), MOMENT_HOLD_TO_PAUSE_MS);
    pressRef.current = {
      x: event.clientX,
      y: event.clientY,
      width: event.currentTarget.clientWidth,
      axis: null,
      holdTimer,
    };
  }

  function handlePointerMove(event: PointerEvent<HTMLDivElement>) {
    const press = pressRef.current;
    if (press == null) return;
    const dx = event.clientX - press.x;
    const dy = event.clientY - press.y;
    if (press.axis == null) {
      if (Math.hypot(dx, dy) < DRAG_START_PX) return;
      press.axis = Math.abs(dx) > Math.abs(dy) ? 'x' : 'y';
      window.clearTimeout(press.holdTimer);
      setHolding(true);
    }
    if (press.axis === 'x') setShift(dragShift(dx, press.width));
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
    if (press.axis === 'x') {
      releaseTurn(dx, press.width);
      return;
    }
    if (press.axis === 'y') {
      if (dy > MOMENT_SWIPE_CLOSE_PX) onClose();
      return;
    }
    if (wasHolding) return;
    const rect = event.currentTarget.getBoundingClientRect();
    advance(event.clientX - rect.left < rect.width * MOMENT_PREV_TAP_ZONE ? -1 : 1);
  }

  function handlePointerCancel() {
    const press = pressRef.current;
    pressRef.current = null;
    if (press == null) return;
    window.clearTimeout(press.holdTimer);
    setHolding(false);
    if (press.axis === 'x') turn(shift, 0);
  }

  const menuOptions: ListOption[] = session.own
    ? [
        {
          key: 'hidden',
          label: t(moment.hidden === true ? 'moment.unhide' : 'moment.hide'),
          onSelect: () => void toggleHidden(moment),
        },
      ]
    : [
        {
          key: 'report',
          label: t('moment.report'),
          onSelect: () => setReportTarget({ type: REPORT_TARGET_TYPE.moment, id: moment.id }),
        },
      ];

  const hasManyGroups = groups.length > 1;
  const faceIndexes = [groupIndex - 1, groupIndex, groupIndex + 1].filter(
    (index) => index >= 0 && index < groups.length
  );

  return createPortal(
    <div
      className="fixed inset-0 z-[100] flex flex-col bg-black text-white select-none"
      onTouchStart={keepTouchInViewer}
      onTouchMove={keepTouchInViewer}
      onTouchEnd={keepTouchInViewer}
    >
      <MomentStage className="sm:py-4">
        <div className="relative" style={MOMENT_FIT_STYLE}>
          <div
            className="absolute inset-0 touch-none"
            onPointerDown={handlePointerDown}
            onPointerMove={handlePointerMove}
            onPointerUp={handlePointerUp}
            onPointerCancel={handlePointerCancel}
            onContextMenu={(event) => event.preventDefault()}
          />
          {faceIndexes.map((index) => {
            const faceGroup = groups[index];
            const active = index === groupIndex;
            const faceMoment = active ? moment : faceGroup?.moments[0];
            if (faceGroup == null || faceMoment == null) return null;
            return (
              <MomentViewerFace
                key={index}
                author={faceGroup.author}
                moments={faceGroup.moments}
                moment={faceMoment}
                itemIndex={active ? currentIndex : 0}
                offset={index - groupIndex - shift}
                active={active}
                progress={active ? progress : 0}
                mediaStatus={mediaStatus}
                time={formatTime(faceMoment.createdAt)}
                muted={muted}
                paused={userPaused}
                videoRef={videoRef}
                onVideoEnded={() => advance(1)}
                onMediaStatus={recordMediaStatus}
                onToggleMute={() => setMuted((value) => !value)}
                onTogglePause={() => setUserPaused((value) => !value)}
                onOpenMenu={
                  session.own && isMomentHiddenByAdmin(faceMoment) ? undefined : () => setMenuOpen(true)
                }
                onReact={session.own ? undefined : (type) => react(faceMoment.id, type)}
                onClose={onClose}
              />
            );
          })}
        </div>
      </MomentStage>

      {hasManyGroups && (
        <>
          <button
            type="button"
            aria-label={t('common.prev')}
            onClick={() => jumpGroup(-1)}
            disabled={groupIndex === 0}
            className="absolute top-1/2 left-4 hidden h-11 w-11 -translate-y-1/2 items-center justify-center rounded-full bg-white/15 hover:bg-white/25 disabled:opacity-30 md:flex"
          >
            <MomentChevronIcon direction="left" className="h-6 w-6" />
          </button>
          <button
            type="button"
            aria-label={t('common.next')}
            onClick={() => jumpGroup(1)}
            className="absolute top-1/2 right-4 hidden h-11 w-11 -translate-y-1/2 items-center justify-center rounded-full bg-white/15 hover:bg-white/25 md:flex"
          >
            <MomentChevronIcon direction="right" className="h-6 w-6" />
          </button>
        </>
      )}

      <ListOptionDialog
        open={menuOpen}
        title={t('moment.menu')}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      {reportTarget && (
        <ReportDialog target={reportTarget} onClose={() => setReportTarget(null)} />
      )}
    </div>,
    portalRoot()
  );
}
