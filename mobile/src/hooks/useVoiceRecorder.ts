import { useCallback, useEffect, useRef, useState } from 'react';
import { AppState, PermissionsAndroid, Platform } from 'react-native';
import Sound, {
  AudioEncoderAndroidType,
  OutputFormatAndroidType,
  type AudioSet,
} from 'react-native-nitro-sound';
import {
  createVoiceLevelTracker,
  summarizeVoiceWaveform,
  voiceLevelsFromDecibels,
  VOICE_METERING_INTERVAL_MS,
  VOICE_MIN_LEVEL,
  VOICE_RECORDING_BAR_COUNT,
  VOICE_SILENCE_DB,
} from '@ola/shared/lib';
import type { NativeUploadFile } from '@ola/shared/types';
import { recordAppError } from '@lib/telemetry';
import { deleteTemporaryVoiceFile } from '@lib/temporaryVoiceFile';
import { releaseVoicePlayback } from '@lib/voicePlaybackSession';

const MAX_DURATION_MS = 60_000;
const MIN_DURATION_MS = 1_000;

export interface VoiceRecording {
  file: NativeUploadFile;
  duration: number;
  waveform: number[];
}

export type VoiceRecorderStartResult =
  | 'started'
  | 'busy'
  | 'permission-denied'
  | 'permission-blocked'
  | 'unavailable'
  | 'error';

export interface VoiceRecorder {
  isRecording: boolean;
  isStarting: boolean;
  isStopping: boolean;
  elapsedMs: number;
  waveform: number[];
  start: () => Promise<VoiceRecorderStartResult>;
  stop: () => Promise<VoiceRecording | null>;
  cancel: () => Promise<void>;
}

const ANDROID_AUDIO_SET: AudioSet = {
  AudioEncoderAndroid: AudioEncoderAndroidType.AAC,
  OutputFormatAndroid: OutputFormatAndroidType.MPEG_4,
  AudioChannels: 1,
  AudioSamplingRate: 44100,
  AudioEncodingBitRate: 48000,
};

const EMPTY_WAVEFORM = Array.from(
  { length: VOICE_RECORDING_BAR_COUNT },
  () => VOICE_MIN_LEVEL,
);

function normalizeUri(path: string): string {
  return path.startsWith('file://') ? path : `file://${path}`;
}

type MicPermissionResult = 'granted' | 'denied' | 'blocked';

async function ensureMicPermission(): Promise<MicPermissionResult> {
  if (Platform.OS !== 'android') return 'granted';
  const status = await PermissionsAndroid.request(
    PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
  );
  if (status === PermissionsAndroid.RESULTS.GRANTED) return 'granted';
  if (status === PermissionsAndroid.RESULTS.NEVER_ASK_AGAIN) return 'blocked';
  return 'denied';
}

function errorMessage(error: unknown): string {
  if (error instanceof Error) return error.message;
  if (typeof error === 'string') return error;
  if (error != null && typeof error === 'object' && 'message' in error) {
    return String(error.message);
  }
  return String(error);
}

function isMicPermissionError(error: unknown): boolean {
  const message = errorMessage(error);
  return (
    /recording permission denied/i.test(message) ||
    /microphone (?:access|permission).*(?:denied|settings)/i.test(message) ||
    /permission.*microphone/i.test(message)
  );
}

function isMicUnavailableError(error: unknown): boolean {
  return /audio session|recorder.*(?:busy|unavailable|failed)|microphone.*in use|prepare failed/i.test(
    errorMessage(error),
  );
}

