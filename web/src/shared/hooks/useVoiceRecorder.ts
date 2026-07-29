import { useCallback, useEffect, useRef, useState } from 'react';
import {
  createVoiceLevelTracker,
  summarizeVoiceWaveform,
  voiceDbFromAmplitude,
  voiceLevelsFromDecibels,
  VOICE_METERING_INTERVAL_MS,
  VOICE_MIN_LEVEL,
  VOICE_RECORDING_BAR_COUNT,
} from '@ola/shared/lib';

const MAX_DURATION_MS = 60_000;
const MIN_DURATION_SEC = 1;

export type VoiceRecorderError =
  | 'unsupported'
  | 'insecure'
  | 'denied'
  | 'not-found'
  | 'unavailable'
  | 'failed';

export interface VoiceRecording {
  blob: Blob;
  duration: number;
  waveform: number[];
}

export interface VoiceRecorder {
  isRecording: boolean;
  elapsedMs: number;
  waveform: number[];
  start: () => Promise<boolean>;
  stop: () => Promise<VoiceRecording | null>;
  cancel: () => void;
}

type AudioContextConstructor = typeof AudioContext;

function pickMimeType(): string {
  const candidates = ['audio/webm;codecs=opus', 'audio/webm', 'audio/mp4'];
  for (const type of candidates) {
    if (
      typeof MediaRecorder !== 'undefined' &&
      MediaRecorder.isTypeSupported(type)
    )
      return type;
  }
  return '';
}

function audioContextConstructor(): AudioContextConstructor | undefined {
  if (typeof window === 'undefined') return undefined;
  return (
    window.AudioContext ??
    (window as typeof window & { webkitAudioContext?: AudioContextConstructor })
      .webkitAudioContext
  );
}

function classifyMicrophoneError(error: unknown): VoiceRecorderError {
  const name =
    error instanceof DOMException
      ? error.name
      : typeof error === 'object' &&
          error != null &&
          'name' in error &&
          typeof error.name === 'string'
        ? error.name
        : '';

  if (
    name === 'NotAllowedError' ||
    name === 'PermissionDeniedError' ||
    name === 'SecurityError'
  )
    return 'denied';
  if (name === 'NotFoundError' || name === 'DevicesNotFoundError')
    return 'not-found';
  if (name === 'NotReadableError' || name === 'TrackStartError')
    return 'unavailable';
  return 'failed';
}

