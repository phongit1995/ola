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
  MOMENT_MUSIC_DEFAULT_SECONDS,
  MOMENT_MUSIC_MAX_MS,
  MOMENT_MUSIC_MIN_MS,
  MOMENT_MUSIC_SLIDE_SECONDS,
  MOMENT_MUSIC_START_STEP_MS,
  MOMENT_MUSIC_TITLE_MAX,
} from '@ola/shared/constants';
import {
  fitMomentMusic,
  formatMomentMusicTime,
  momentMusicDefaultTitle,
  momentMusicFits,
  momentMusicMaxStartMs,
  momentMusicTotalMs,
  resolveMomentMusicTitle,
  toast,
  withAlpha,
} from '@ola/shared/lib';
import type { MomentMusicDraft, NativeUploadFile } from '@ola/shared/types';
import { KeyboardView } from '@components/KeyboardView';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { pickMomentMusic } from '../momentPicker';
import { MomentMusicIcon, MomentPauseIcon, MomentPlayIcon } from './MomentIcons';

const MS_PER_SECOND = 1000;
const THUMB_SIZE = 24;
const TRACK_HEIGHT = 6;
const HIDDEN_PLAYER = { width: 0, height: 0 };
const HIT_HEIGHT = 36;
const TEXT_PRIMARY = 'rgba(0,0,0,0.85)';
const TEXT_MUTED = 'rgba(0,0,0,0.55)';
const TEXT_HINT = 'rgba(0,0,0,0.45)';
const ERROR_COLOR = '#e34545';
const BORDER = 'rgba(0,0,0,0.15)';

export function MomentMusicBar({
  music,
  tooShort,
  slideCount,
  onOpen,
}: {
  music: MomentMusicDraft | null;
  tooShort: boolean;
  slideCount: number;
  onOpen: () => void;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const tint = tooShort ? ERROR_COLOR : colors.primaryInk;
  function label() {
    if (music == null) return t('moment.musicAdd');
    if (tooShort) return t('moment.musicChipTooShort', { pages: slideCount });
    return t('moment.musicChip', { title: music.title, seconds: music.slideSeconds });
  }
  return (
    <View className="flex-row items-center justify-center py-1.5">
      <Pressable
        accessibilityRole="button"
        onPress={onOpen}
        className="max-w-full flex-row items-center gap-1.5 rounded-full px-3 py-1.5 active:opacity-70"
        style={styles.chip}
      >
        <MomentMusicIcon size={16} color={tint} />
        <Text numberOfLines={1} className="shrink text-sm font-medium" style={{ color: tint }}>
          {label()}
        </Text>
      </Pressable>
    </View>
  );
}

interface MusicStartSliderProps {
  value: number;
  max: number;
  label: string;
  onChange: (value: number) => void;
}

function MusicStartSlider({ value, max, label, onChange }: MusicStartSliderProps) {
  const colors = useThemeColors();
  const trackRef = useRef<ViewInstance>(null);
  const track = useRef({ x: 0, width: 0 });
  const latest = useRef({ max, onChange });

  useEffect(() => {
    latest.current = { max, onChange };
  }, [max, onChange]);

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
          moveTo(pageX);
        });
      },
      onPanResponderMove: (event) => moveTo(event.nativeEvent.pageX),
    })
  ).current;

  function moveTo(pageX: number) {
    const { x, width } = track.current;
    const usable = width - THUMB_SIZE;
    if (usable <= 0) return;
    const ratio = Math.min(1, Math.max(0, (pageX - x - THUMB_SIZE / 2) / usable));
    const stepped =
      Math.round((ratio * latest.current.max) / MOMENT_MUSIC_START_STEP_MS) * MOMENT_MUSIC_START_STEP_MS;
    latest.current.onChange(Math.min(latest.current.max, stepped));
  }

  const ratio = max > 0 ? value / max : 0;
  return (
    <View
      ref={trackRef}
      accessibilityRole="adjustable"
      accessibilityLabel={label}
      style={{ height: HIT_HEIGHT, justifyContent: 'center' }}
      {...(max > 0 ? responder.panHandlers : {})}
    >
      <View style={{ height: TRACK_HEIGHT, borderRadius: TRACK_HEIGHT / 2, backgroundColor: withAlpha(colors.primary, 0.2) }} />
      <View
        pointerEvents="none"
        style={{
          position: 'absolute',
          left: `${ratio * 100}%`,
          marginLeft: -ratio * THUMB_SIZE,
          width: THUMB_SIZE,
          height: THUMB_SIZE,
          borderRadius: THUMB_SIZE / 2,
          backgroundColor: colors.primary,
          opacity: max > 0 ? 1 : 0.4,
        }}
      />
    </View>
  );
}

