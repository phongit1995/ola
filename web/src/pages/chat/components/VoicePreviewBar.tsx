import {
  useEffect,
  useRef,
  useState,
  type MouseEvent as ReactMouseEvent,
} from 'react';
import { useTranslation } from 'react-i18next';
import playIcon from '@/assets/icons/chat/ic_play_media_gray.png';
import pauseIcon from '@/assets/icons/chat/ic_pause_media_gray.png';
import sendIcon from '@/assets/icons/chat/ic_action_send_white.png';
import deleteIcon from '@/assets/icons/chat/ic_menu_delete.png';
import { formatDuration, toast } from '@lib';
import { VoiceWaveformBars } from './VoiceWaveformBars';

interface VoicePreviewBarProps {
  blob: Blob;
  duration: number;
  waveform?: number[];
  onSend: () => void;
  onDiscard: () => void;
}

export function VoicePreviewBar({
  blob,
  duration,
  waveform,
  onSend,
  onDiscard,
}: VoicePreviewBarProps) {
  const { t } = useTranslation();
  const [url, setUrl] = useState('');
  const audioRef = useRef<HTMLAudioElement>(null);
  const errorShownRef = useRef(false);
  const [playing, setPlaying] = useState(false);
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    const nextUrl = URL.createObjectURL(blob);
    // eslint-disable-next-line react-hooks/set-state-in-effect -- recreate the object URL when the blob changes
    setUrl(nextUrl);
    return () => URL.revokeObjectURL(nextUrl);
  }, [blob]);

  function reportPlaybackError() {
    setPlaying(false);
    if (errorShownRef.current) return;
    errorShownRef.current = true;
    toast.error(t('chat.voicePlaybackError'));
  }

  function toggle() {
    const el = audioRef.current;
    if (el == null || url === '') return;
    if (el.paused) {
      errorShownRef.current = false;
      void el.play().catch(reportPlaybackError);
    } else el.pause();
  }

  function seek(event: ReactMouseEvent<HTMLButtonElement>) {
    const el = audioRef.current;
    if (el == null) return;
    const rect = event.currentTarget.getBoundingClientRect();
    const ratio =
      rect.width > 0
        ? Math.min(1, Math.max(0, (event.clientX - rect.left) / rect.width))
        : 0;
    const total =
      Number.isFinite(el.duration) && el.duration > 0 ? el.duration : duration;
    if (total > 0) {
      el.currentTime = total * ratio;
      setProgress(ratio);
    }
  }

  return (
    <div className="flex min-h-10 min-w-0 flex-1 items-center gap-2">
      <button
        type="button"
        onClick={toggle}
        aria-label={playing ? t('chat.voicePause') : t('chat.voicePlay')}
        className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-ola-primary-light transition active:scale-95"
      >
        <img
          src={playing ? pauseIcon : playIcon}
          alt=""
          className="h-6 w-6 object-contain"
        />
      </button>
      <button
        type="button"
        onClick={seek}
        aria-label={t('chat.voiceSeek')}
        className="flex h-8 min-w-0 flex-1 items-center justify-center"
      >
        <VoiceWaveformBars
          waveform={waveform}
          duration={duration}
          progress={progress}
          tone="preview"
          fluid
        />
      </button>
      <span className="shrink-0 text-xs text-black/54">
        {formatDuration(duration)}
      </span>
      <button
        type="button"
        onClick={onDiscard}
        aria-label={t('chat.voiceDiscard')}
        className="flex h-9 w-9 shrink-0 items-center justify-center"
      >
        <img src={deleteIcon} alt="" className="h-5 w-5 object-contain" />
      </button>
      <button
        type="button"
        onClick={onSend}
        aria-label={t('chat.send')}
        className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-ola-primary"
      >
        <img src={sendIcon} alt="" className="h-5 w-5 object-contain" />
      </button>
      <audio
        ref={audioRef}
        src={url || undefined}
        preload="metadata"
        className="hidden"
        onPlay={() => {
          errorShownRef.current = false;
          setPlaying(true);
        }}
        onPause={() => setPlaying(false)}
        onEnded={() => {
          setPlaying(false);
          setProgress(0);
        }}
        onError={reportPlaybackError}
        onTimeUpdate={(event) => {
          const el = event.currentTarget;
          const total =
            Number.isFinite(el.duration) && el.duration > 0
              ? el.duration
              : duration;
          setProgress(total > 0 ? Math.min(1, el.currentTime / total) : 0);
        }}
      />
    </div>
  );
}
