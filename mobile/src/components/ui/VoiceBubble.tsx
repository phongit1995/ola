import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  type GestureResponderEvent,
  Image,
  type LayoutChangeEvent,
  Pressable,
  View,
} from 'react-native';
import Sound from 'react-native-sound';
import { formatDuration } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import {
  activateVoicePlayback,
  deactivateVoicePlayback,
} from '@lib/voicePlaybackSession';
import {
  releaseTemporaryVoiceFile,
  retainTemporaryVoiceFile,
} from '@lib/temporaryVoiceFile';
import { ChatText as Text } from './ChatText';
import { VoiceWaveformBars, VOICE_WAVEFORM_WIDTH } from './VoiceWaveformBars';

const playMediaIcon = require('@assets/icons/chat/ic_play_media.png');
const pauseMediaIcon = require('@assets/icons/chat/ic_pause_media.png');
const playMediaGrayIcon = require('@assets/icons/chat/ic_play_media_gray.png');
const pauseMediaGrayIcon = require('@assets/icons/chat/ic_pause_media_gray.png');

interface VoiceBubbleProps {
  url?: string;
  duration?: string;
  durationSec?: number;
  waveform?: number[];
  isOut: boolean;
  onLongPress?: () => void;
}

export function VoiceBubble({
  url,
  duration,
  durationSec,
  waveform,
  isOut,
  onLongPress,
}: VoiceBubbleProps) {
  const { t } = useTranslation();
  const push = useToastStore(state => state.push);
  const soundRef = useRef<Sound | null>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const mountedRef = useRef(true);
  const playbackOwnerRef = useRef({});
  const waveformWidthRef = useRef(VOICE_WAVEFORM_WIDTH);
  const errorShownRef = useRef(false);
  const loadingRef = useRef(false);
  const leasedUriRef = useRef<string | null>(null);
  const currentTimeRef = useRef(0);
  const loadTokenRef = useRef(0);
  const [playing, setPlaying] = useState(false);
  const [loading, setLoading] = useState(false);
  const [progress, setProgress] = useState(0);
  const [currentTime, setCurrentTime] = useState(0);

  const baseColor = isOut ? '#7cb342' : '#e8f2dc';
  const iconColor = isOut ? '#ffffff' : '#8f8f8f';
  const badgeColor = isOut ? '#33691e' : '#ffffff';
  const badgeBackground = isOut ? '#ffffff' : '#8f8f8f';
  const playSource = isOut ? playMediaIcon : playMediaGrayIcon;
  const pauseSource = isOut ? pauseMediaIcon : pauseMediaGrayIcon;

  const clearTimer = useCallback(() => {
    if (timerRef.current != null) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
  }, []);

  const stopSelf = useCallback(() => {
    clearTimer();
    const sound = soundRef.current;
    if (sound != null) sound.pause();
    if (mountedRef.current) {
      setPlaying(false);
      setLoading(false);
    }
  }, [clearTimer]);

  const release = useCallback(
    (resetPosition: boolean) => {
      clearTimer();
      const sound = soundRef.current;
      const leasedUri = leasedUriRef.current;
      soundRef.current = null;
      leasedUriRef.current = null;
      loadingRef.current = false;
      // Huỷ luôn lượt load đang bay: callback của nó sẽ không được phát nữa.
      loadTokenRef.current += 1;
      if (sound != null) {
        // Native release() dừng và gỡ player khỏi pool trong cùng một lệnh.
        sound.release();
      }
      if (leasedUri != null) releaseTemporaryVoiceFile(leasedUri);
      deactivateVoicePlayback(playbackOwnerRef.current);
      if (resetPosition) currentTimeRef.current = 0;
      if (mountedRef.current) {
        setPlaying(false);
        setLoading(false);
        if (resetPosition) {
          setProgress(0);
          setCurrentTime(0);
        }
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
      setLoading(false);
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
  }, [release]);

  function startProgressTimer(total: number) {
    clearTimer();
    timerRef.current = setInterval(() => {
      const sound = soundRef.current;
      if (sound == null) return;
      sound.getCurrentTime(seconds => {
        if (!mountedRef.current) return;
        const base = total > 0 ? total : durationSec ?? 0;
        currentTimeRef.current = seconds;
        setCurrentTime(seconds);
        setProgress(base > 0 ? Math.min(1, seconds / base) : 0);
      });
    }, 200);
  }

  function playFrom(sound: Sound) {
    activateVoicePlayback(playbackOwnerRef.current, releaseForReplacement);
    const resumeAt = currentTimeRef.current;
    if (resumeAt > 0) sound.setCurrentTime(resumeAt);
    setPlaying(true);
    setLoading(false);
    startProgressTimer(sound.getDuration());
    sound.play(success => {
      if (soundRef.current !== sound) return;
      clearTimer();
      if (!mountedRef.current) return;
      setPlaying(false);
      setLoading(false);
      setProgress(0);
      setCurrentTime(0);
      currentTimeRef.current = 0;
      if (!success) {
        const leasedUri = leasedUriRef.current;
        soundRef.current = null;
        leasedUriRef.current = null;
        deactivateVoicePlayback(playbackOwnerRef.current);
        sound.release();
        if (leasedUri != null) releaseTemporaryVoiceFile(leasedUri);
        reportPlaybackError();
        return;
      }
      sound.setCurrentTime(0);
    });
  }

  function toggle() {
    if (url == null || url === '' || loadingRef.current) return;
    Sound.setCategory('Playback');
    const existing = soundRef.current;
    if (existing != null) {
      if (playing) {
        stopSelf();
      } else {
        errorShownRef.current = false;
        playFrom(existing);
      }
      return;
    }

    errorShownRef.current = false;
    loadingRef.current = true;
    setLoading(true);
    // Nhận quyền phát ngay từ lúc bắt đầu load, không đợi load xong: bấm ghi âm
    // giữa chừng thì releaseVoicePlayback() mới thấy và huỷ được lượt này.
    activateVoicePlayback(playbackOwnerRef.current, releaseForReplacement);
    const loadToken = ++loadTokenRef.current;
    const sourceUrl = url;
    retainTemporaryVoiceFile(sourceUrl);
    const sound = new Sound(sourceUrl, undefined, error => {
      loadingRef.current = false;
      if (!mountedRef.current || loadToken !== loadTokenRef.current) {
        sound.release();
        releaseTemporaryVoiceFile(sourceUrl);
        return;
      }
      setLoading(false);
      if (error != null) {
        soundRef.current = null;
        sound.release();
        releaseTemporaryVoiceFile(sourceUrl);
        deactivateVoicePlayback(playbackOwnerRef.current);
        reportPlaybackError();
        return;
      }
      soundRef.current = sound;
      leasedUriRef.current = sourceUrl;
      playFrom(sound);
    });
  }

  function handleWaveformLayout(event: LayoutChangeEvent) {
    waveformWidthRef.current = event.nativeEvent.layout.width;
  }

  function seek(event: GestureResponderEvent) {
    const sound = soundRef.current;
    const width = waveformWidthRef.current;
    const total =
      sound != null && sound.getDuration() > 0
        ? sound.getDuration()
        : durationSec ?? 0;
    if (width <= 0 || total <= 0) return;
    const ratio = Math.min(1, Math.max(0, event.nativeEvent.locationX / width));
    const seconds = total * ratio;
    sound?.setCurrentTime(seconds);
    currentTimeRef.current = seconds;
    setCurrentTime(seconds);
    setProgress(ratio);
  }

  const shownDuration =
    playing || currentTime > 0
      ? formatDuration(Math.floor(currentTime))
      : duration;

  return (
    <View
      className="h-10 w-48 flex-row items-center gap-2 overflow-hidden rounded-full px-2"
      style={{ backgroundColor: baseColor }}
    >
      <Pressable
        onPress={toggle}
        onLongPress={onLongPress}
        delayLongPress={300}
        accessibilityLabel={
          playing ? t('chat.voicePause') : t('chat.voicePlay')
        }
        className="h-7 w-7 shrink-0 items-center justify-center"
      >
        {loading ? (
          <ActivityIndicator size="small" color={iconColor} />
        ) : (
          <Image
            source={playing ? pauseSource : playSource}
            style={{ width: 20, height: 20 }}
            resizeMode="contain"
          />
        )}
      </Pressable>

      <Pressable
        onLayout={handleWaveformLayout}
        onPress={seek}
        onLongPress={onLongPress}
        delayLongPress={300}
        accessibilityLabel={t('chat.voiceSeek')}
        className="h-7 flex-row items-center justify-center"
        style={{ flex: 1, minWidth: 0 }}
      >
        <VoiceWaveformBars
          waveform={waveform}
          duration={durationSec}
          progress={progress}
          tone={isOut ? 'outgoing' : 'incoming'}
        />
      </Pressable>

      <View
        className="shrink-0 rounded-full px-2 py-0.5"
        style={{ backgroundColor: badgeBackground }}
      >
        <Text
          className="text-[11px] font-medium"
          style={{ color: badgeColor, fontVariant: ['tabular-nums'] }}
        >
          {shownDuration}
        </Text>
      </View>
    </View>
  );
}
