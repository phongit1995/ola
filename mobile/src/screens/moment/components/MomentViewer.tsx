import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AppState, StatusBar, StyleSheet, useWindowDimensions, View } from 'react-native';
import FastImage from '@d11/react-native-fast-image';
import { Gesture, GestureDetector, GestureHandlerRootView } from 'react-native-gesture-handler';
import Animated, {
  cancelAnimation,
  Easing,
  runOnJS,
  useAnimatedStyle,
  useSharedValue,
  withTiming,
} from 'react-native-reanimated';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
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
} from '@ola/shared/constants';
import {
  createTimeFormatter,
  isMomentHiddenByAdmin,
  momentExpiresInMs,
  momentGroupEntryStep,
  momentGroupStartIndex,
  momentItemStep,
  momentMedia,
  momentPreloadUrl,
} from '@ola/shared/lib';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useMomentHiddenToggle } from '@ola/shared/stores/moment/useMomentHiddenToggle';
import { useMomentTray } from '@ola/shared/stores/moment/useMomentTray';
import { useMomentViewerGroups } from '@ola/shared/stores/moment/useMomentViewerGroups';
import type { MomentAuthor, MomentPosition, MomentViewerSession, ReportTarget } from '@ola/shared/types';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { OlaModal } from '@components/ui/OlaModal';
import { ReportDialog } from '@components/ui/ReportDialog';
import { ToastHost } from '@components/ui/ToastHost';
import { releaseVoicePlayback } from '@lib/voicePlaybackSession';
import { MOMENT_ASPECT_RATIO, MOMENT_TURN_FLING_VELOCITY } from '../constants';
import { MomentViewerFace, type MomentMediaStatus } from './MomentViewerFace';

const SWIPE_MIN_DISTANCE_PX = 10;
const AXIS_NONE = 0;
const AXIS_X = 1;
const AXIS_Y = 2;
const TURN_EASING = Easing.out(Easing.cubic);

interface MomentViewerProps {
  session: MomentViewerSession;
  onClose: () => void;
  onOpenProfile?: (author: MomentAuthor) => void;
}

