import { useRef, useState, type MouseEvent as ReactMouseEvent } from 'react';
import { useTranslation } from 'react-i18next';
import playMediaIcon from '@/assets/icons/chat/ic_play_media.png';
import pauseMediaIcon from '@/assets/icons/chat/ic_pause_media.png';
import playMediaGrayIcon from '@/assets/icons/chat/ic_play_media_gray.png';
import pauseMediaGrayIcon from '@/assets/icons/chat/ic_pause_media_gray.png';
import { formatDuration, toast } from '@lib';
import {
  VoiceWaveformBars,
  VOICE_WAVEFORM_WIDTH_CLASS,
} from './VoiceWaveformBars';

interface VoiceBubbleProps {
  url?: string;
  duration?: string;
  durationSec?: number;
  waveform?: number[];
  isOut: boolean;
}

export function VoiceBubble({
  url,
  duration,
  durationSec,
  waveform,
  isOut,
}: VoiceBubbleProps) {
  const { t } = useTranslation();
  const audioRef = useRef<HTMLAudioElement>(null);
  const errorShownRef = useRef(false);
  const [playing, setPlaying] = useState(false);
  const [loading, setLoading] = useState(false);
  const [progress, setProgress] = useState(0);
  const [currentTime, setCurrentTime] = useState(0);

  const baseClass = isOut ? 'bg-ola-primary' : 'bg-ola-primary-light';
  const badgeClass = isOut
    ? 'bg-white text-ola-primary-darker'
    : 'bg-[#8f8f8f] text-white';
  const iconColor = isOut ? '#ffffff' : '#8f8f8f';
  const playSrc = isOut ? playMediaIcon : playMediaGrayIcon;
  const pauseSrc = isOut ? pauseMediaIcon : pauseMediaGrayIcon;

  function reportPlaybackError() {
    setPlaying(false);
    setLoading(false);
    if (errorShownRef.current) return;
    errorShownRef.current = true;
    toast.error(t('chat.voicePlaybackError'));
  }

  function toggle() {
    const el = audioRef.current;
    if (el == null || url == null || url === '') return;
    if (el.paused) {
      errorShownRef.current = false;
      setLoading(true);
      void el.play().catch(reportPlaybackError);
    } else el.pause();
  }

  function seek(event: ReactMouseEvent<HTMLButtonElement>) {
    const el = audioRef.current;
    if (el == null || url == null || url === '') return;
    const rect = event.currentTarget.getBoundingClientRect();
    const ratio =
      rect.width > 0
        ? Math.min(1, Math.max(0, (event.clientX - rect.left) / rect.width))
        : 0;
    const total =
      Number.isFinite(el.duration) && el.duration > 0
        ? el.duration
        : (durationSec ?? 0);
    if (total <= 0) return;
    el.currentTime = total * ratio;
    setProgress(ratio);
    setCurrentTime(total * ratio);
  }

  return (
    <div
      onClick={(event) => event.stopPropagation()}
      className={`relative flex h-10 w-48 items-center gap-2 overflow-hidden rounded-full px-2 ${baseClass}`}
    >
      <button
        type="button"
        onClick={toggle}
        aria-label={playing ? t('chat.voicePause') : t('chat.voicePlay')}
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
      <button
        type="button"
        onClick={seek}
        aria-label={t('chat.voiceSeek')}
        className={`relative flex h-7 ${VOICE_WAVEFORM_WIDTH_CLASS} shrink-0 items-center justify-center`}
      >
        <VoiceWaveformBars
          waveform={waveform}
          duration={durationSec}
          progress={progress}
          tone={isOut ? 'outgoing' : 'incoming'}
        />
      </button>
      <span
        className={`relative shrink-0 rounded-full px-2 py-0.5 text-[11px] font-medium ${badgeClass}`}
      >
        {playing || currentTime > 0
          ? formatDuration(Math.floor(currentTime))
          : duration}
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
        onPlaying={() => {
          errorShownRef.current = false;
          setLoading(false);
        }}
        onEnded={() => {
          setPlaying(false);
          setLoading(false);
          setProgress(0);
          setCurrentTime(0);
        }}
        onError={reportPlaybackError}
        onTimeUpdate={(event) => {
          const el = event.currentTarget;
          const total =
            Number.isFinite(el.duration) && el.duration > 0
              ? el.duration
              : (durationSec ?? 0);
          setCurrentTime(el.currentTime);
          setProgress(total > 0 ? Math.min(1, el.currentTime / total) : 0);
        }}
      />
    </div>
  );
}