export function useVoiceRecorder(
  onAutoStop?: (recording: VoiceRecording | null) => void,
): VoiceRecorder {
  const [isRecording, setIsRecording] = useState(false);
  const [isStarting, setIsStarting] = useState(false);
  const [isStopping, setIsStopping] = useState(false);
  const [elapsedMs, setElapsedMs] = useState(0);
  const [waveform, setWaveform] = useState<number[]>(EMPTY_WAVEFORM);
  const recordingRef = useRef(false);
  const startingRef = useRef(false);
  const mountedRef = useRef(true);
  const elapsedRef = useRef(0);
  const waveformRef = useRef<number[]>(EMPTY_WAVEFORM);
  const decibelSamplesRef = useRef<number[]>([]);
  const levelTrackerRef = useRef(createVoiceLevelTracker());
  const maxDurationHandledRef = useRef(false);
  const maxTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const startRequestRef = useRef(0);
  const stopPromiseRef = useRef<Promise<VoiceRecording | null> | null>(null);
  const onAutoStopRef = useRef(onAutoStop);
  onAutoStopRef.current = onAutoStop;

  const clearMaxTimer = useCallback(() => {
    if (maxTimerRef.current != null) {
      clearTimeout(maxTimerRef.current);
      maxTimerRef.current = null;
    }
  }, []);

  const detach = useCallback(() => {
    clearMaxTimer();
    Sound.removeRecordBackListener();
  }, [clearMaxTimer]);

  const stop = useCallback((): Promise<VoiceRecording | null> => {
    if (stopPromiseRef.current != null) return stopPromiseRef.current;
    if (!recordingRef.current) return Promise.resolve(null);

    recordingRef.current = false;
    maxDurationHandledRef.current = true;
    clearMaxTimer();
    if (mountedRef.current) setIsStopping(true);
    const durationMs = Math.min(MAX_DURATION_MS, elapsedRef.current);

    const pending = (async () => {
      let path = '';
      try {
        path = await Sound.stopRecorder();
      } catch (error) {
        recordAppError(error, `voice_recorder_stop_failed:${Platform.OS}`);
      } finally {
        detach();
        if (mountedRef.current) {
          setIsRecording(false);
          setIsStopping(false);
        }
      }

      if (path === '') return null;
      if (durationMs < MIN_DURATION_MS) {
        await deleteTemporaryVoiceFile(path);
        return null;
      }
      return {
        file: {
          uri: normalizeUri(path),
          name: 'voice.m4a',
          type: 'audio/mp4',
        },
        duration: Math.round(durationMs / 1000),
        waveform: summarizeVoiceWaveform(
          voiceLevelsFromDecibels(decibelSamplesRef.current),
        ),
      };
    })();

    stopPromiseRef.current = pending;
    void pending.finally(() => {
      if (stopPromiseRef.current === pending) stopPromiseRef.current = null;
    });
    return pending;
  }, [clearMaxTimer, detach]);

  const finishAutomatically = useCallback(
    (atMaximumDuration: boolean) => {
      if (
        !recordingRef.current ||
        maxDurationHandledRef.current ||
        stopPromiseRef.current != null
      ) {
        return;
      }
      maxDurationHandledRef.current = true;
      if (atMaximumDuration) {
        elapsedRef.current = MAX_DURATION_MS;
        if (mountedRef.current) setElapsedMs(MAX_DURATION_MS);
      }
      void stop().then(recording => {
        if (mountedRef.current) onAutoStopRef.current?.(recording);
      });
    },
    [stop],
  );

  const start = useCallback(async (): Promise<VoiceRecorderStartResult> => {
    if (
      recordingRef.current ||
      startingRef.current ||
      stopPromiseRef.current != null
    ) {
      return 'busy';
    }

    startingRef.current = true;
    if (mountedRef.current) setIsStarting(true);
    const requestId = ++startRequestRef.current;

    try {
      const permission = await ensureMicPermission();
      if (permission === 'denied') return 'permission-denied';
      if (permission === 'blocked') return 'permission-blocked';

      elapsedRef.current = 0;
      waveformRef.current = EMPTY_WAVEFORM;
      decibelSamplesRef.current = [];
      levelTrackerRef.current = createVoiceLevelTracker(
        VOICE_METERING_INTERVAL_MS,
      );
      maxDurationHandledRef.current = false;
      if (mountedRef.current) {
        setElapsedMs(0);
        setWaveform(EMPTY_WAVEFORM);
        setIsStopping(false);
      }

      Sound.setSubscriptionDuration(VOICE_METERING_INTERVAL_MS / 1000);
      Sound.addRecordBackListener(meta => {
        const nextElapsed = Math.min(MAX_DURATION_MS, meta.currentPosition);
        elapsedRef.current = nextElapsed;
        const decibels = meta.currentMetering ?? VOICE_SILENCE_DB;
        decibelSamplesRef.current.push(decibels);
        const nextLevel = levelTrackerRef.current(decibels);
        const nextWaveform = [...waveformRef.current.slice(1), nextLevel];
        waveformRef.current = nextWaveform;
        if (mountedRef.current) {
          setElapsedMs(nextElapsed);
          setWaveform(nextWaveform);
        }
        if (meta.currentPosition >= MAX_DURATION_MS) {
          finishAutomatically(true);
        }
      });

      // Ghi âm không được để voice playback tiếp tục sống. Release trước khi mở
      // mic cũng là lớp bảo vệ phía app nếu audio route của iOS thay đổi.
      releaseVoicePlayback();

      // Custom numeric AudioSet values can fail to bridge correctly in iOS
      // release builds. Let AVAudioRecorder use Nitro Sound's iOS defaults.
      const audioSet =
        Platform.OS === 'ios' ? undefined : ANDROID_AUDIO_SET;
      await Sound.startRecorder(undefined, audioSet, true);

      if (
        !mountedRef.current ||
        requestId !== startRequestRef.current ||
        AppState.currentState === 'background'
      ) {
        const path = await Sound.stopRecorder().catch(() => '');
        await deleteTemporaryVoiceFile(path);
        detach();
        return 'busy';
      }

      recordingRef.current = true;
      setIsRecording(true);
      maxTimerRef.current = setTimeout(
        () => finishAutomatically(true),
        MAX_DURATION_MS,
      );
      return 'started';
    } catch (error) {
      detach();
      if (isMicPermissionError(error)) {
        return Platform.OS === 'ios'
          ? 'permission-blocked'
          : 'permission-denied';
      }
      if (isMicUnavailableError(error)) return 'unavailable';
      recordAppError(error, `voice_recorder_start_failed:${Platform.OS}`);
      return 'error';
    } finally {
      startingRef.current = false;
      if (mountedRef.current) setIsStarting(false);
    }
  }, [detach, finishAutomatically]);

  const cancel = useCallback(async () => {
    startRequestRef.current += 1;
    maxDurationHandledRef.current = true;
    clearMaxTimer();
    if (!recordingRef.current) return;
    recordingRef.current = false;
    try {
      const path = await Sound.stopRecorder();
      await deleteTemporaryVoiceFile(path);
    } catch (error) {
      recordAppError(error, `voice_recorder_cancel_failed:${Platform.OS}`);
    } finally {
      detach();
      if (mountedRef.current) setIsRecording(false);
    }
  }, [clearMaxTimer, detach]);

  useEffect(() => {
    const subscription = AppState.addEventListener('change', state => {
      if (state === 'background') finishAutomatically(false);
    });
    return () => subscription.remove();
  }, [finishAutomatically]);

  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
      startRequestRef.current += 1;
      startingRef.current = false;
      clearMaxTimer();
      if (recordingRef.current) {
        recordingRef.current = false;
        void Sound.stopRecorder()
          .then(deleteTemporaryVoiceFile)
          .catch(() => undefined);
      }
      Sound.removeRecordBackListener();
    };
  }, [clearMaxTimer]);

  return {
    isRecording,
    isStarting,
    isStopping,
    elapsedMs,
    waveform,
    start,
    stop,
    cancel,
  };
}