export function useVoiceRecorder(
  onError?: (error: VoiceRecorderError) => void,
  onAutoStop?: (recording: VoiceRecording) => void
): VoiceRecorder {
  const [isRecording, setIsRecording] = useState(false);
  const [elapsedMs, setElapsedMs] = useState(0);
  const [waveform, setWaveform] = useState<number[]>(() =>
    Array.from({ length: VOICE_RECORDING_BAR_COUNT }, () => VOICE_MIN_LEVEL)
  );
  const waveformRef = useRef<number[]>(
    Array.from({ length: VOICE_RECORDING_BAR_COUNT }, () => VOICE_MIN_LEVEL)
  );
  const decibelSamplesRef = useRef<number[]>([]);
  const levelTrackerRef = useRef(createVoiceLevelTracker());

  const recorderRef = useRef<MediaRecorder | null>(null);
  const streamRef = useRef<MediaStream | null>(null);
  const chunksRef = useRef<Blob[]>([]);
  const startAtRef = useRef(0);
  const stoppedAtRef = useRef(0);
  const timerRef = useRef<number | null>(null);
  const maxTimerRef = useRef<number | null>(null);
  const mountedRef = useRef(true);
  const startingRef = useRef(false);
  const startRequestRef = useRef(0);
  const cancelledRef = useRef(false);
  const pendingResolveRef = useRef<
    ((value: VoiceRecording | null) => void) | null
  >(null);
  const audioContextRef = useRef<AudioContext | null>(null);
  const audioSourceRef = useRef<MediaStreamAudioSourceNode | null>(null);
  const analyserRef = useRef<AnalyserNode | null>(null);
  const levelFrameRef = useRef<number | null>(null);
  const lastLevelUpdateRef = useRef(0);

  const stopLevelMonitor = useCallback(() => {
    if (levelFrameRef.current != null) {
      cancelAnimationFrame(levelFrameRef.current);
      levelFrameRef.current = null;
    }
    audioSourceRef.current?.disconnect();
    analyserRef.current?.disconnect();
    audioSourceRef.current = null;
    analyserRef.current = null;
    const context = audioContextRef.current;
    audioContextRef.current = null;
    if (context != null && context.state !== 'closed')
      void context.close().catch(() => undefined);
  }, []);

  const startLevelMonitor = useCallback(
    (stream: MediaStream) => {
      const Context = audioContextConstructor();
      if (Context == null) return;
      try {
        const context = new Context();
        if (context.state === 'suspended')
          void context.resume().catch(() => undefined);
        const analyser = context.createAnalyser();
        const source = context.createMediaStreamSource(stream);
        analyser.fftSize = 4096;
        const samples = new Float32Array(analyser.fftSize);
        source.connect(analyser);
        audioContextRef.current = context;
        audioSourceRef.current = source;
        analyserRef.current = analyser;
        lastLevelUpdateRef.current = 0;

        const measure = (now: number) => {
          if (now - lastLevelUpdateRef.current >= VOICE_METERING_INTERVAL_MS) {
            analyser.getFloatTimeDomainData(samples);
            let sum = 0;
            for (const sample of samples) sum += sample * sample;
            const rms = Math.sqrt(sum / samples.length);
            const decibels = voiceDbFromAmplitude(rms);
            decibelSamplesRef.current.push(decibels);
            const nextLevel = levelTrackerRef.current(decibels);
            const nextWaveform = [...waveformRef.current.slice(1), nextLevel];
            waveformRef.current = nextWaveform;
            setWaveform(nextWaveform);
            lastLevelUpdateRef.current = now;
          }
          levelFrameRef.current = requestAnimationFrame(measure);
        };
        levelFrameRef.current = requestAnimationFrame(measure);
      } catch {
        stopLevelMonitor();
      }
    },
    [stopLevelMonitor]
  );

  const cleanup = useCallback(() => {
    if (timerRef.current != null) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
    if (maxTimerRef.current != null) {
      clearTimeout(maxTimerRef.current);
      maxTimerRef.current = null;
    }
    streamRef.current?.getTracks().forEach((track) => track.stop());
    streamRef.current = null;
    recorderRef.current = null;
    stopLevelMonitor();
    if (mountedRef.current) setIsRecording(false);
  }, [stopLevelMonitor]);

  const start = useCallback(async () => {
    if (
      startingRef.current ||
      isRecording ||
      (recorderRef.current != null && recorderRef.current.state !== 'inactive')
    )
      return false;
    if (typeof window !== 'undefined' && !window.isSecureContext) {
      onError?.('insecure');
      return false;
    }
    if (
      typeof navigator === 'undefined' ||
      navigator.mediaDevices?.getUserMedia == null ||
      typeof MediaRecorder === 'undefined'
    ) {
      onError?.('unsupported');
      return false;
    }

    startingRef.current = true;
    const requestId = ++startRequestRef.current;
    let stream: MediaStream;
    try {
      stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    } catch (error) {
      startingRef.current = false;
      if (mountedRef.current && requestId === startRequestRef.current) {
        onError?.(classifyMicrophoneError(error));
      }
      return false;
    }

    if (!mountedRef.current || requestId !== startRequestRef.current) {
      stream.getTracks().forEach((track) => track.stop());
      startingRef.current = false;
      return false;
    }
    if (stream.getAudioTracks().length === 0) {
      stream.getTracks().forEach((track) => track.stop());
      startingRef.current = false;
      onError?.('not-found');
      return false;
    }

    try {
      const mimeType = pickMimeType();
      const recorder = mimeType
        ? new MediaRecorder(stream, { mimeType })
        : new MediaRecorder(stream);
      chunksRef.current = [];
      cancelledRef.current = false;
      pendingResolveRef.current = null;

      recorder.ondataavailable = (event) => {
        if (event.data.size > 0) chunksRef.current.push(event.data);
      };
      recorder.onstop = () => {
        const cleanType =
          (recorder.mimeType || 'audio/webm').split(';')[0] ?? 'audio/webm';
        const blob = new Blob(chunksRef.current, { type: cleanType });
        const fallbackStoppedAt = Math.min(
          Date.now(),
          startAtRef.current + MAX_DURATION_MS
        );
        const effectiveStoppedAt =
          stoppedAtRef.current > startAtRef.current
            ? Math.min(
                stoppedAtRef.current,
                startAtRef.current + MAX_DURATION_MS
              )
            : fallbackStoppedAt;
        const durationMs = Math.max(0, effectiveStoppedAt - startAtRef.current);
        const duration = Math.round(durationMs / 1000);
        const valid =
          !cancelledRef.current &&
          blob.size > 0 &&
          durationMs >= MIN_DURATION_SEC * 1000;
        const result = valid
          ? {
              blob,
              duration,
              waveform: summarizeVoiceWaveform(
                voiceLevelsFromDecibels(decibelSamplesRef.current)
              ),
            }
          : null;
        cleanup();
        if (pendingResolveRef.current != null) {
          pendingResolveRef.current(result);
          pendingResolveRef.current = null;
        } else if (result != null) {
          onAutoStop?.(result);
        }
      };

      streamRef.current = stream;
      recorderRef.current = recorder;
      startAtRef.current = Date.now();
      stoppedAtRef.current = 0;
      recorder.start();
      startLevelMonitor(stream);
      const emptyWaveform = Array.from(
        { length: VOICE_RECORDING_BAR_COUNT },
        () => VOICE_MIN_LEVEL
      );
      waveformRef.current = emptyWaveform;
      decibelSamplesRef.current = [];
      levelTrackerRef.current = createVoiceLevelTracker(
        VOICE_METERING_INTERVAL_MS
      );
      setWaveform(emptyWaveform);
      setIsRecording(true);
      setElapsedMs(0);
      timerRef.current = window.setInterval(() => {
        const elapsed = Math.min(
          MAX_DURATION_MS,
          Date.now() - startAtRef.current
        );
        if (mountedRef.current) setElapsedMs(elapsed);
      }, 200);
      maxTimerRef.current = window.setTimeout(() => {
        maxTimerRef.current = null;
        const activeRecorder = recorderRef.current;
        if (activeRecorder == null || activeRecorder.state === 'inactive')
          return;
        stoppedAtRef.current = startAtRef.current + MAX_DURATION_MS;
        if (mountedRef.current) setElapsedMs(MAX_DURATION_MS);
        if (timerRef.current != null) {
          clearInterval(timerRef.current);
          timerRef.current = null;
        }
        try {
          activeRecorder.stop();
        } catch {
          cleanup();
          if (mountedRef.current) onError?.('failed');
        }
      }, MAX_DURATION_MS);
      startingRef.current = false;
      return true;
    } catch {
      stream.getTracks().forEach((track) => track.stop());
      startingRef.current = false;
      if (mountedRef.current && requestId === startRequestRef.current) {
        onError?.('failed');
      }
      return false;
    }
  }, [isRecording, onError, onAutoStop, cleanup, startLevelMonitor]);

  const stop = useCallback(() => {
    return new Promise<VoiceRecording | null>((resolve) => {
      const recorder = recorderRef.current;
      if (recorder == null || recorder.state === 'inactive') {
        resolve(null);
        return;
      }
      pendingResolveRef.current = resolve;
      stoppedAtRef.current = Math.min(
        Date.now(),
        startAtRef.current + MAX_DURATION_MS
      );
      try {
        recorder.stop();
      } catch {
        pendingResolveRef.current = null;
        cleanup();
        resolve(null);
      }
    });
  }, [cleanup]);

  const cancel = useCallback(() => {
    startRequestRef.current += 1;
    startingRef.current = false;
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

  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
      startRequestRef.current += 1;
      startingRef.current = false;
      const recorder = recorderRef.current;
      if (recorder != null && recorder.state !== 'inactive') {
        cancelledRef.current = true;
        try {
          recorder.stop();
        } catch {
          recorderRef.current = null;
        }
      }
      if (timerRef.current != null) clearInterval(timerRef.current);
      if (maxTimerRef.current != null) clearTimeout(maxTimerRef.current);
      streamRef.current?.getTracks().forEach((track) => track.stop());
      stopLevelMonitor();
    };
  }, [stopLevelMonitor]);

  return {
    isRecording,
    elapsedMs,
    waveform,
    start,
    stop,
    cancel,
  };
}
