import {
  forwardRef,
  useCallback,
  useEffect,
  useImperativeHandle,
  useRef,
  useState,
} from 'react';
import { useTranslation } from 'react-i18next';
import { formatDurationMs, toast } from '@lib';
import {
  useVoiceRecorder,
  type VoiceRecorderError,
  type VoiceRecording,
} from '@hooks';
import { VoiceWaveformBars } from './VoiceWaveformBars';

interface VoiceRecorderControlProps {
  onRecorded: (recording: VoiceRecording) => void;
  onRecordingChange: (recording: boolean) => void;
}

export interface VoiceRecorderControlHandle {
  start: () => void;
}

export const VoiceRecorderControl = forwardRef<
  VoiceRecorderControlHandle,
  VoiceRecorderControlProps
>(function VoiceRecorderControl({ onRecorded, onRecordingChange }, ref) {
  const { t } = useTranslation();
  const [stopping, setStopping] = useState(false);
  const mountedRef = useRef(true);

  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
    };
  }, []);

  const complete = useCallback(
    (recording: VoiceRecording) => {
      setStopping(false);
      onRecordingChange(false);
      onRecorded(recording);
    },
    [onRecorded, onRecordingChange]
  );

  const handleError = useCallback(
    (error: VoiceRecorderError) => {
      setStopping(false);
      onRecordingChange(false);
      const key = (
        {
          unsupported: 'chat.voiceMicUnsupported',
          insecure: 'chat.voiceMicInsecure',
          denied: 'chat.voiceMicDenied',
          'not-found': 'chat.voiceMicNotFound',
          unavailable: 'chat.voiceMicUnavailable',
          failed: 'chat.voiceRecordError',
        } as const
      )[error];
      toast.error(t(key));
    },
    [onRecordingChange, t]
  );

  const {
    isRecording,
    elapsedMs,
    waveform,
    start: startRecording,
    stop: stopRecording,
    cancel: cancelRecording,
  } = useVoiceRecorder(handleError, complete);

  useEffect(() => {
    if (!isRecording) return;
    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key !== 'Escape') return;
      if (stopping) return;
      event.preventDefault();
      cancelRecording();
      setStopping(false);
      onRecordingChange(false);
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [isRecording, stopping, cancelRecording, onRecordingChange]);

  const start = useCallback(async () => {
    if (isRecording) return;
    const started = await startRecording();
    if (!mountedRef.current) return;
    if (started) onRecordingChange(true);
  }, [isRecording, startRecording, onRecordingChange]);

  useImperativeHandle(ref, () => ({ start: () => void start() }), [start]);

  async function stop() {
    if (stopping || !isRecording) return;
    setStopping(true);
    const result = await stopRecording();
    if (!mountedRef.current) return;
    setStopping(false);
    onRecordingChange(false);
    if (result == null) {
      toast.info(t('chat.voiceTooShort'));
      return;
    }
    onRecorded(result);
  }

  function cancel() {
    cancelRecording();
    setStopping(false);
    onRecordingChange(false);
  }

  if (!isRecording) return null;

  return (
    <div className="absolute inset-0 z-10 flex min-h-12 items-center gap-2 bg-white px-3 py-1.5">
      <button
        type="button"
        disabled={stopping}
        onClick={() => void stop()}
        aria-label={t('chat.voiceTapStop')}
        className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-ola-primary text-ola-on-primary shadow-sm transition active:scale-95 disabled:opacity-60"
      >
        {stopping ? (
          <span className="h-3.5 w-3.5 animate-spin rounded-full border-2 border-ola-on-primary/40 border-t-ola-on-primary" />
        ) : (
          <span className="h-3 w-3 rounded-[3px] bg-ola-on-primary" />
        )}
      </button>

      <span
        aria-label={t('chat.voiceRecording')}
        className="flex min-w-0 flex-1 items-center px-2"
      >
        <VoiceWaveformBars
          waveform={waveform}
          duration={elapsedMs / 1000}
          progress={1}
          tone="recording"
          fluid
        />
      </span>

      <span className="flex shrink-0 items-center gap-1">
        <span className="h-2.5 w-2.5 shrink-0 animate-pulse rounded-full bg-[#f02849]" />
        <span className="w-10 text-right text-sm font-medium tabular-nums text-black/70">
          {formatDurationMs(elapsedMs)}
        </span>
      </span>

      <button
        type="button"
        disabled={stopping}
        onClick={cancel}
        aria-label={t('chat.voiceDiscard')}
        className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-ola-error transition hover:bg-ola-error/10 active:scale-95 disabled:opacity-50"
      >
        <svg
          viewBox="0 0 24 24"
          aria-hidden="true"
          className="h-5 w-5 fill-current"
        >
          <path d="M7 21a2 2 0 0 1-2-2V6h14v13a2 2 0 0 1-2 2H7Zm1-3h2V9H8v9Zm6 0h2V9h-2v9ZM4 5V3h5l1-1h4l1 1h5v2H4Z" />
        </svg>
      </button>
    </div>
  );
});
