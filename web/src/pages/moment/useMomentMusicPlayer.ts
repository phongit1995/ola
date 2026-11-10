import { useEffect, useRef } from 'react';
import { useMomentMusicGate } from '@ola/shared/stores/moment/useMomentMusicGate';

const AUTOPLAY_BLOCKED_ERROR = 'NotAllowedError';
const PLAY_INTERRUPTED_ERROR = 'AbortError';

interface MomentMusicPlayerOptions {
  url: string | undefined;
  playId: number;
  paused: boolean;
  muted: boolean;
  onAutoplayBlocked: () => void;
}

export function useMomentMusicPlayer({
  url,
  playId,
  paused,
  muted,
  onAutoplayBlocked,
}: MomentMusicPlayerOptions) {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const { waiting, markPlaying, markBuffering, markFailed } = useMomentMusicGate(
    url == null ? null : `${url}:${playId}`,
    !paused
  );

  useEffect(() => {
    const audio = new Audio();
    audio.preload = 'auto';
    audioRef.current = audio;
    return () => {
      audio.pause();
      audio.removeAttribute('src');
      audio.load();
      audioRef.current = null;
    };
  }, []);

  useEffect(() => {
    const audio = audioRef.current;
    if (audio == null) return;
    audio.pause();
    if (url == null) {
      audio.removeAttribute('src');
      return;
    }
    audio.src = url;
    audio.currentTime = 0;
  }, [url, playId]);

  useEffect(() => {
    const audio = audioRef.current;
    if (audio == null || url == null) return;
    audio.addEventListener('playing', markPlaying);
    audio.addEventListener('waiting', markBuffering);
    audio.addEventListener('error', markFailed);
    return () => {
      audio.removeEventListener('playing', markPlaying);
      audio.removeEventListener('waiting', markBuffering);
      audio.removeEventListener('error', markFailed);
    };
  }, [url, playId, markPlaying, markBuffering, markFailed]);

  useEffect(() => {
    const audio = audioRef.current;
    if (audio == null) return;
    audio.muted = muted;
    if (url == null || paused) {
      audio.pause();
      return;
    }
    audio.play().catch((error: unknown) => {
      if (!(error instanceof DOMException)) return;
      if (error.name === AUTOPLAY_BLOCKED_ERROR) onAutoplayBlocked();
      else if (error.name !== PLAY_INTERRUPTED_ERROR) markFailed();
    });
  }, [url, playId, paused, muted, onAutoplayBlocked, markFailed]);

  return { waiting };
}
