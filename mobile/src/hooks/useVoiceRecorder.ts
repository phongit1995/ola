import { useCallback, useEffect, useRef, useState } from 'react';
import { PermissionsAndroid, Platform } from 'react-native';
import Sound, {
  AVEncoderAudioQualityIOSType,
  AudioEncoderAndroidType,
  OutputFormatAndroidType,
  type AudioSet,
} from 'react-native-nitro-sound';
import type { NativeUploadFile } from '@ola/shared/lib';
import { recordAppError } from '@lib/telemetry';

const MAX_DURATION_MS = 300_000;
const MIN_DURATION_SEC = 1;

export interface VoiceRecording {
  file: NativeUploadFile;
  duration: number;
}

export type VoiceRecorderStartResult =
  | 'started'
  | 'busy'
  | 'permission-denied'
  | 'permission-blocked'
  | 'error';

export interface VoiceRecorder {
  isRecording: boolean;
  isStarting: boolean;
  elapsedMs: number;
  start: () => Promise<VoiceRecorderStartResult>;
  stop: () => Promise<VoiceRecording | null>;
  cancel: () => Promise<void>;
}

const AUDIO_SET: AudioSet = {
  AVFormatIDKeyIOS: 'aac',
  AVNumberOfChannelsKeyIOS: 1,
  AVSampleRateKeyIOS: 44100,
  AVEncoderAudioQualityKeyIOS: AVEncoderAudioQualityIOSType.medium,
  AudioEncoderAndroid: AudioEncoderAndroidType.AAC,
  OutputFormatAndroid: OutputFormatAndroidType.MPEG_4,
  AudioChannels: 1,
  AudioSamplingRate: 44100,
  AudioEncodingBitRate: 48000,
};

function normalizeUri(path: string): string {
  return path.startsWith('file://') ? path : `file://${path}`;
}

type MicPermissionResult = 'granted' | 'denied' | 'blocked';

async function ensureMicPermission(): Promise<MicPermissionResult> {
  if (Platform.OS !== 'android') return 'granted';
  const status = await PermissionsAndroid.request(PermissionsAndroid.PERMISSIONS.RECORD_AUDIO);
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

export function useVoiceRecorder(onMaxDuration?: () => void): VoiceRecorder {
  const [isRecording, setIsRecording] = useState(false);
  const [isStarting, setIsStarting] = useState(false);
  const [elapsedMs, setElapsedMs] = useState(0);
  const recordingRef = useRef(false);
  const startingRef = useRef(false);
  const mountedRef = useRef(true);
  const elapsedRef = useRef(0);
  const maxDurationHandledRef = useRef(false);

  const detach = useCallback(() => {
    Sound.removeRecordBackListener();
  }, []);

  const start = useCallback(async () => {
    if (recordingRef.current || startingRef.current) return 'busy';
    startingRef.current = true;
    setIsStarting(true);
    try {
      const permission = await ensureMicPermission();
      if (permission === 'denied') return 'permission-denied';
      if (permission === 'blocked') return 'permission-blocked';

      Sound.setSubscriptionDuration(0.1);
      maxDurationHandledRef.current = false;
      Sound.addRecordBackListener((meta) => {
        elapsedRef.current = meta.currentPosition;
        if (mountedRef.current) setElapsedMs(meta.currentPosition);
        if (meta.currentPosition >= MAX_DURATION_MS && !maxDurationHandledRef.current) {
          maxDurationHandledRef.current = true;
          onMaxDuration?.();
        }
      });
      await Sound.startRecorder(undefined, AUDIO_SET, false);

      if (!mountedRef.current) {
        await Sound.stopRecorder().catch(() => undefined);
        detach();
        return 'busy';
      }

      recordingRef.current = true;
      elapsedRef.current = 0;
      setElapsedMs(0);
      setIsRecording(true);
      return 'started';
    } catch (error) {
      detach();
      if (Platform.OS === 'ios' && isMicPermissionError(error)) {
        return 'permission-blocked';
      }
      recordAppError(error, `voice_recorder_start_failed:${Platform.OS}`);
      return 'error';
    } finally {
      startingRef.current = false;
      if (mountedRef.current) setIsStarting(false);
    }
  }, [detach, onMaxDuration]);

  const stop = useCallback(async () => {
    if (!recordingRef.current) return null;
    recordingRef.current = false;
    setIsRecording(false);
    let path = '';
    try {
      path = await Sound.stopRecorder();
    } catch (error) {
      detach();
      recordAppError(error, `voice_recorder_stop_failed:${Platform.OS}`);
      return null;
    }
    detach();
    const duration = Math.round(elapsedRef.current / 1000);
    if (path === '' || duration < MIN_DURATION_SEC) return null;
    return {
      file: { uri: normalizeUri(path), name: 'voice.m4a', type: 'audio/mp4' },
      duration,
    };
  }, [detach]);

  const cancel = useCallback(async () => {
    if (!recordingRef.current) return;
    recordingRef.current = false;
    setIsRecording(false);
    try {
      await Sound.stopRecorder();
    } catch {
      // ignore
    }
    detach();
  }, [detach]);

  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
      if (recordingRef.current) {
        Sound.stopRecorder().catch(() => undefined);
      }
      Sound.removeRecordBackListener();
    };
  }, []);

  return { isRecording, isStarting, elapsedMs, start, stop, cancel };
}
