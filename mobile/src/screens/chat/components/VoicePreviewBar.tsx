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
import { useToastStore } from '@ola/shared/stores/toastStore';
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
      const sound = soundRef.current;
      const leasedUri = leasedUriRef.current;
      soundRef.current = null;
      leasedUriRef.current = null;
      loadingRef.current = false;
      if (sound != null) {
        sound.stop(() => sound.release());
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
    if (resumeAt > 0) sound.setCurrentTime(resumeAt);
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
      clearTimer();
      if (!mountedRef.current) return;
      setPlaying(false);
      setProgress(0);
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
    if (loadingRef.current) return;
    Sound.setCategory('Playback');
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
    retainTemporaryVoiceFile(uri);
    const sound = new Sound(uri, undefined, error => {
      loadingRef.current = false;
      if (!mountedRef.current) {
        sound.release();
        releaseTemporaryVoiceFile(uri);
        return;
      }
      if (error != null) {
        soundRef.current = null;
        sound.release();
        releaseTemporaryVoiceFile(uri);
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
    sound?.setCurrentTime(seconds);
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
