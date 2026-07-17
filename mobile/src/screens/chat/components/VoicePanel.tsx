import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useVoiceRecorder, type VoiceRecording } from '@hooks/useVoiceRecorder';

function formatElapsed(ms: number): string {
  const total = Math.floor(ms / 1000);
  const mm = Math.floor(total / 60);
  const ss = total % 60;
  return `${mm}:${ss.toString().padStart(2, '0')}`;
}

interface VoicePanelProps {
  onRecorded: (recording: VoiceRecording) => void;
}

export function VoicePanel({ onRecorded }: VoicePanelProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);

  const finish = useCallback(
    (recording: VoiceRecording | null) => {
      if (recording == null) {
        push('error', t('chat.voiceRecordError'));
        return;
      }
      onRecorded(recording);
    },
    [onRecorded, push, t]
  );

  const recorder = useVoiceRecorder(() => {
    void recorder.stop().then(finish);
  });

  async function toggle() {
    if (recorder.isRecording) {
      finish(await recorder.stop());
      return;
    }
    const ok = await recorder.start();
    if (!ok) push('error', t('chat.voiceMicDenied'));
  }

  return (
    <View className="items-center gap-3 px-4 py-6">
      <Text className="text-lg font-semibold text-ola-ink">
        {recorder.isRecording ? formatElapsed(recorder.elapsedMs) : t('chat.attachTabVoice')}
      </Text>
      <Pressable
        onPress={() => void toggle()}
        className="h-16 w-16 items-center justify-center rounded-full active:opacity-80"
        style={{ backgroundColor: recorder.isRecording ? '#e34545' : '#7cb342' }}
      >
        <View
          style={
            recorder.isRecording
              ? { width: 22, height: 22, borderRadius: 4, backgroundColor: '#ffffff' }
              : { width: 22, height: 22, borderRadius: 11, backgroundColor: '#ffffff' }
          }
        />
      </Pressable>
      <Text className="text-sm text-ola-ink-soft">
        {recorder.isRecording ? t('chat.voiceTapStop') : t('chat.voiceTapStart')}
      </Text>
    </View>
  );
}
