import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, StyleSheet, Text, View } from 'react-native';
import Animated, { FadeIn, useAnimatedStyle, type SharedValue } from 'react-native-reanimated';
import LinearGradient from 'react-native-linear-gradient';
import { MOMENT_FADE_MS, MOMENT_STATUS, MOMENT_TURN_SHADE, MOMENT_TYPE } from '@ola/shared/constants';
import { colorForName, momentMedia, momentNoticeKey } from '@ola/shared/lib';
import type { Moment, MomentAuthor, ReactionType } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { MOMENT_TURN_PERSPECTIVE } from '../constants';
import { MomentCanvas } from './MomentCanvas';
import {
  MomentCloseIcon,
  MomentMoreIcon,
  MomentPauseIcon,
  MomentPlayIcon,
  MomentSoundIcon,
} from './MomentIcons';
import { MomentReactionBar } from './MomentReactionBar';

export type MomentMediaStatus = 'loading' | 'ready' | 'error';

const ICON_HIT_SLOP = 8;

const styles = StyleSheet.create({
  topShade: { position: 'absolute', left: 0, right: 0, top: 0, height: 120 },
  iconButton: { padding: 8, borderRadius: 999 },
  author: { flex: 1, minWidth: 0, flexDirection: 'row', alignItems: 'center', gap: 8 },
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
  noticeAboveBar: { bottom: 96 },
  noticeText: { color: '#ffffff', textAlign: 'center', fontSize: 14 },
  centered: { alignItems: 'center', justifyContent: 'center' },
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

interface MomentViewerFaceProps {
  index: number;
  position: SharedValue<number>;
  width: number;
  author: MomentAuthor;
  moments: Moment[];
  moment: Moment;
  itemIndex: number;
  active: boolean;
  progress: SharedValue<number>;
  mediaStatus: MomentMediaStatus;
  time: string;
  playId: number;
  paused: boolean;
  userPaused: boolean;
  muted: boolean;
  onVideoProgress: (value: number) => void;
  onVideoEnd: () => void;
  onMediaStatus: (momentId: string, status: MomentMediaStatus) => void;
  onToggleMute: () => void;
  onTogglePause: () => void;
  onOpenMenu?: () => void;
  onOpenProfile?: () => void;
  onReact?: (type: ReactionType) => void;
  onClose: () => void;
}

export function MomentViewerFace({
  index,
  position,
  width,
  author,
  moments,
  moment,
  itemIndex,
  active,
  progress,
  mediaStatus,
  time,
  playId,
  paused,
  userPaused,
  muted,
  onVideoProgress,
  onVideoEnd,
  onMediaStatus,
  onToggleMute,
  onTogglePause,
  onOpenMenu,
  onOpenProfile,
  onReact,
  onClose,
}: MomentViewerFaceProps) {
  const { t } = useTranslation();
  const [pages, setPages] = useState<{ shown: Moment; previous: Moment | null }>({
    shown: moment,
    previous: null,
  });
  if (pages.shown.id !== moment.id) {
    setPages({ shown: moment, previous: pages.shown });
  }
  const previous = pages.previous;
  const media = useMemo(() => momentMedia(moment), [moment]);
  const isVideo = media?.type === MOMENT_TYPE.video;
  const processing = moment.status === MOMENT_STATUS.processing;
  const noticeKey = momentNoticeKey(moment, mediaStatus === 'error');
  const momentId = moment.id;

  useEffect(() => {
    if (previous == null) return;
    const timer = setTimeout(() => setPages((value) => ({ ...value, previous: null })), MOMENT_FADE_MS);
    return () => clearTimeout(timer);
  }, [previous]);

  const turnStyle = useAnimatedStyle(() => {
    const offset = index - position.value;
    const edge = offset < 0 ? width / 2 : -width / 2;
    return {
      opacity: Math.abs(offset) >= 1 ? 0 : 1,
      transform: [
        { perspective: width * MOMENT_TURN_PERSPECTIVE },
        { translateX: offset * width + edge },
        { rotateY: `${offset * 90}deg` },
        { translateX: -edge },
      ],
    };
  });

  const shadeStyle = useAnimatedStyle(() => ({
    opacity: Math.min(Math.abs(index - position.value), 1) * MOMENT_TURN_SHADE,
  }));

  return (
    <Animated.View
      pointerEvents={active ? 'box-none' : 'none'}
      style={[StyleSheet.absoluteFill, { overflow: 'hidden' }, turnStyle]}
    >
      <View pointerEvents="none" style={StyleSheet.absoluteFill}>
        {[previous, moment].map((page) => {
          if (page == null) return null;
          const current = page.id === momentId;
          return (
            <Animated.View
              key={page.id}
              entering={current && previous ? FadeIn.duration(MOMENT_FADE_MS) : undefined}
              style={StyleSheet.absoluteFill}
            >
              {current ? (
                <MomentCanvas
                  background={moment.background}
                  media={media}
                  overlays={moment.overlays}
                  videoMode={active ? 'controlled' : 'still'}
                  playId={playId}
                  paused={paused}
                  muted={muted}
                  onVideoProgress={active ? onVideoProgress : undefined}
                  onVideoEnd={active ? onVideoEnd : undefined}
                  onMediaReady={() => onMediaStatus(momentId, 'ready')}
                  onMediaError={() => onMediaStatus(momentId, 'error')}
                  style={StyleSheet.absoluteFill}
                />
              ) : (
                <MomentCanvas
                  background={page.background}
                  media={momentMedia(page)}
                  overlays={page.overlays}
                  style={StyleSheet.absoluteFill}
                />
              )}
            </Animated.View>
          );
        })}
        <LinearGradient colors={['rgba(0,0,0,0.55)', 'rgba(0,0,0,0)']} style={styles.topShade} />
        {active && noticeKey != null && (
          <View style={[styles.notice, onReact != null && styles.noticeAboveBar]}>
            <Text style={styles.noticeText}>{t(noticeKey)}</Text>
          </View>
        )}
        {active && mediaStatus === 'loading' && !processing && (
          <View style={[StyleSheet.absoluteFill, styles.centered]}>
            <ActivityIndicator color="#ffffff" size="large" />
          </View>
        )}
      </View>
      <View
        pointerEvents="box-none"
        style={{ position: 'absolute', top: 0, left: 0, right: 0, paddingHorizontal: 12, paddingTop: 12 }}
      >
        <View pointerEvents="none" style={{ flexDirection: 'row', gap: 4 }}>
          {moments.map((item, segment) => (
            <ProgressSegment
              key={item.id}
              state={
                segment < itemIndex ? 'done' : segment === itemIndex && active ? 'current' : 'pending'
              }
              progress={progress}
            />
          ))}
        </View>
        <View style={{ marginTop: 12, flexDirection: 'row', alignItems: 'center', gap: 8 }}>
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('me.viewProfile')}
            disabled={onOpenProfile == null}
            onPress={onOpenProfile}
            style={styles.author}
          >
            <Avatar
              name={author.username}
              color={colorForName(author.username)}
              uri={author.avatar ?? undefined}
              size={36}
            />
            <View pointerEvents="none" style={{ flex: 1, minWidth: 0 }}>
              <Text numberOfLines={1} style={{ color: '#ffffff', fontSize: 14, fontWeight: '600' }}>
                {author.username}
              </Text>
              <Text style={{ color: 'rgba(255,255,255,0.75)', fontSize: 12 }}>{time}</Text>
            </View>
          </Pressable>
          {isVideo && (
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={muted ? t('moment.unmute') : t('moment.mute')}
              hitSlop={ICON_HIT_SLOP}
              onPress={onToggleMute}
              style={styles.iconButton}
            >
              <MomentSoundIcon muted={muted} />
            </Pressable>
          )}
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={userPaused ? t('moment.play') : t('moment.pause')}
            hitSlop={ICON_HIT_SLOP}
            onPress={onTogglePause}
            style={styles.iconButton}
          >
            {userPaused ? <MomentPlayIcon /> : <MomentPauseIcon />}
          </Pressable>
          {onOpenMenu != null && (
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={t('moment.menu')}
              hitSlop={ICON_HIT_SLOP}
              onPress={onOpenMenu}
              style={styles.iconButton}
            >
              <MomentMoreIcon />
            </Pressable>
          )}
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('dialog.close')}
            hitSlop={ICON_HIT_SLOP}
            onPress={onClose}
            style={styles.iconButton}
          >
            <MomentCloseIcon />
          </Pressable>
        </View>
      </View>
      {onReact != null && <MomentReactionBar onReact={onReact} />}
      <Animated.View
        pointerEvents="none"
        style={[StyleSheet.absoluteFill, { backgroundColor: '#000000' }, shadeStyle]}
      />
    </Animated.View>
  );
}
