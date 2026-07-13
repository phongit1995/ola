import { useEffect, useRef, useState } from 'react';
import { ActivityIndicator, Image, Pressable, Text, View } from 'react-native';
import Sound from 'react-native-sound';

const playMediaIcon = require('../assets/icons/chat/ic_play_media.png');
const pauseMediaIcon = require('../assets/icons/chat/ic_pause_media.png');
const playMediaGrayIcon = require('../assets/icons/chat/ic_play_media_gray.png');
const pauseMediaGrayIcon = require('../assets/icons/chat/ic_pause_media_gray.png');

Sound.setCategory('Playback');

let activeStop: (() => void) | null = null;

interface VoiceBubbleProps {
  url?: string;
  duration?: string;
  durationSec?: number;
  isOut: boolean;
}

export function VoiceBubble({ url, duration, durationSec, isOut }: VoiceBubbleProps) {
  const soundRef = useRef<Sound | null>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const [playing, setPlaying] = useState(false);
  const [loading, setLoading] = useState(false);
  const [progress, setProgress] = useState(0);

  const trackColor = isOut ? '#7cb342' : '#e8f2dc';
  const fillColor = isOut ? '#558b2f' : '#7cb342';
  const iconColor = isOut ? '#ffffff' : '#8f8f8f';
  const badgeBg = isOut ? '#ffffff' : '#8f8f8f';
  const badgeColor = isOut ? '#33691e' : '#ffffff';
  const playSrc = isOut ? playMediaIcon : playMediaGrayIcon;
  const pauseSrc = isOut ? pauseMediaIcon : pauseMediaGrayIcon;

  function clearTimer() {
    if (timerRef.current != null) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
  }

  function release() {
    clearTimer();
    const sound = soundRef.current;
    if (sound != null) {
      sound.stop(() => sound.release());
      soundRef.current = null;
    }
    if (activeStop === stopSelf) activeStop = null;
  }

  function stopSelf() {
    clearTimer();
    const sound = soundRef.current;
    if (sound != null) sound.pause();
    setPlaying(false);
  }

  useEffect(() => release, []);

  function startProgressTimer(total: number) {
    clearTimer();
    timerRef.current = setInterval(() => {
      const sound = soundRef.current;
      if (sound == null) return;
      sound.getCurrentTime((seconds) => {
        const base = total > 0 ? total : durationSec ?? 0;
        setProgress(base > 0 ? Math.min(1, seconds / base) : 0);
      });
    }, 200);
  }

  function playFrom(sound: Sound) {
    if (activeStop != null && activeStop !== stopSelf) activeStop();
    activeStop = stopSelf;
    setPlaying(true);
    startProgressTimer(sound.getDuration());
    sound.play((success) => {
      clearTimer();
      setPlaying(false);
      setProgress(0);
      if (!success) sound.reset();
      sound.setCurrentTime(0);
    });
  }

  function toggle() {
    if (url == null || url === '') return;
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
    setLoading(true);
    const sound = new Sound(url, undefined, (error) => {
      setLoading(false);
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
      className="relative h-10 w-44 flex-row items-center gap-2 overflow-hidden rounded-full px-2"
      style={{ backgroundColor: trackColor }}
    >
      <View
        className="absolute inset-y-0 left-0"
        style={{ width: `${Math.round(progress * 100)}%`, backgroundColor: fillColor }}
      />
      <Pressable onPress={toggle} className="h-7 w-7 items-center justify-center">
        {loading ? (
          <ActivityIndicator size="small" color={iconColor} />
        ) : (
          <Image source={playing ? pauseSrc : playSrc} style={{ width: 20, height: 20 }} resizeMode="contain" />
        )}
      </Pressable>
      <View className="h-0.5 flex-1 rounded-full bg-white" />
      <View className="rounded-full px-2 py-0.5" style={{ backgroundColor: badgeBg }}>
        <Text className="text-[11px] font-medium" style={{ color: badgeColor }}>
          {duration}
        </Text>
      </View>
    </View>
  );
}
