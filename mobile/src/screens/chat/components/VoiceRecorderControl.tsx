import {
  forwardRef,
  useCallback,
  useEffect,
  useImperativeHandle,
  useRef,
  useState,
} from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Alert,
  Image,
  Linking,
  Pressable,
  View,
} from 'react-native';
import { formatDurationMs } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { ChatText as Text } from '@components/ui/ChatText';
import { VoiceWaveformBars } from '@components/ui/VoiceWaveformBars';
import {
  useVoiceRecorder,
  type VoiceRecording,
  type VoiceRecorderStartResult,
} from '@hooks/useVoiceRecorder';
import { DIVIDER } from '@constants';

const deleteIcon = require('@assets/icons/chat/ic_menu_delete.png');

interface VoiceRecorderControlProps {
  bottomInset?: number;
  onRecorded: (recording: VoiceRecording) => void;
  onRecordingChange: (recording: boolean) => void;
}

export interface VoiceRecorderControlHandle {
  start: () => void;
}

export const VoiceRecorderControl = forwardRef<
  VoiceRecorderControlHandle,
  VoiceRecorderControlProps
>(function VoiceRecorderControlInner(
  { bottomInset = 0, onRecorded, onRecordingChange },
  ref,
) {
  const { t } = useTranslation();
  const push = useToastStore(state => state.push);
  const [stopping, setStopping] = useState(false);
  const mountedRef = useRef(true);

  const complete = useCallback(
    (recording: VoiceRecording | null) => {
      setStopping(false);
      onRecordingChange(false);
      if (recording != null) onRecorded(recording);
    },
    [onRecorded, onRecordingChange],
  );

  const recorder = useVoiceRecorder(complete);

  const showMicrophoneSettings = useCallback(() => {
    Alert.alert(t('chat.attachRecord'), t('chat.voiceMicDenied'), [
      { text: t('dialog.cancel'), style: 'cancel' },
      {
        text: t('settings.title'),
        onPress: () => {
          void Linking.openSettings().catch(() =>
            push('error', t('chat.voiceRecordError')),
          );
        },
      },
    ]);
  }, [push, t]);

  const handleStartError = useCallback(
    (result: VoiceRecorderStartResult) => {
      if (result === 'permission-blocked') {
        showMicrophoneSettings();
      } else if (result === 'permission-denied') {
        push('error', t('chat.voiceMicDenied'));
      } else if (result === 'unavailable') {
        push('error', t('chat.voiceMicUnavailable'));
      } else if (result === 'error') {
        push('error', t('chat.voiceRecordError'));
      }
    },
    [push, showMicrophoneSettings, t],
  );

  const start = useCallback(async () => {
    if (recorder.isRecording || recorder.isStarting) return;
    const result = await recorder.start();
    if (!mountedRef.current) return;
    if (result === 'started') {
      onRecordingChange(true);
    } else {
      handleStartError(result);
    }
  }, [handleStartError, onRecordingChange, recorder]);

  useImperativeHandle(ref, () => ({ start: () => void start() }), [start]);

  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
    };
  }, []);

  async function stop() {
    if (stopping || recorder.isStopping || !recorder.isRecording) return;
    setStopping(true);
    const recording = await recorder.stop();
    if (!mountedRef.current) return;
    setStopping(false);
    onRecordingChange(false);
    if (recording == null) {
      push('info', t('chat.voiceTooShort'));
      return;
    }
    onRecorded(recording);
  }

  async function cancel() {
    if (stopping || recorder.isStopping) return;
    setStopping(true);
    await recorder.cancel();
    if (!mountedRef.current) return;
    setStopping(false);
    onRecordingChange(false);
  }

  if (!recorder.isRecording) return null;

  return (
    <View
      className="min-h-12 flex-row items-center gap-2 bg-white px-3 py-1.5"
      style={{
        borderTopWidth: 1,
        borderTopColor: DIVIDER,
        paddingBottom: Math.max(6, bottomInset),
      }}
    >
      <Pressable
        onPress={() => void stop()}
        disabled={stopping || recorder.isStopping}
        accessibilityLabel={t('chat.voiceTapStop')}
        className="h-8 w-8 items-center justify-center rounded-full bg-ola-primary active:opacity-80"
        style={{ opacity: stopping || recorder.isStopping ? 0.6 : 1 }}
      >
        {stopping || recorder.isStopping ? (
          <ActivityIndicator size="small" color="#ffffff" />
        ) : (
          <View
            style={{
              width: 12,
              height: 12,
              borderRadius: 3,
              backgroundColor: '#ffffff',
            }}
          />
        )}
      </Pressable>

      <View
        className="min-w-0 flex-1 flex-row items-center px-2"
        accessibilityLabel={t('chat.voiceRecording')}
      >
        <VoiceWaveformBars
          waveform={recorder.waveform}
          duration={recorder.elapsedMs / 1000}
          progress={1}
          tone="recording"
          fluid
        />
      </View>

      <View className="shrink-0 flex-row items-center gap-1">
        <View
          style={{
            width: 10,
            height: 10,
            borderRadius: 5,
            backgroundColor: '#f02849',
          }}
        />
        <Text
          className="w-10 text-right text-sm font-medium text-ola-ink-soft"
          style={{ fontVariant: ['tabular-nums'] }}
        >
          {formatDurationMs(recorder.elapsedMs)}
        </Text>
      </View>

      <Pressable
        onPress={() => void cancel()}
        disabled={stopping || recorder.isStopping}
        accessibilityLabel={t('chat.voiceDiscard')}
        className="h-9 w-9 items-center justify-center active:opacity-70"
        style={{ opacity: stopping || recorder.isStopping ? 0.5 : 1 }}
      >
        <Image
          source={deleteIcon}
          style={{ width: 20, height: 20 }}
          resizeMode="contain"
        />
      </Pressable>
    </View>
  );
});
