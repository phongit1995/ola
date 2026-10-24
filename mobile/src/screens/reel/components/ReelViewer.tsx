import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  AppState,
  Pressable,
  StatusBar,
  StyleSheet,
  Text,
  useWindowDimensions,
  View,
} from 'react-native';
import { Gesture, GestureDetector, GestureHandlerRootView } from 'react-native-gesture-handler';
import Animated, {
  cancelAnimation,
  Easing,
  runOnJS,
  useAnimatedStyle,
  useSharedValue,
  withTiming,
  type SharedValue,
} from 'react-native-reanimated';
import LinearGradient from 'react-native-linear-gradient';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
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
} from '@ola/shared/constants';
import {
  colorForName,
  createTimeFormatter,
  reelExpiresInMs,
  reelGroupStep,
  reelItemStep,
  reelMedia,
  toast,
} from '@ola/shared/lib';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import { useReelTray } from '@ola/shared/stores/reel/useReelTray';
import type { ReelPosition, ReelViewerSession, ReportTarget } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { OlaModal } from '@components/ui/OlaModal';
import { ReportDialog } from '@components/ui/ReportDialog';
import { ToastHost } from '@components/ui/ToastHost';
import { releaseVoicePlayback } from '@lib/voicePlaybackSession';
import { REEL_ASPECT_RATIO } from '../constants';
import { ReelCanvas } from './ReelCanvas';
import {
  ReelCloseIcon,
  ReelEyeIcon,
  ReelMoreIcon,
  ReelPauseIcon,
  ReelPlayIcon,
  ReelSoundIcon,
} from './ReelIcons';
import { ReelViewersDialog } from './ReelViewersDialog';

type MediaStatus = 'loading' | 'ready' | 'error';

interface MediaState {
  reelId: string;
  status: MediaStatus;
}

const SWIPE_MIN_DISTANCE_PX = 10;
const ICON_HIT_SLOP = 8;

const styles = StyleSheet.create({
  topShade: { position: 'absolute', left: 0, right: 0, top: 0, height: 120 },
  iconButton: { padding: 8, borderRadius: 999 },
  notice: {
    position: 'absolute',
    left: 24,
    right: 24,
    bottom: 80,
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 8,
    backgroundColor: 'rgba(0,0,0,0.55)',
  },
  noticeText: { color: '#ffffff', textAlign: 'center', fontSize: 14 },
  viewerPill: {
    position: 'absolute',
    left: 16,
    bottom: 16,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    borderRadius: 999,
    paddingHorizontal: 12,
    paddingVertical: 6,
    backgroundColor: 'rgba(0,0,0,0.45)',
  },
});

function ProgressSegment({
  state,
  progress,
}: {
  state: 'done' | 'current' | 'pending';
  progress: SharedValue<number>;
}) {
  const fillStyle = useAnimatedStyle(() => ({
    width: `${(state === 'done' ? 1 : state === 'current' ? progress.value : 0) * 100}%`,
  }));
  return (
    <View
      style={{ flex: 1, height: 3, borderRadius: 999, overflow: 'hidden', backgroundColor: 'rgba(255,255,255,0.35)' }}
    >
      <Animated.View style={[{ height: '100%', borderRadius: 999, backgroundColor: '#ffffff' }, fillStyle]} />
    </View>
  );
}

