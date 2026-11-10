import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  PanResponder,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
  type ViewInstance,
} from 'react-native';
import Video, { type VideoRef } from 'react-native-video';
import {
  MOMENT_MUSIC_MAX_MS,
  MOMENT_MUSIC_MIN_MS,
  MOMENT_MUSIC_TITLE_MAX,
  MOMENT_MUSIC_TOTAL_MS,
} from '@ola/shared/constants';
import {
  formatMomentMusicTime,
  momentMusicDefaultTitle,
  momentMusicEndMs,
  momentMusicLoops,
  momentMusicMaxStartMs,
  momentMusicTrimBars,
  resolveMomentMusicTitle,
  snapMomentMusicStart,
  toast,
  withAlpha,
} from '@ola/shared/lib';
import type { MomentMusicDraft, NativeUploadFile } from '@ola/shared/types';
import { KeyboardView } from '@components/KeyboardView';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { pickMomentMusic } from '../momentPicker';
import {
  MomentCloseIcon,
  MomentMusicIcon,
  MomentPauseIcon,
  MomentPencilIcon,
  MomentPlayIcon,
  MomentTrashIcon,
} from './MomentIcons';

const MS_PER_SECOND = 1000;
const HIDDEN_PLAYER = { width: 0, height: 0 };
const TRIM_BAR_COUNT = 56;
const TRIM_BAR_MAX_PERCENT = 70;
const TRIM_BAR_IDLE = 'rgba(0,0,0,0.15)';
const SURFACE = '#f3f3f3';
const ERROR_COLOR = '#e34545';
const NOTICE_BACKGROUND = '#fff4e0';
const NOTICE_TEXT = '#e65100';
const TEXT_PRIMARY = 'rgba(0,0,0,0.85)';
const TEXT_MUTED = 'rgba(0,0,0,0.55)';
const TEXT_HINT = 'rgba(0,0,0,0.45)';
const BORDER = 'rgba(0,0,0,0.15)';

