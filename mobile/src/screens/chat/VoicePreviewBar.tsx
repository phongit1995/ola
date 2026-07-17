import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import Sound from 'react-native-sound';

const playIcon = require('@assets/icons/chat/ic_play_media_gray.png');
const pauseIcon = require('@assets/icons/chat/ic_pause_media_gray.png');
const sendIcon = require('@assets/icons/chat/ic_action_send_white.png');
const deleteIcon = require('@assets/icons/chat/ic_menu_delete.png');

function formatDurationSec(sec: number): string {
  const mm = Math.floor(sec / 60);
  const ss = sec % 60;
  return `${mm}:${ss.toString().padStart(2, '0')}`;
}

interface VoicePreviewBarProps {
  uri: string;
  duration: number;
  onSend: () => void;
  onDiscard: () => void;
}

export function VoicePreviewBar({ uri, duration, onSend, onDiscard }: VoicePreviewBarProps) {
  const { t } = useTranslation();
  const soundRef = useRef<Sound | null>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const [playing, setPlaying] = useState(false);
  const [progress, setProgress] = useState(0);

  function clearTimer() {
    if (timerRef.current != null) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
  }

  useEffect(() => {
    return () => {
      clearTimer();
      soundRef.current?.stop(() => soundRef.current?.release());
    };
  }, []);

  function playFrom(sound: Sound) {
    setPlaying(true);
    clearTimer();
    timerRef.current = setInterval(() => {
      sound.getCurrentTime((seconds) => {
        setProgress(duration > 0 ? Math.min(1, seconds / duration) : 0);
      });
    }, 200);
    sound.play((success) => {
      clearTimer();
      setPlaying(false);
      setProgress(0);
      if (!success) sound.reset();
      sound.setCurrentTime(0);
    });
  }

  function toggle() {
    const existing = soundRef.current;
    if (existing != null) {
      if (playing) {
        clearTimer();
        existing.pause();
        setPlaying(false);
      } else {
        playFrom(existing);
      }
      return;
    }
    const sound = new Sound(uri, undefined, (error) => {
      if (error != null) {
        soundRef.current = null;
        return;
      }
      soundRef.current = sound;
      playFrom(sound);
    });
  }

  return (
    <View
      className="flex-row items-center gap-3 px-3 py-2"
      style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)', backgroundColor: '#e8f2dc' }}
    >
      <Pressable onPress={toggle} className="h-9 w-9 items-center justify-center">
        <Image source={playing ? pauseIcon : playIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
      </Pressable>
      <View className="h-1 flex-1 overflow-hidden rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.15)' }}>
        <View
          className="h-full rounded-full"
          style={{ width: `${Math.round(progress * 100)}%`, backgroundColor: '#7cb342' }}
        />
      </View>
      <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
        {formatDurationSec(duration)}
      </Text>
      <Pressable onPress={onDiscard} className="h-9 w-9 items-center justify-center" accessibilityLabel={t('chat.voiceDiscard')}>
        <Image source={deleteIcon} style={{ width: 20, height: 20 }} resizeMode="contain" />
      </Pressable>
      <Pressable
        onPress={onSend}
        className="h-9 w-9 items-center justify-center rounded-full"
        style={{ backgroundColor: '#7cb342' }}
        accessibilityLabel={t('chat.send')}
      >
        <Image source={sendIcon} style={{ width: 20, height: 20 }} resizeMode="contain" />
      </Pressable>
    </View>
  );
}