interface MomentMusicPanelProps {
  initial: MomentMusicDraft | null;
  slideCount: number;
  onApply: (music: MomentMusicDraft | null) => void;
  onClose: () => void;
}

export function MomentMusicPanel({ initial, slideCount, onApply, onClose }: MomentMusicPanelProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const bottomInset = useBottomBarInset();
  const [draft, setDraft] = useState<MomentMusicDraft | null>(initial);
  const [pending, setPending] = useState<{ file: NativeUploadFile; fileName: string } | null>(null);
  const [playing, setPlaying] = useState(false);
  const playerRef = useRef<VideoRef>(null);

  const totalMs = draft == null ? 0 : momentMusicTotalMs(draft.slideSeconds, slideCount);
  const maxStart = draft == null ? 0 : momentMusicMaxStartMs(draft.durationMs, draft.slideSeconds, slideCount);

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
    const fitted = fitMomentMusic(
      {
        file,
        url: file.uri,
        fileName,
        title: momentMusicDefaultTitle(fileName),
        durationMs,
        startMs: 0,
        slideSeconds: MOMENT_MUSIC_DEFAULT_SECONDS,
      },
      slideCount
    );
    if (fitted == null) {
      toast.info(t('moment.musicNotFit'));
      return;
    }
    setDraft(fitted);
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
          contentContainerStyle={{ padding: 16, paddingBottom: 16 + bottomInset }}
        >
          <View className="mb-3 flex-row items-center justify-between">
            <Text className="text-base font-semibold" style={{ color: TEXT_PRIMARY }}>
              {t('moment.musicPanelTitle')}
            </Text>
            <Pressable accessibilityRole="button" accessibilityLabel={t('dialog.close')} hitSlop={8} onPress={onClose}>
              <Text style={{ color: TEXT_MUTED, fontSize: 18 }}>✕</Text>
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
              className="flex-row items-center justify-center gap-2 rounded-xl py-6 active:opacity-70"
              style={{ borderWidth: 1, borderStyle: 'dashed', borderColor: colors.primary }}
            >
              <MomentMusicIcon size={20} color={colors.primaryInk} />
              <Text className="text-base font-medium" style={{ color: colors.primaryInk }}>
                {t('moment.musicPick')}
              </Text>
            </Pressable>
          ) : (
            <View style={{ gap: 16 }}>
              <Video
                ref={playerRef}
                source={{ uri: draft.url }}
                paused={!playing}
                progressUpdateInterval={200}
                onProgress={(data) => {
                  if (playing && data.currentTime * MS_PER_SECOND >= draft.startMs + totalMs) {
                    seekToStart(draft.startMs);
                  }
                }}
                onEnd={() => setPlaying(false)}
                onError={handlePendingError}
                style={HIDDEN_PLAYER}
              />
              <View>
                <Text className="mb-1 text-sm" style={{ color: TEXT_MUTED }}>
                  {t('moment.musicName')}
                </Text>
                <TextInput
                  value={draft.title}
                  maxLength={MOMENT_MUSIC_TITLE_MAX}
                  placeholder={t('moment.musicNamePlaceholder')}
                  placeholderTextColor={TEXT_HINT}
                  onChangeText={(title) => setDraft({ ...draft, title })}
                  style={styles.input}
                />
              </View>

              <View>
                <Text className="mb-1 text-sm" style={{ color: TEXT_MUTED }}>
                  {t('moment.musicSlideLength')}
                </Text>
                <View className="flex-row" style={{ gap: 8 }}>
                  {MOMENT_MUSIC_SLIDE_SECONDS.map((seconds) => {
                    const fits = momentMusicFits(draft.durationMs, seconds, slideCount);
                    const selected = draft.slideSeconds === seconds;
                    return (
                      <Pressable
                        key={seconds}
                        accessibilityRole="button"
                        accessibilityState={{ selected, disabled: !fits }}
                        disabled={!fits}
                        onPress={() =>
                          setDraft({
                            ...draft,
                            slideSeconds: seconds,
                            startMs: Math.min(
                              draft.startMs,
                              momentMusicMaxStartMs(draft.durationMs, seconds, slideCount)
                            ),
                          })
                        }
                        className="flex-1 items-center rounded-lg py-2"
                        style={{
                          borderWidth: 1,
                          borderColor: selected ? colors.primary : BORDER,
                          backgroundColor: selected ? colors.primary : 'transparent',
                          opacity: fits ? 1 : 0.4,
                        }}
                      >
                        <Text className="text-sm font-medium" style={{ color: selected ? '#ffffff' : TEXT_PRIMARY }}>
                          {t('moment.musicSeconds', { count: seconds })}
                        </Text>
                      </Pressable>
                    );
                  })}
                </View>
              </View>

              <View>
                <View className="flex-row items-center justify-between">
                  <Text className="text-sm" style={{ color: TEXT_MUTED }}>
                    {t('moment.musicSegment')}
                  </Text>
                  <Text className="text-sm" style={{ color: TEXT_MUTED }}>
                    {formatMomentMusicTime(draft.startMs)} – {formatMomentMusicTime(draft.startMs + totalMs)}
                  </Text>
                </View>
                <MusicStartSlider
                  value={draft.startMs}
                  max={maxStart}
                  label={t('moment.musicSegment')}
                  onChange={changeStart}
                />
                <View className="flex-row justify-between">
                  <Text className="text-xs" style={{ color: TEXT_HINT }}>
                    0:00
                  </Text>
                  <Text className="text-xs" style={{ color: TEXT_HINT }}>
                    {formatMomentMusicTime(draft.durationMs)}
                  </Text>
                </View>
              </View>

              <View className="flex-row items-center" style={{ gap: 8 }}>
                <Pressable
                  accessibilityRole="button"
                  onPress={togglePreview}
                  className="flex-row items-center gap-1.5 rounded-full px-3 py-1.5"
                  style={{ backgroundColor: withAlpha(colors.primary, 0.12) }}
                >
                  {playing ? (
                    <MomentPauseIcon size={16} color={colors.primaryInk} />
                  ) : (
                    <MomentPlayIcon size={16} color={colors.primaryInk} />
                  )}
                  <Text className="text-sm font-medium" style={{ color: colors.primaryInk }}>
                    {t(playing ? 'moment.musicPreviewPause' : 'moment.musicPreviewPlay')}
                  </Text>
                </Pressable>
                <Pressable accessibilityRole="button" onPress={() => void chooseFile()} className="px-3 py-1.5">
                  <Text className="text-sm" style={{ color: TEXT_MUTED }}>
                    {t('moment.musicChange')}
                  </Text>
                </Pressable>
                <Pressable
                  accessibilityRole="button"
                  onPress={() => {
                    setPlaying(false);
                    setDraft(null);
                  }}
                  className="px-3 py-1.5"
                >
                  <Text className="text-sm text-ola-error">{t('moment.musicRemove')}</Text>
                </Pressable>
              </View>
            </View>
          )}

          <Text className="mt-3 text-xs" style={{ color: TEXT_HINT }}>
            {t('moment.musicFormats')}
          </Text>
          <Text className="mt-1 text-xs" style={{ color: TEXT_HINT }}>
            {t('moment.musicRights')}
          </Text>

          <Pressable
            accessibilityRole="button"
            onPress={apply}
            className="mt-3 items-center rounded-full py-2.5 active:opacity-80"
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
  sheet: { flexGrow: 0, backgroundColor: '#ffffff', borderTopLeftRadius: 16, borderTopRightRadius: 16 },
  chip: { backgroundColor: '#ffffff', borderWidth: StyleSheet.hairlineWidth, borderColor: 'rgba(0,0,0,0.1)' },
  input: {
    borderWidth: 1,
    borderColor: BORDER,
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 8,
    fontSize: 14,
    color: TEXT_PRIMARY,
  },
});
