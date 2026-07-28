import { View } from 'react-native';
import {
  normalizeVoiceWaveform,
  voiceWaveformBarHeight,
  VOICE_MESSAGE_BAR_COUNT,
  VOICE_RECORDING_BAR_COUNT,
} from '@ola/shared/lib';

export const VOICE_WAVEFORM_WIDTH = 86;

interface VoiceWaveformBarsProps {
  waveform?: number[];
  duration?: number;
  progress: number;
  tone: 'outgoing' | 'incoming' | 'preview' | 'recording';
  fluid?: boolean;
}

export function VoiceWaveformBars({
  waveform,
  duration = 0,
  progress,
  tone,
  fluid = false,
}: VoiceWaveformBarsProps) {
  const barCount = fluid ? VOICE_RECORDING_BAR_COUNT : VOICE_MESSAGE_BAR_COUNT;
  const bars = normalizeVoiceWaveform(
    waveform,
    barCount,
    Math.round(duration * 10),
  );

  return (
    <View
      pointerEvents="none"
      className="h-7 flex-row items-center overflow-hidden"
      style={
        fluid
          ? { flex: 1, justifyContent: 'space-between' }
          : {
              width: VOICE_WAVEFORM_WIDTH,
              justifyContent: 'center',
              gap: 2,
            }
      }
    >
      {bars.map((level, index) => {
        const played = (index + 1) / bars.length <= progress;
        const backgroundColor =
          tone === 'recording'
            ? '#7cb342'
            : tone === 'outgoing'
            ? played
              ? '#ffffff'
              : 'rgba(255,255,255,0.45)'
            : played
            ? '#7cb342'
            : tone === 'preview'
            ? 'rgba(0,0,0,0.15)'
            : 'rgba(0,0,0,0.20)';

        return (
          <View
            key={index}
            style={{
              width: fluid ? 3 : 2,
              height: voiceWaveformBarHeight(level),
              flexShrink: 0,
              borderRadius: 999,
              backgroundColor,
            }}
          />
        );
      })}
    </View>
  );
}
