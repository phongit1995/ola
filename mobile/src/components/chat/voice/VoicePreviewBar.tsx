import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  type GestureResponderEvent,
  type LayoutChangeEvent,
  Pressable,
  View,
} from 'react-native';
import Sound from 'react-native-sound';
import { formatDuration } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { ChatText as Text } from '@components/ui/ChatText';
import { VoiceWaveformBars } from '@components/ui/VoiceWaveformBars';
import {
  activateVoicePlayback,
  deactivateVoicePlayback,
} from '@lib/voicePlaybackSession';
import {
  releaseTemporaryVoiceFile,
  retainTemporaryVoiceFile,
} from '@lib/temporaryVoiceFile';
import { DIVIDER } from '@constants';

const playIcon = require('@assets/icons/chat/ic_play_media_gray.png');
const pauseIcon = require('@assets/icons/chat/ic_pause_media_gray.png');
const sendIcon = require('@assets/icons/chat/ic_action_send_white.png');
const deleteIcon = require('@assets/icons/chat/ic_menu_delete.png');

interface VoicePreviewBarProps {
  uri: string;
  duration: number;
  waveform?: number[];
  bottomInset?: number;
  onSend: () => void;
  onDiscard: () => void;
}

export function VoicePreviewBar({
  uri,
  duration,
  waveform,
  bottomInset = 0,
  onSend,
  onDiscard,
}: VoicePreviewBarProps) {
  const { t } = useTranslation();
  const push = useToastStore(state => state.push);
  const soundRef = useRef<Sound | null>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const mountedRef = useRef(true);
  const playbackOwnerRef = useRef({});
  const waveformWidthRef = useRef(0);
  const errorShownRef = useRef(false);
  const loadingRef = useRef(false);
  const leasedUriRef = useRef<string | null>(null);
  const currentTimeRef = useRef(0);
  const loadTokenRef = useRef(0);
  const [playing, setPlaying] = useState(false);
  const [progress, setProgress] = useState(0);

  const clearTimer = useCallback(() => {
    if (timerRef.current != null) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
  }, []);

  const release = useCallback(
    (resetPosition: boolean) => {
      clearTimer();
      // Huỷ lượt load đang bay để callback của nó không thể phát sau khi
      // recorder (hoặc một voice khác) đã giành playback session.
      loadTokenRef.current += 1;
      const sound = soundRef.current;
      const leasedUri = leasedUriRef.current;
      soundRef.current = null;
      leasedUriRef.current = null;
      loadingRef.current = false;
      if (sound != null) {
        // Native release() dừng và gỡ player khỏi pool trong cùng một lệnh.
        sound.release();
      }
      if (leasedUri != null) releaseTemporaryVoiceFile(leasedUri);
      deactivateVoicePlayback(playbackOwnerRef.current);
      if (resetPosition) currentTimeRef.current = 0;
      if (mountedRef.current) {
        setPlaying(false);
        if (resetPosition) setProgress(0);
      }
    },
    [clearTimer],
  );

  const releaseForReplacement = useCallback(() => {
    release(true);
  }, [release]);

  const reportPlaybackError = useCallback(() => {
    if (mountedRef.current) {
      setPlaying(false);
      setProgress(0);
    }
    if (errorShownRef.current) return;
    errorShownRef.current = true;
    push('error', t('chat.voicePlaybackError'));
  }, [push, t]);

  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
      release(true);
    };
  }, [release, uri]);

  function playFrom(sound: Sound) {
    activateVoicePlayback(playbackOwnerRef.current, releaseForReplacement);
    const resumeAt = currentTimeRef.current;
    // Tiếp tục sau khi pause thì start() tự chạy từ chỗ đang dừng, không cần
    // seek. Chỉ seek khi player biết độ dài thật: seek trên player có
    // duration = 0 bị coi là "past end" và làm media extractor của máy abort.
    if (resumeAt > 0 && sound.getDuration() > 0) sound.setCurrentTime(resumeAt);
    setPlaying(true);
    clearTimer();
    timerRef.current = setInterval(() => {
      sound.getCurrentTime(seconds => {
        if (!mountedRef.current) return;
        currentTimeRef.current = seconds;
        setProgress(duration > 0 ? Math.min(1, seconds / duration) : 0);
      });
    }, 200);
    sound.play(success => {
      if (soundRef.current !== sound) return;
      // Phát xong là bỏ hẳn player, lần sau tạo mới. Dùng lại MediaPlayer ở
      // trạng thái PlaybackCompleted làm media extractor của máy chết (MIUI:
      // libmmparser_lite.so abort -> MEDIA_ERROR_SERVER_DIED), lần phát thứ hai
      // luôn hỏng.
      clearTimer();
      const leasedUri = leasedUriRef.current;
      soundRef.current = null;
      leasedUriRef.current = null;
      currentTimeRef.current = 0;
      deactivateVoicePlayback(playbackOwnerRef.current);
      sound.release();
      if (leasedUri != null) releaseTemporaryVoiceFile(leasedUri);
      if (mountedRef.current) {
        setPlaying(false);
        setProgress(0);
      }
      if (!success) reportPlaybackError();
    });
  }

  function toggle() {
    if (loadingRef.current) return;
    // mixWithOthers phải là true như mọi chỗ khác trong app: mặc định false của
    // lib bật nhánh audio-focus của react-native-sound trên Android, nhánh đó
    // không nhả focus đúng và đụng MediaPlayer từ main thread.
    Sound.setCategory('Playback', true);
    const existing = soundRef.current;
    if (existing != null) {
      if (playing) {
        clearTimer();
        existing.pause();
        setPlaying(false);
      } else {
        errorShownRef.current = false;
        playFrom(existing);
      }
      return;
    }

    errorShownRef.current = false;
    loadingRef.current = true;
    // Đăng ký ngay từ lúc load để releaseVoicePlayback() có thể huỷ lượt này
    // nếu recorder bắt đầu trước khi callback của Sound chạy.
    activateVoicePlayback(playbackOwnerRef.current, releaseForReplacement);
    const loadToken = ++loadTokenRef.current;
    retainTemporaryVoiceFile(uri);
    const sound = new Sound(uri, undefined, error => {
      loadingRef.current = false;
      if (!mountedRef.current || loadToken !== loadTokenRef.current) {
        sound.release();
        releaseTemporaryVoiceFile(uri);
        return;
      }
      if (error != null) {
        soundRef.current = null;
        sound.release();
        releaseTemporaryVoiceFile(uri);
        deactivateVoicePlayback(playbackOwnerRef.current);
        reportPlaybackError();
        return;
      }
      soundRef.current = sound;
      leasedUriRef.current = uri;
      playFrom(sound);
    });
  }

  function handleWaveformLayout(event: LayoutChangeEvent) {
    waveformWidthRef.current = event.nativeEvent.layout.width;
  }

  function seek(event: GestureResponderEvent) {
    const sound = soundRef.current;
    const width = waveformWidthRef.current;
    if (width <= 0 || duration <= 0) return;
    const ratio = Math.min(1, Math.max(0, event.nativeEvent.locationX / width));
    const seconds = duration * ratio;
    if (sound != null && sound.getDuration() > 0) sound.setCurrentTime(seconds);
    currentTimeRef.current = seconds;
    setProgress(ratio);
  }

  return (
    <View
      className="min-h-12 flex-row items-center gap-2 bg-white px-3 py-1.5"
      style={{
        borderTopWidth: 1,
        borderTopColor: DIVIDER,
        paddingBottom: Math.max(6, bottomInset),
      }}
    >
      <Pressable
        onPress={toggle}
        accessibilityLabel={
          playing ? t('chat.voicePause') : t('chat.voicePlay')
        }
        className="h-9 w-9 items-center justify-center rounded-full bg-ola-primary-light active:opacity-80"
      >
        <Image
          source={playing ? pauseIcon : playIcon}
          style={{ width: 24, height: 24 }}
          resizeMode="contain"
        />
      </Pressable>

      <Pressable
        onLayout={handleWaveformLayout}
        onPress={seek}
        accessibilityLabel={t('chat.voiceSeek')}
        className="h-8 min-w-0 flex-1 flex-row items-center justify-center"
      >
        <VoiceWaveformBars
          waveform={waveform}
          duration={duration}
          progress={progress}
          tone="preview"
          fluid
        />
      </Pressable>

      <Text
        className="shrink-0 text-xs text-ola-ink-soft"
        style={{ fontVariant: ['tabular-nums'] }}
      >
        {formatDuration(duration)}
      </Text>

      <Pressable
        onPress={onDiscard}
        accessibilityLabel={t('chat.voiceDiscard')}
        className="h-9 w-9 items-center justify-center active:opacity-70"
      >
        <Image
          source={deleteIcon}
          style={{ width: 20, height: 20 }}
          resizeMode="contain"
        />
      </Pressable>

      <Pressable
        onPress={onSend}
        accessibilityLabel={t('chat.send')}
        className="h-9 w-9 items-center justify-center rounded-full bg-ola-primary active:opacity-80"
      >
        <Image
          source={sendIcon}
          style={{ width: 20, height: 20 }}
          resizeMode="contain"
        />
      </Pressable>
    </View>
  );
}
