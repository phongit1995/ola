import { useCallback, useEffect, useRef, useState } from 'react';
import Sound, {
  AVEncoderAudioQualityIOSType,
  AudioEncoderAndroidType,
  OutputFormatAndroidType,
  type AudioSet,
} from 'react-native-nitro-sound';
import type { NativeUploadFile } from '@ola/shared/lib';

const MAX_DURATION_MS = 300_000;
const MIN_DURATION_SEC = 1;

export interface VoiceRecording {
  file: NativeUploadFile;
  duration: number;
}

export interface VoiceRecorder {
  isRecording: boolean;
  elapsedMs: number;
  start: () => Promise<boolean>;
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

export function useVoiceRecorder(onMaxDuration?: () => void): VoiceRecorder {
  const [isRecording, setIsRecording] = useState(false);
  const [elapsedMs, setElapsedMs] = useState(0);
  const recordingRef = useRef(false);
  const elapsedRef = useRef(0);

  const detach = useCallback(() => {
    Sound.removeRecordBackListener();
  }, []);

  const start = useCallback(async () => {
    if (recordingRef.current) return false;
    try {
      Sound.setSubscriptionDuration(0.1);
      Sound.addRecordBackListener((meta) => {
        elapsedRef.current = meta.currentPosition;
        setElapsedMs(meta.currentPosition);
        if (meta.currentPosition >= MAX_DURATION_MS) onMaxDuration?.();
      });
      await Sound.startRecorder(undefined, AUDIO_SET, false);
      recordingRef.current = true;
      elapsedRef.current = 0;
      setElapsedMs(0);
      setIsRecording(true);
      return true;
    } catch {
      detach();
      return false;
    }
  }, [detach, onMaxDuration]);

  const stop = useCallback(async () => {
    if (!recordingRef.current) return null;
    recordingRef.current = false;
    setIsRecording(false);
    let path = '';
    try {
      path = await Sound.stopRecorder();
    } catch {
      detach();
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
    return () => {
      if (recordingRef.current) {
        Sound.stopRecorder().catch(() => undefined);
      }
      Sound.removeRecordBackListener();
    };
  }, []);

  return { isRecording, elapsedMs, start, stop, cancel };
}