function MomentViewerContent({ session, onClose, onOpenProfile }: MomentViewerProps) {
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();
  const window = useWindowDimensions();
  const markSeen = useMomentStore((s) => s.markSeen);
  const react = useMomentStore((s) => s.react);
  const history = useMomentStore((s) => s.history);
  const seenIds = useMomentStore((s) => s.seenIds);
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
  const [anchorId, setAnchorId] = useState(() => {
    if (session.startMomentId != null) return session.startMomentId;
    const start = groups[session.startIndex];
    return start?.moments[momentGroupStartIndex(start, seenIds)]?.id ?? null;
  });
  const seenStep = useMemo(
    () => (session.own ? undefined : { seenIds, unseenOnly: session.unseenOnly === true }),
    [session.own, session.unseenOnly, seenIds]
  );
  const [playId, setPlayId] = useState(0);
  const [holding, setHolding] = useState(false);
  const [turning, setTurning] = useState(false);
  const [userPaused, setUserPaused] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [reportTarget, setReportTarget] = useState<ReportTarget | null>(null);
  const [muted, setMuted] = useState(false);
  const [mediaStatuses, setMediaStatuses] = useState<Record<string, MomentMediaStatus>>({});
  const [appActive, setAppActive] = useState(() => AppState.currentState === 'active');
  const progress = useSharedValue(0);
  const position = useSharedValue(session.startIndex);
  const axis = useSharedValue(AXIS_NONE);
  const dragY = useSharedValue(0);
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const group = groups[groupIndex];
  const anchoredIndex = group?.moments.findIndex((item) => item.id === anchorId) ?? -1;
  const currentIndex =
    anchoredIndex >= 0 ? anchoredIndex : Math.min(itemIndex, (group?.moments.length ?? 1) - 1);
  const moment = group?.moments[currentIndex];
  const shownMomentId = moment?.id;
  const media = useMemo(() => (moment ? momentMedia(moment) : null), [moment]);
  const isVideo = media?.type === MOMENT_TYPE.video;
  const mediaStatus: MomentMediaStatus =
    media == null || moment == null ? 'ready' : (mediaStatuses[moment.id] ?? 'loading');
  const upcoming = group?.moments[currentIndex + 1];
  const preloadUrl = upcoming ? momentPreloadUrl(upcoming) : undefined;
  const dialogOpen = menuOpen || reportTarget != null;
  const paused = holding || turning || userPaused || dialogOpen || !appActive;
  const waitingForMedia = mediaStatus === 'loading';
  const timedBySlide = !isVideo || mediaStatus === 'error';
  const hasPrev = groupIndex > 0;
  const hasNext = groupIndex < groups.length - 1;

  const availableHeight = window.height - insets.top - insets.bottom;
  const canvasWidth = Math.min(window.width, availableHeight * MOMENT_ASPECT_RATIO);
  const canvasHeight = canvasWidth / MOMENT_ASPECT_RATIO;

  const goTo = useCallback(
    (nextGroup: number, nextItem: number) => {
      cancelAnimation(progress);
      progress.value = 0;
      position.value = nextGroup;
      setGroupIndex(nextGroup);
      setItemIndex(nextItem);
      setAnchorId(groups[nextGroup]?.moments[nextItem]?.id ?? null);
      setPlayId((id) => id + 1);
    },
    [groups, progress, position]
  );

  const settleTurn = useCallback(
    (target: number, targetItem: number) => {
      setTurning(false);
      goTo(target, targetItem);
    },
    [goTo]
  );

  const turnTo = useCallback(
    (target: number, targetItem: number) => {
      setTurning(true);
      const duration = MOMENT_TURN_MS * Math.max(Math.abs(target - position.value), MOMENT_TURN_MIN_FRACTION);
      position.value = withTiming(target, { duration, easing: TURN_EASING }, (finished) => {
        if (finished) runOnJS(settleTurn)(target, targetItem);
        else runOnJS(setTurning)(false);
      });
    },
    [position, settleTurn]
  );

  const snapBack = useCallback(() => {
    const duration = MOMENT_TURN_MS * Math.max(Math.abs(groupIndex - position.value), MOMENT_TURN_MIN_FRACTION);
    position.value = withTiming(groupIndex, { duration, easing: TURN_EASING });
  }, [groupIndex, position]);

  const moveTo = useCallback(
    (next: MomentPosition | null) => {
      if (turning) return;
      if (next == null) onClose();
      else if (Math.abs(next.groupIndex - groupIndex) === 1) turnTo(next.groupIndex, next.itemIndex);
      else goTo(next.groupIndex, next.itemIndex);
    },
    [turning, groupIndex, turnTo, goTo, onClose]
  );

  const advance = useCallback(
    (direction: 1 | -1) =>
      moveTo(momentItemStep(groups, { groupIndex, itemIndex: currentIndex }, direction, seenStep)),
    [groups, groupIndex, currentIndex, seenStep, moveTo]
  );

  const advanceRef = useRef(advance);
  const advanceNext = useCallback(() => advanceRef.current(1), []);

  const recordMediaStatus = useCallback((momentId: string, status: MomentMediaStatus) => {
    setMediaStatuses((current) => (current[momentId] === status ? current : { ...current, [momentId]: status }));
  }, []);

  const followVideo = useCallback(
    (value: number) => {
      progress.value = value;
    },
    [progress]
  );

  useEffect(() => {
    advanceRef.current = advance;
  }, [advance]);

  useEffect(() => {
    releaseVoicePlayback();
  }, []);

  useEffect(() => {
    if (group == null) onClose();
  }, [group, onClose]);

  useEffect(() => {
    const subscription = AppState.addEventListener('change', (state) => {
      setAppActive(state === 'active');
    });
    return () => subscription.remove();
  }, []);

  useEffect(() => {
    if (preloadUrl) FastImage.preload([{ uri: preloadUrl }]);
  }, [preloadUrl]);

  useEffect(() => {
    if (moment == null || !appActive || session.archive) return;
    const timer = setTimeout(advanceNext, momentExpiresInMs(moment, Date.now()));
    return () => clearTimeout(timer);
  }, [moment, appActive, session.archive, advanceNext]);

  useEffect(() => {
    cancelAnimation(progress);
    progress.value = 0;
  }, [shownMomentId, progress]);

  useEffect(() => {
    if (moment == null || !timedBySlide || paused || waitingForMedia) return;
    const remaining = MOMENT_SLIDE_MS * (1 - progress.value);
    progress.value = withTiming(1, { duration: remaining, easing: Easing.linear }, (finished) => {
      if (finished) runOnJS(advanceNext)();
    });
    return () => cancelAnimation(progress);
  }, [moment, playId, timedBySlide, paused, waitingForMedia, progress, advanceNext]);

  useEffect(() => {
    if (session.own || moment == null || paused || mediaStatus !== 'ready') return;
    const id = moment.id;
    const timer = setTimeout(() => markSeen(id), MOMENT_SEEN_AFTER_MS);
    return () => clearTimeout(timer);
  }, [session.own, moment, paused, mediaStatus, markSeen]);

  const handleTap = useCallback(
    (x: number) => advance(x < canvasWidth * MOMENT_PREV_TAP_ZONE ? -1 : 1),
    [advance, canvasWidth]
  );

  const handleClose = useCallback(
    (dx: number, dy: number) => {
      if (dy > MOMENT_SWIPE_CLOSE_PX && Math.abs(dy) > Math.abs(dx)) onClose();
    },
    [onClose]
  );

  const releaseTurn = useCallback(
    (dx: number, velocityX: number) => {
      const direction = dx < 0 ? 1 : -1;
      const flung = Math.abs(velocityX) > MOMENT_TURN_FLING_VELOCITY && Math.sign(velocityX) === Math.sign(dx);
      if (Math.abs(dx) > MOMENT_SWIPE_GROUP_PX || flung) {
        const target = momentGroupEntryStep(groups, groupIndex, direction, seenIds);
        if (target == null) {
          onClose();
          return;
        }
        if (target.groupIndex !== groupIndex) {
          turnTo(target.groupIndex, target.itemIndex);
          return;
        }
      }
      snapBack();
    },
    [groups, groupIndex, seenIds, onClose, turnTo, snapBack]
  );

  const gesture = useMemo(() => {
    const tap = Gesture.Tap()
      .maxDuration(MOMENT_HOLD_TO_PAUSE_MS)
      .onEnd((event, success) => {
        if (success) runOnJS(handleTap)(event.x);
      });
    const hold = Gesture.LongPress()
      .minDuration(MOMENT_HOLD_TO_PAUSE_MS)
      .onStart(() => runOnJS(setHolding)(true))
      .onEnd(() => runOnJS(setHolding)(false));
    const swipe = Gesture.Pan()
      .enabled(!turning)
      .minDistance(SWIPE_MIN_DISTANCE_PX)
      .onStart((event) => {
        axis.value = Math.abs(event.translationX) > Math.abs(event.translationY) ? AXIS_X : AXIS_Y;
        runOnJS(setHolding)(true);
      })
      .onUpdate((event) => {
        if (axis.value === AXIS_X) {
          const raw = Math.max(-1, Math.min(1, -event.translationX / canvasWidth));
          const blocked = (raw > 0 && !hasNext) || (raw < 0 && !hasPrev);
          position.value = groupIndex + (blocked ? raw * MOMENT_TURN_EDGE_RESISTANCE : raw);
        } else {
          dragY.value = Math.max(0, event.translationY);
        }
      })
      .onEnd((event, success) => {
        runOnJS(setHolding)(false);
        if (axis.value === AXIS_X) runOnJS(releaseTurn)(success ? event.translationX : 0, event.velocityX);
        else if (success) runOnJS(handleClose)(event.translationX, event.translationY);
      })
      .onFinalize(() => {
        axis.value = AXIS_NONE;
        dragY.value = withTiming(0);
      });
    return Gesture.Race(swipe, hold, tap);
  }, [
    turning,
    canvasWidth,
    hasPrev,
    hasNext,
    groupIndex,
    handleTap,
    handleClose,
    releaseTurn,
    axis,
    position,
    dragY,
  ]);

  const dragStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: dragY.value }],
    opacity: 1 - Math.min(dragY.value / (MOMENT_SWIPE_CLOSE_PX * 4), 0.5),
  }));

  if (group == null || moment == null) return null;

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

  const faceIndexes = [groupIndex - 1, groupIndex, groupIndex + 1].filter(
    (index) => index >= 0 && index < groups.length,
  );

  return (
    <View style={{ flex: 1, backgroundColor: '#000000' }}>
      <StatusBar barStyle="light-content" />
      <Animated.View
        style={[
          { flex: 1, alignItems: 'center', justifyContent: 'center', paddingTop: insets.top, paddingBottom: insets.bottom },
          dragStyle,
        ]}
      >
        <View style={{ width: canvasWidth, height: canvasHeight }}>
          <GestureDetector gesture={gesture}>
            <View collapsable={false} style={StyleSheet.absoluteFill} />
          </GestureDetector>
          {faceIndexes.map((index) => {
            const faceGroup = groups[index];
            const active = index === groupIndex;
            const faceMoment = active ? moment : faceGroup?.moments[0];
            if (faceGroup == null || faceMoment == null) return null;
            return (
              <MomentViewerFace
                key={index}
                index={index}
                position={position}
                width={canvasWidth}
                author={faceGroup.author}
                moments={faceGroup.moments}
                moment={faceMoment}
                itemIndex={active ? currentIndex : 0}
                active={active}
                progress={progress}
                mediaStatus={mediaStatus}
                time={formatTime(faceMoment.createdAt)}
                playId={playId}
                paused={paused}
                userPaused={userPaused}
                muted={muted}
                onVideoProgress={followVideo}
                onVideoEnd={advanceNext}
                onMediaStatus={recordMediaStatus}
                onToggleMute={() => setMuted((value) => !value)}
                onTogglePause={() => setUserPaused((value) => !value)}
                onOpenMenu={
                  session.own && isMomentHiddenByAdmin(faceMoment) ? undefined : () => setMenuOpen(true)
                }
                onOpenProfile={
                  session.own || onOpenProfile == null ? undefined : () => onOpenProfile(faceGroup.author)
                }
                onReact={session.own ? undefined : (type) => react(faceMoment.id, type)}
                onClose={onClose}
              />
            );
          })}
        </View>
      </Animated.View>

      <ListOptionDialog
        visible={menuOpen}
        title={t('moment.menu')}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      {reportTarget && <ReportDialog target={reportTarget} onClose={() => setReportTarget(null)} />}
    </View>
  );
}

export function MomentViewer({ session, onClose, onOpenProfile }: MomentViewerProps) {
  return (
    <OlaModal
      visible
      animationType="fade"
      statusBarTranslucent
      navigationBarTranslucent
      onRequestClose={onClose}
    >
      <GestureHandlerRootView style={{ flex: 1 }}>
        <MomentViewerContent session={session} onClose={onClose} onOpenProfile={onOpenProfile} />
      </GestureHandlerRootView>
      <ToastHost />
    </OlaModal>
  );
}
