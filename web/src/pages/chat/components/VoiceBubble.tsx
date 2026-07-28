import { useRef, useState } from 'react';
import playMediaIcon from '@/assets/icons/chat/ic_play_media.png';
import pauseMediaIcon from '@/assets/icons/chat/ic_pause_media.png';
import playMediaGrayIcon from '@/assets/icons/chat/ic_play_media_gray.png';
import pauseMediaGrayIcon from '@/assets/icons/chat/ic_pause_media_gray.png';

interface VoiceBubbleProps {
  url?: string;
  duration?: string;
  durationSec?: number;
  isOut: boolean;
}

export function VoiceBubble({
  url,
  duration,
  durationSec,
  isOut,
}: VoiceBubbleProps) {
  const audioRef = useRef<HTMLAudioElement>(null);
  const [playing, setPlaying] = useState(false);
  const [loading, setLoading] = useState(false);
  const [progress, setProgress] = useState(0);

  const baseClass = isOut ? 'bg-ola-primary' : 'bg-ola-primary-light';
  const fillClass = isOut ? 'bg-ola-primary-dark' : 'bg-ola-primary';
  const badgeClass = isOut
    ? 'bg-white text-ola-primary-darker'
    : 'bg-[#8f8f8f] text-white';
  const iconColor = isOut ? '#ffffff' : '#8f8f8f';
  const playSrc = isOut ? playMediaIcon : playMediaGrayIcon;
  const pauseSrc = isOut ? pauseMediaIcon : pauseMediaGrayIcon;

  function toggle() {
    const el = audioRef.current;
    if (el == null || url == null || url === '') return;
    if (el.paused) void el.play().catch(() => setLoading(false));
    else el.pause();
  }

  return (
    <div
      className={`relative flex h-10 w-44 items-center gap-2 overflow-hidden rounded-full px-2 ${baseClass}`}
    >
      <span
        className={`absolute inset-y-0 left-0 ${fillClass}`}
        style={{ width: `${Math.round(progress * 100)}%` }}
      />
      <button
        type="button"
        onClick={toggle}
        aria-label="play"
        className="relative flex h-7 w-7 shrink-0 items-center justify-center"
      >
        {loading ? (
          <span
            className="h-4 w-4 animate-spin rounded-full border-2 border-t-transparent"
            style={{ borderColor: iconColor, borderTopColor: 'transparent' }}
          />
        ) : (
          <img
            src={playing ? pauseSrc : playSrc}
            alt=""
            className="h-5 w-5 object-contain"
          />
        )}
      </button>
      <span className="relative h-0.5 flex-1 rounded-full bg-white" />
      <span
        className={`relative shrink-0 rounded-full px-2 py-0.5 text-[11px] font-medium ${badgeClass}`}
      >
        {duration}
      </span>
      <audio
        ref={audioRef}
        src={url}
        preload="metadata"
        className="hidden"
        onPlay={() => setPlaying(true)}
        onPause={() => {
          setPlaying(false);
          setLoading(false);
        }}
        onWaiting={() => setLoading(true)}
        onPlaying={() => setLoading(false)}
        onEnded={() => {
          setPlaying(false);
          setLoading(false);
          setProgress(0);
        }}
        onTimeUpdate={(event) => {
          const el = event.currentTarget;
          const total =
            Number.isFinite(el.duration) && el.duration > 0
              ? el.duration
              : (durationSec ?? 0);
          setProgress(total > 0 ? Math.min(1, el.currentTime / total) : 0);
        }}
      />
    </div>
  );
}
