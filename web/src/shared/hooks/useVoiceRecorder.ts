import { useCallback, useRef, useState } from 'react';

const MAX_DURATION_MS = 300_000;
const MIN_DURATION_SEC = 1;

export type VoiceRecorderError = 'unsupported' | 'denied' | 'failed';

export interface VoiceRecording {
  blob: Blob;
  duration: number;
}

export interface VoiceRecorder {
  isRecording: boolean;
  elapsedMs: number;
  start: () => Promise<boolean>;
  stop: () => Promise<VoiceRecording | null>;
  cancel: () => void;
}

function pickMimeType(): string {
  const candidates = ['audio/webm;codecs=opus', 'audio/webm', 'audio/mp4'];
  for (const type of candidates) {
    if (typeof MediaRecorder !== 'undefined' && MediaRecorder.isTypeSupported(type)) return type;
  }
  return '';
}

export function useVoiceRecorder(onError?: (error: VoiceRecorderError) => void): VoiceRecorder {
  const [isRecording, setIsRecording] = useState(false);
  const [elapsedMs, setElapsedMs] = useState(0);

  const recorderRef = useRef<MediaRecorder | null>(null);
  const streamRef = useRef<MediaStream | null>(null);
  const chunksRef = useRef<Blob[]>([]);
  const startAtRef = useRef(0);
  const stoppedAtRef = useRef(0);
  const timerRef = useRef<number | null>(null);
  const cancelledRef = useRef(false);
  const resultRef = useRef<VoiceRecording | null>(null);
  const pendingResolveRef = useRef<((value: VoiceRecording | null) => void) | null>(null);

  const cleanup = useCallback(() => {
    if (timerRef.current != null) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
    streamRef.current?.getTracks().forEach((track) => track.stop());
    streamRef.current = null;
    recorderRef.current = null;
    setIsRecording(false);
  }, []);

  const start = useCallback(async () => {
    if (isRecording) return false;
    if (
      typeof navigator === 'undefined' ||
      navigator.mediaDevices?.getUserMedia == null ||
      typeof MediaRecorder === 'undefined'
    ) {
      onError?.('unsupported');
      return false;
    }

    let stream: MediaStream;
    try {
      stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    } catch {
      onError?.('denied');
      return false;
    }

    try {
      const mimeType = pickMimeType();
      const recorder = mimeType ? new MediaRecorder(stream, { mimeType }) : new MediaRecorder(stream);
      chunksRef.current = [];
      cancelledRef.current = false;
      resultRef.current = null;
      pendingResolveRef.current = null;

      recorder.ondataavailable = (event) => {
        if (event.data.size > 0) chunksRef.current.push(event.data);
      };
      recorder.onstop = () => {
        const cleanType = (recorder.mimeType || 'audio/webm').split(';')[0] ?? 'audio/webm';
        const blob = new Blob(chunksRef.current, { type: cleanType });
        const duration = Math.round((stoppedAtRef.current - startAtRef.current) / 1000);
        const valid = !cancelledRef.current && blob.size > 0 && duration >= MIN_DURATION_SEC;
        const result = valid ? { blob, duration } : null;
        cleanup();
        if (pendingResolveRef.current != null) {
          pendingResolveRef.current(result);
          pendingResolveRef.current = null;
        } else {
          resultRef.current = result;
        }
      };

      streamRef.current = stream;
      recorderRef.current = recorder;
      startAtRef.current = Date.now();
      recorder.start();
      setIsRecording(true);
      setElapsedMs(0);
      timerRef.current = window.setInterval(() => {
        const elapsed = Date.now() - startAtRef.current;
        setElapsedMs(elapsed);
        if (elapsed >= MAX_DURATION_MS) {
          stoppedAtRef.current = Date.now();
          try {
            recorderRef.current?.stop();
          } catch {
            cleanup();
          }
        }
      }, 200);
      return true;
    } catch {
      stream.getTracks().forEach((track) => track.stop());
      onError?.('failed');
      return false;
    }
  }, [isRecording, onError, cleanup]);

  const stop = useCallback(() => {
    return new Promise<VoiceRecording | null>((resolve) => {
      const recorder = recorderRef.current;
      if (recorder == null || recorder.state === 'inactive') {
        const result = resultRef.current;
        resultRef.current = null;
        resolve(result);
        return;
      }
      pendingResolveRef.current = resolve;
      stoppedAtRef.current = Date.now();
      try {
        recorder.stop();
      } catch {
        cleanup();
        resolve(null);
      }
    });
  }, [cleanup]);

  const cancel = useCallback(() => {
    cancelledRef.current = true;
    const recorder = recorderRef.current;
    if (recorder != null && recorder.state !== 'inactive') {
      stoppedAtRef.current = Date.now();
      try {
        recorder.stop();
      } catch {
        cleanup();
      }
    } else {
      cleanup();
    }
  }, [cleanup]);

  return { isRecording, elapsedMs, start, stop, cancel };
}