function ReelViewerContent({ session, onClose }: { session: ReelViewerSession; onClose: () => void }) {
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();
  const window = useWindowDimensions();
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
  const [anchorId, setAnchorId] = useState(() => groups[session.startIndex]?.reels[0]?.id ?? null);
  const [playId, setPlayId] = useState(0);
  const [holding, setHolding] = useState(false);
  const [userPaused, setUserPaused] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [viewersOpen, setViewersOpen] = useState(false);
  const [confirmDelete, setConfirmDelete] = useState(false);
  const [reportTarget, setReportTarget] = useState<ReportTarget | null>(null);
  const [muted, setMuted] = useState(false);
  const [mediaState, setMediaState] = useState<MediaState | null>(null);
  const [appActive, setAppActive] = useState(() => AppState.currentState === 'active');
  const progress = useSharedValue(0);
  const dragY = useSharedValue(0);
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const group = groups[groupIndex];
  const anchoredIndex = group?.reels.findIndex((item) => item.id === anchorId) ?? -1;
  const currentIndex =
    anchoredIndex >= 0 ? anchoredIndex : Math.min(itemIndex, (group?.reels.length ?? 1) - 1);
  const reel = group?.reels[currentIndex];
  const shownReelId = reel?.id;
  const media = useMemo(() => (reel ? reelMedia(reel) : null), [reel]);
  const isVideo = media?.type === REEL_TYPE.video;
  const mediaStatus: MediaStatus =
    media == null
      ? 'ready'
      : mediaState != null && mediaState.reelId === reel?.id
        ? mediaState.status
        : 'loading';
  const dialogOpen = menuOpen || viewersOpen || confirmDelete || reportTarget != null;
  const paused = holding || userPaused || dialogOpen || !appActive;
  const waitingForMedia = mediaStatus === 'loading';
  const timedBySlide = !isVideo || mediaStatus === 'error';

  const availableHeight = window.height - insets.top - insets.bottom;
  const canvasWidth = Math.min(window.width, availableHeight * REEL_ASPECT_RATIO);
  const canvasHeight = canvasWidth / REEL_ASPECT_RATIO;

  const goTo = useCallback(
    (nextGroup: number, nextItem: number) => {
      cancelAnimation(progress);
      progress.value = 0;
      setGroupIndex(nextGroup);
      setItemIndex(nextItem);
      setAnchorId(groups[nextGroup]?.reels[nextItem]?.id ?? null);
      setPlayId((id) => id + 1);
    },
    [groups, progress]
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

  const advanceRef = useRef(advance);
  const advanceNext = useCallback(() => advanceRef.current(1), []);

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
    if (reel == null || !appActive) return;
    const timer = setTimeout(advanceNext, reelExpiresInMs(reel, Date.now()));
    return () => clearTimeout(timer);
  }, [reel, appActive, advanceNext]);

  useEffect(() => {
    cancelAnimation(progress);
    progress.value = 0;
  }, [shownReelId, progress]);

  useEffect(() => {
    if (reel == null || !timedBySlide || paused || waitingForMedia) return;
    const remaining = REEL_SLIDE_MS * (1 - progress.value);
    progress.value = withTiming(1, { duration: remaining, easing: Easing.linear }, (finished) => {
      if (finished) runOnJS(advanceNext)();
    });
    return () => cancelAnimation(progress);
  }, [reel, playId, timedBySlide, paused, waitingForMedia, progress, advanceNext]);

  useEffect(() => {
    if (session.own || reel == null || paused || mediaStatus !== 'ready') return;
    const id = reel.id;
    const timer = setTimeout(() => markSeen(id), REEL_SEEN_AFTER_MS);
    return () => clearTimeout(timer);
  }, [session.own, reel, paused, mediaStatus, markSeen]);

  const handleTap = useCallback(
    (x: number) => advance(x < canvasWidth * REEL_PREV_TAP_ZONE ? -1 : 1),
    [advance, canvasWidth]
  );

  const handleSwipe = useCallback(
    (dx: number, dy: number) => {
      if (dy > REEL_SWIPE_CLOSE_PX && Math.abs(dy) > Math.abs(dx)) onClose();
      else if (Math.abs(dx) > REEL_SWIPE_GROUP_PX) jumpGroup(dx < 0 ? 1 : -1);
    },
    [onClose, jumpGroup]
  );

  const gesture = useMemo(() => {
    const tap = Gesture.Tap()
      .maxDuration(REEL_HOLD_TO_PAUSE_MS)
      .onEnd((event, success) => {
        if (success) runOnJS(handleTap)(event.x);
      });
    const hold = Gesture.LongPress()
      .minDuration(REEL_HOLD_TO_PAUSE_MS)
      .onStart(() => runOnJS(setHolding)(true))
      .onEnd(() => runOnJS(setHolding)(false));
    const swipe = Gesture.Pan()
      .minDistance(SWIPE_MIN_DISTANCE_PX)
      .onStart(() => runOnJS(setHolding)(true))
      .onUpdate((event) => {
        dragY.value = Math.max(0, event.translationY);
      })
      .onEnd((event) => {
        runOnJS(setHolding)(false);
        runOnJS(handleSwipe)(event.translationX, event.translationY);
      })
      .onFinalize(() => {
        dragY.value = withTiming(0);
      });
    return Gesture.Race(swipe, hold, tap);
  }, [handleTap, handleSwipe, dragY]);

  const dragStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: dragY.value }],
    opacity: 1 - Math.min(dragY.value / (REEL_SWIPE_CLOSE_PX * 4), 0.5),
  }));

  if (group == null || reel == null) return null;

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
        { key: 'viewers', label: t('reel.viewers'), onSelect: () => setViewersOpen(true) },
        { key: 'delete', label: t('reel.delete'), danger: true, onSelect: () => setConfirmDelete(true) },
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
  const processing = reel.status === REEL_STATUS.processing;
  const reelId = reel.id;

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
            <View style={StyleSheet.absoluteFill}>
              <ReelCanvas
                background={reel.background}
                media={media}
                overlays={reel.overlays}
                videoMode="controlled"
                playId={playId}
                paused={paused}
                muted={muted}
                onVideoProgress={(value) => {
                  progress.value = value;
                }}
                onVideoEnd={advanceNext}
                onMediaReady={() => setMediaState({ reelId, status: 'ready' })}
                onMediaError={() => setMediaState({ reelId, status: 'error' })}
                style={StyleSheet.absoluteFill}
              />
              <LinearGradient
                pointerEvents="none"
                colors={['rgba(0,0,0,0.55)', 'rgba(0,0,0,0)']}
                style={styles.topShade}
              />
              {(processing || mediaStatus === 'error') && (
                <View pointerEvents="none" style={styles.notice}>
                  <Text style={styles.noticeText}>
                    {t(processing ? 'reel.processing' : 'reel.mediaError')}
                  </Text>
                </View>
              )}
              {waitingForMedia && !processing && (
                <View pointerEvents="none" style={[StyleSheet.absoluteFill, { alignItems: 'center', justifyContent: 'center' }]}>
                  <ActivityIndicator color="#ffffff" size="large" />
                </View>
              )}
            </View>
          </GestureDetector>
          <View
            pointerEvents="box-none"
            style={{ position: 'absolute', top: 0, left: 0, right: 0, paddingHorizontal: 12, paddingTop: 12 }}
          >
            <View pointerEvents="none" style={{ flexDirection: 'row', gap: 4 }}>
              {group.reels.map((item, index) => (
                <ProgressSegment
                  key={item.id}
                  state={index < currentIndex ? 'done' : index === currentIndex ? 'current' : 'pending'}
                  progress={progress}
                />
              ))}
            </View>
            <View style={{ marginTop: 12, flexDirection: 'row', alignItems: 'center', gap: 8 }}>
              <Avatar
                name={authorName}
                color={colorForName(author.username)}
                uri={author.avatar ?? undefined}
                size={36}
              />
              <View pointerEvents="none" style={{ flex: 1, minWidth: 0 }}>
                <Text numberOfLines={1} style={{ color: '#ffffff', fontSize: 14, fontWeight: '600' }}>
                  {authorName}
                </Text>
                <Text style={{ color: 'rgba(255,255,255,0.75)', fontSize: 12 }}>
                  {formatTime(reel.createdAt)}
                </Text>
              </View>
              {isVideo && (
                <Pressable
                  accessibilityRole="button"
                  accessibilityLabel={muted ? t('reel.unmute') : t('reel.mute')}
                  hitSlop={ICON_HIT_SLOP}
                  onPress={() => setMuted((value) => !value)}
                  style={styles.iconButton}
                >
                  <ReelSoundIcon muted={muted} />
                </Pressable>
              )}
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={userPaused ? t('reel.play') : t('reel.pause')}
                hitSlop={ICON_HIT_SLOP}
                onPress={() => setUserPaused((value) => !value)}
                style={styles.iconButton}
              >
                {userPaused ? <ReelPlayIcon /> : <ReelPauseIcon />}
              </Pressable>
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={t('reel.menu')}
                hitSlop={ICON_HIT_SLOP}
                onPress={() => setMenuOpen(true)}
                style={styles.iconButton}
              >
                <ReelMoreIcon />
              </Pressable>
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={t('dialog.close')}
                hitSlop={ICON_HIT_SLOP}
                onPress={onClose}
                style={styles.iconButton}
              >
                <ReelCloseIcon />
              </Pressable>
            </View>
          </View>
          {session.own && (
            <Pressable
              accessibilityRole="button"
              onPress={() => setViewersOpen(true)}
              style={styles.viewerPill}
            >
              <ReelEyeIcon size={16} />
              <Text style={{ color: '#ffffff', fontSize: 14, fontWeight: '500' }}>
                {t('reel.viewerCount', { count: reel.viewerCount ?? 0 })}
              </Text>
            </Pressable>
          )}
        </View>
      </Animated.View>

      <ListOptionDialog
        visible={menuOpen}
        title={t('reel.menu')}
        options={menuOptions}
        onClose={() => setMenuOpen(false)}
      />
      <ReelViewersDialog
        visible={viewersOpen}
        reelId={reel.id}
        onClose={() => setViewersOpen(false)}
      />
      <ConfirmDialog
        visible={confirmDelete}
        danger
        title={t('reel.deleteTitle')}
        message={t('reel.deleteMessage')}
        confirmLabel={t('common.delete')}
        cancelLabel={t('common.cancel')}
        onConfirm={() => {
          setConfirmDelete(false);
          void deleteCurrent();
        }}
        onCancel={() => setConfirmDelete(false)}
      />
      {reportTarget && <ReportDialog target={reportTarget} onClose={() => setReportTarget(null)} />}
    </View>
  );
}

interface ReelViewerProps {
  session: ReelViewerSession;
  onClose: () => void;
}

export function ReelViewer({ session, onClose }: ReelViewerProps) {
  return (
    <OlaModal
      visible
      animationType="fade"
      statusBarTranslucent
      navigationBarTranslucent
      onRequestClose={onClose}
    >
      <GestureHandlerRootView style={{ flex: 1 }}>
        <ReelViewerContent session={session} onClose={onClose} />
      </GestureHandlerRootView>
      <ToastHost />
    </OlaModal>
  );
}
