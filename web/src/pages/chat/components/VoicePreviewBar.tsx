import { useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import playIcon from '@/assets/icons/chat/ic_play_media_gray.png';
import pauseIcon from '@/assets/icons/chat/ic_pause_media_gray.png';
import sendIcon from '@/assets/icons/chat/ic_action_send_white.png';
import deleteIcon from '@/assets/icons/chat/ic_menu_delete.png';
import { formatDuration } from '@lib';

interface VoicePreviewBarProps {
  blob: Blob;
  duration: number;
  onSend: () => void;
  onDiscard: () => void;
}

export function VoicePreviewBar({
  blob,
  duration,
  onSend,
  onDiscard,
}: VoicePreviewBarProps) {
  const { t } = useTranslation();
  const url = useMemo(() => URL.createObjectURL(blob), [blob]);
  const audioRef = useRef<HTMLAudioElement>(null);
  const [playing, setPlaying] = useState(false);
  const [progress, setProgress] = useState(0);

  useEffect(() => () => URL.revokeObjectURL(url), [url]);

  function toggle() {
    const el = audioRef.current;
    if (el == null) return;
    if (el.paused) void el.play().catch(() => undefined);
    else el.pause();
  }

  return (
    <div className="flex shrink-0 items-center gap-3 border-t border-black/12 bg-ola-primary-light px-3 py-2">
      <button
        type="button"
        onClick={toggle}
        aria-label={t('chat.attachRecord')}
        className="flex h-9 w-9 shrink-0 items-center justify-center"
      >
        <img
          src={playing ? pauseIcon : playIcon}
          alt=""
          className="h-6 w-6 object-contain"
        />
      </button>
      <span className="relative h-1 flex-1 overflow-hidden rounded-full bg-black/15">
        <span
          className="absolute inset-y-0 left-0 rounded-full bg-ola-primary"
          style={{ width: `${Math.round(progress * 100)}%` }}
        />
      </span>
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
        src={url}
        preload="metadata"
        className="hidden"
        onPlay={() => setPlaying(true)}
        onPause={() => setPlaying(false)}
        onEnded={() => {
          setPlaying(false);
          setProgress(0);
        }}
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