export function MomentMusicBar({
  music,
  onOpen,
}: {
  music: MomentMusicDraft | null;
  onOpen: () => void;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const tint = colors.primaryInk;
  return (
    <Pressable
      accessibilityRole="button"
      onPress={onOpen}
      className="flex-row items-center gap-1.5 rounded-full px-3 py-1.5 active:opacity-70"
      style={styles.chip}
    >
      <MomentMusicIcon size={16} color={tint} />
      <Text numberOfLines={1} className="shrink text-sm font-medium" style={{ color: tint }}>
        {music?.title ?? t('moment.musicAdd')}
      </Text>
    </Pressable>
  );
}

const TRIM_BARS = momentMusicTrimBars(TRIM_BAR_COUNT);

interface MusicTrimmerProps {
  durationMs: number;
  startMs: number;
  maxStartMs: number;
  positionMs: number | null;
  label: string;
  onChange: (startMs: number) => void;
}

function MusicTrimmer({ durationMs, startMs, maxStartMs, positionMs, label, onChange }: MusicTrimmerProps) {
  const colors = useThemeColors();
  const trackRef = useRef<ViewInstance>(null);
  const track = useRef({ x: 0, width: 0 });
  const grabOffset = useRef(0);
  const windowMs = Math.min(durationMs, MOMENT_MUSIC_TOTAL_MS);
  const latest = useRef({ durationMs, startMs, maxStartMs, windowMs, onChange });

  useEffect(() => {
    latest.current = { durationMs, startMs, maxStartMs, windowMs, onChange };
  }, [durationMs, startMs, maxStartMs, windowMs, onChange]);

  function pointerMs(pageX: number) {
    const { x, width } = track.current;
    if (width <= 0) return 0;
    return ((pageX - x) / width) * latest.current.durationMs;
  }

  function moveTo(pageX: number) {
    latest.current.onChange(
      snapMomentMusicStart(pointerMs(pageX) - grabOffset.current, latest.current.maxStartMs)
    );
  }

  const responder = useRef(
    PanResponder.create({
      onStartShouldSetPanResponder: () => true,
      onMoveShouldSetPanResponder: () => true,
      onPanResponderTerminationRequest: () => false,
      onShouldBlockNativeResponder: () => false,
      onPanResponderGrant: (event) => {
        const { pageX } = event.nativeEvent;
        trackRef.current?.measureInWindow((x, _y, width) => {
          track.current = { x, width };
          const at = pointerMs(pageX);
          const { startMs: from, windowMs: size } = latest.current;
          grabOffset.current = at >= from && at <= from + size ? at - from : size / 2;
          moveTo(pageX);
        });
      },
      onPanResponderMove: (event) => moveTo(event.nativeEvent.pageX),
    })
  ).current;

  const locked = maxStartMs === 0;
  const startRatio = startMs / durationMs;
  const endRatio = (startMs + windowMs) / durationMs;
  const playheadRatio =
    positionMs == null ? null : Math.min(endRatio, Math.max(startRatio, positionMs / durationMs));

  return (
    <View
      ref={trackRef}
      accessibilityRole="adjustable"
      accessibilityLabel={label}
      accessibilityValue={{ text: formatMomentMusicTime(startMs) }}
      style={styles.trimTrack}
      {...(locked ? {} : responder.panHandlers)}
    >
      <View pointerEvents="none" style={styles.trimBars}>
        {TRIM_BARS.map((height, index) => {
          const center = (index + 0.5) / TRIM_BAR_COUNT;
          const selected = center >= startRatio && center <= endRatio;
          return (
            <View
              key={index}
              style={{
                flex: 1,
                height: `${height * TRIM_BAR_MAX_PERCENT}%`,
                borderRadius: 999,
                backgroundColor: selected ? colors.primary : TRIM_BAR_IDLE,
              }}
            />
          );
        })}
      </View>
      <View
        pointerEvents="none"
        style={[
          styles.trimWindow,
          {
            left: `${startRatio * 100}%`,
            width: `${(endRatio - startRatio) * 100}%`,
            borderColor: colors.primary,
            backgroundColor: withAlpha(colors.primary, 0.1),
          },
        ]}
      />
      {playheadRatio != null && (
        <View
          pointerEvents="none"
          style={[styles.trimPlayhead, { left: `${playheadRatio * 100}%`, backgroundColor: colors.primaryDark }]}
        />
      )}
    </View>
  );
}

interface MomentMusicPanelProps {
  initial: MomentMusicDraft | null;
  onApply: (music: MomentMusicDraft | null) => void;
  onClose: () => void;
}

export function MomentMusicPanel({ initial, onApply, onClose }: MomentMusicPanelProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const bottomInset = useBottomBarInset();
  const [draft, setDraft] = useState<MomentMusicDraft | null>(initial);
  const [pending, setPending] = useState<{ file: NativeUploadFile; fileName: string } | null>(null);
  const [playing, setPlaying] = useState(false);
  const [positionMs, setPositionMs] = useState(0);
  const playerRef = useRef<VideoRef>(null);

  const endMs = draft == null ? 0 : momentMusicEndMs(draft);
  const maxStart = draft == null ? 0 : momentMusicMaxStartMs(draft.durationMs);
  const loops = draft != null && momentMusicLoops(draft.durationMs);

  async function chooseFile() {
    const result = await pickMomentMusic().catch(() => ({ kind: 'cancelled' as const }));
    if (result.kind === 'cancelled') return;
    if (result.kind === 'unsupported') {
      toast.info(t('moment.musicUnsupported'));
      return;
    }
    if (result.kind === 'tooLarge') {
      toast.info(t('moment.musicTooLarge'));
      return;
    }
    setPlaying(false);
    setPending({ file: result.file, fileName: result.fileName });
  }

  function handlePendingLoaded(seconds: number) {
    if (pending == null) return;
    const durationMs = Math.floor(seconds * MS_PER_SECOND);
    const { file, fileName } = pending;
    setPending(null);
    if (durationMs < MOMENT_MUSIC_MIN_MS || durationMs > MOMENT_MUSIC_MAX_MS) {
      toast.info(t(durationMs < MOMENT_MUSIC_MIN_MS ? 'moment.musicTooShort' : 'moment.musicTooLong'));
      return;
    }
    setDraft({
      file,
      url: file.uri,
      fileName,
      title: momentMusicDefaultTitle(fileName),
      durationMs,
      startMs: 0,
    });
  }

  function handlePendingError() {
    setPending(null);
    toast.info(t('moment.musicUnplayable'));
  }

  function seekToStart(startMs: number) {
    playerRef.current?.seek(startMs / MS_PER_SECOND);
  }

  function togglePreview() {
    if (draft == null) return;
    if (!playing) seekToStart(draft.startMs);
    setPlaying((value) => !value);
  }

  function changeStart(startMs: number) {
    if (draft == null) return;
    setDraft({ ...draft, startMs });
    if (playing) seekToStart(startMs);
  }

  function apply() {
    onApply(draft == null ? null : { ...draft, title: resolveMomentMusicTitle(draft) });
  }

  return (
    <View style={[StyleSheet.absoluteFill, styles.backdrop]}>
      <KeyboardView className="flex-1 justify-end">
        <ScrollView
          bounces={false}
          keyboardShouldPersistTaps="handled"
          style={styles.sheet}
          contentContainerStyle={{ paddingHorizontal: 16, paddingTop: 8, paddingBottom: 16 + bottomInset }}
        >
          <View style={styles.grabber} />
          <View className="mb-4 flex-row items-center justify-between">
            <Text className="text-lg font-semibold" style={{ color: TEXT_PRIMARY }}>
              {t('moment.musicPanelTitle')}
            </Text>
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={t('dialog.close')}
              hitSlop={8}
              onPress={onClose}
              style={styles.closeButton}
            >
              <MomentCloseIcon size={16} color={TEXT_MUTED} />
            </Pressable>
          </View>

          {pending != null && (
            <Video
              source={{ uri: pending.file.uri }}
              paused
              muted
              onLoad={(data) => handlePendingLoaded(data.duration)}
              onError={handlePendingError}
              style={HIDDEN_PLAYER}
            />
          )}

          {draft == null ? (
            <Pressable
              accessibilityRole="button"
              onPress={() => void chooseFile()}
              className="items-center rounded-2xl px-4 py-7 active:opacity-70"
              style={{ gap: 8, backgroundColor: withAlpha(colors.primary, 0.1) }}
            >
              <View style={[styles.pickIcon, { backgroundColor: colors.primary }]}>
                <MomentMusicIcon size={28} color="#ffffff" />
              </View>
              <Text className="text-base font-semibold" style={{ color: TEXT_PRIMARY }}>
                {t('moment.musicPick')}
              </Text>
              <Text className="text-center text-xs" style={{ color: TEXT_HINT }}>
                {t('moment.musicFormats')}
              </Text>
            </Pressable>
          ) : (
            <View style={{ gap: 16 }}>
              <Video
                ref={playerRef}
                source={{ uri: draft.url }}
                paused={!playing}
                repeat={loops}
                progressUpdateInterval={200}
                onProgress={(data) => {
                  if (!playing) return;
                  setPositionMs(data.currentTime * MS_PER_SECOND);
                  if (!loops && data.currentTime * MS_PER_SECOND >= endMs) seekToStart(draft.startMs);
                }}
                onEnd={() => setPlaying(false)}
                onError={handlePendingError}
                style={HIDDEN_PLAYER}
              />
              <View className="flex-row items-center rounded-2xl p-3" style={styles.songCard}>
                <Pressable
                  accessibilityRole="button"
                  accessibilityLabel={t(playing ? 'moment.musicPreviewPause' : 'moment.musicPreviewPlay')}
                  onPress={togglePreview}
                  className="active:opacity-80"
                  style={[styles.playButton, { backgroundColor: colors.primary }]}
                >
                  {playing ? (
                    <MomentPauseIcon size={20} color="#ffffff" />
                  ) : (
                    <MomentPlayIcon size={20} color="#ffffff" />
                  )}
                </Pressable>
                <View style={{ flex: 1, minWidth: 0 }}>
                  <View className="flex-row items-center" style={{ gap: 4 }}>
                    <MomentPencilIcon size={12} color={TEXT_HINT} />
                    <Text className="text-xs" style={{ color: TEXT_HINT }}>
                      {t('moment.musicName')}
                    </Text>
                  </View>
                  <TextInput
                    value={draft.title}
                    maxLength={MOMENT_MUSIC_TITLE_MAX}
                    placeholder={t('moment.musicNamePlaceholder')}
                    placeholderTextColor={TEXT_HINT}
                    onChangeText={(title) => setDraft({ ...draft, title })}
                    style={styles.input}
                  />
                </View>
                <Pressable
                  accessibilityRole="button"
                  onPress={() => void chooseFile()}
                  className="rounded-full px-3 py-1.5 active:opacity-70"
                  style={styles.changeButton}
                >
                  <Text className="text-sm font-medium" style={{ color: TEXT_MUTED }}>
                    {t('moment.musicChange')}
                  </Text>
                </Pressable>
                <Pressable
                  accessibilityRole="button"
                  accessibilityLabel={t('moment.musicRemove')}
                  hitSlop={6}
                  onPress={() => {
                    setPlaying(false);
                    setDraft(null);
                  }}
                  className="active:opacity-70"
                  style={styles.removeButton}
                >
                  <MomentTrashIcon size={20} color={ERROR_COLOR} />
                </Pressable>
              </View>

              <View>
                <View className="mb-2 flex-row items-center justify-between">
                  <Text className="text-sm font-medium" style={{ color: TEXT_MUTED }}>
                    {t('moment.musicSegment')}
                  </Text>
                  <Text
                    className="rounded-full px-2.5 py-0.5 text-sm font-semibold"
                    style={{
                      overflow: 'hidden',
                      color: colors.primaryDark,
                      backgroundColor: withAlpha(colors.primary, 0.12),
                    }}
                  >
                    {formatMomentMusicTime(draft.startMs)} – {formatMomentMusicTime(endMs)}
                  </Text>
                </View>
                <MusicTrimmer
                  durationMs={draft.durationMs}
                  startMs={draft.startMs}
                  maxStartMs={maxStart}
                  positionMs={playing ? positionMs : null}
                  label={t('moment.musicSegment')}
                  onChange={changeStart}
                />
                <View className="mt-1 flex-row justify-between">
                  <Text className="text-xs" style={{ color: TEXT_HINT }}>
                    0:00
                  </Text>
                  {maxStart > 0 && (
                    <Text className="text-xs" style={{ color: TEXT_HINT }}>
                      {t('moment.musicDragHint')}
                    </Text>
                  )}
                  <Text className="text-xs" style={{ color: TEXT_HINT }}>
                    {formatMomentMusicTime(draft.durationMs)}
                  </Text>
                </View>
                {loops && (
                  <Text accessibilityRole="alert" className="mt-3 rounded-xl px-3 py-2.5 text-sm" style={styles.notice}>
                    {t('moment.musicLoopNotice')}
                  </Text>
                )}
              </View>
            </View>
          )}

          <Text className="mt-4 text-xs" style={{ color: TEXT_HINT, lineHeight: 18 }}>
            {t('moment.musicLengthHint')} {t('moment.musicRights')}
          </Text>

          <Pressable
            accessibilityRole="button"
            onPress={apply}
            className="mt-3 items-center rounded-full py-3 active:opacity-80"
            style={{ backgroundColor: colors.primary }}
          >
            <Text className="text-base font-semibold text-white">{t('moment.musicApply')}</Text>
          </Pressable>
        </ScrollView>
      </KeyboardView>
    </View>
  );
}

const styles = StyleSheet.create({
  backdrop: { backgroundColor: 'rgba(0,0,0,0.5)' },
  sheet: { flexGrow: 0, backgroundColor: '#ffffff', borderTopLeftRadius: 24, borderTopRightRadius: 24 },
  grabber: {
    alignSelf: 'center',
    width: 40,
    height: 4,
    marginBottom: 8,
    borderRadius: 2,
    backgroundColor: 'rgba(0,0,0,0.15)',
  },
  closeButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.05)',
  },
  chip: {
    maxWidth: '100%',
    backgroundColor: '#ffffff',
    borderWidth: StyleSheet.hairlineWidth,
    borderColor: 'rgba(0,0,0,0.1)',
  },
  pickIcon: { width: 56, height: 56, borderRadius: 28, alignItems: 'center', justifyContent: 'center' },
  songCard: { gap: 12, backgroundColor: SURFACE },
  playButton: { width: 48, height: 48, borderRadius: 24, alignItems: 'center', justifyContent: 'center' },
  changeButton: { backgroundColor: '#ffffff', borderWidth: StyleSheet.hairlineWidth, borderColor: BORDER },
  removeButton: { width: 36, height: 36, alignItems: 'center', justifyContent: 'center' },
  trimTrack: { height: 64, borderRadius: 16, overflow: 'hidden', backgroundColor: SURFACE, justifyContent: 'center' },
  trimBars: {
    position: 'absolute',
    left: 0,
    right: 0,
    top: 0,
    bottom: 0,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 2,
    paddingHorizontal: 4,
  },
  trimWindow: { position: 'absolute', top: 0, bottom: 0, borderWidth: 2, borderRadius: 12 },
  trimPlayhead: { position: 'absolute', top: 4, bottom: 4, width: 2, borderRadius: 1 },
  notice: { backgroundColor: NOTICE_BACKGROUND, color: NOTICE_TEXT, overflow: 'hidden' },
  input: {
    marginTop: 4,
    paddingVertical: 6,
    paddingHorizontal: 10,
    borderRadius: 8,
    borderWidth: StyleSheet.hairlineWidth,
    borderColor: BORDER,
    backgroundColor: '#ffffff',
    fontSize: 16,
    fontWeight: '600',
    color: TEXT_PRIMARY,
  },
});
