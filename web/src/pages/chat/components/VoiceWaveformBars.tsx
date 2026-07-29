import {
  normalizeVoiceWaveform,
  voiceWaveformBarHeight,
  VOICE_MESSAGE_BAR_COUNT,
  VOICE_RECORDING_BAR_COUNT,
} from '@ola/shared/lib';

export const VOICE_WAVEFORM_BAR_COUNT = VOICE_MESSAGE_BAR_COUNT;

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
  const barCount = fluid ? VOICE_RECORDING_BAR_COUNT : VOICE_WAVEFORM_BAR_COUNT;
  const bars = normalizeVoiceWaveform(
    waveform,
    barCount,
    Math.round(duration * 10)
  );

  return (
    <span
      aria-hidden="true"
      className="flex h-7 w-full items-center justify-between overflow-hidden"
    >
      {bars.map((level, index) => {
        const played = (index + 1) / bars.length <= progress;
        const color =
          tone === 'recording'
            ? 'bg-ola-primary'
            : tone === 'outgoing'
              ? played
                ? 'bg-white'
                : 'bg-white/45'
              : played
                ? 'bg-ola-primary'
                : tone === 'preview'
                  ? 'bg-black/15'
                  : 'bg-black/20';

        return (
          <span
            key={index}
            className={`${fluid ? 'w-[3px]' : 'w-[2px]'} shrink-0 rounded-full ${color}`}
            style={{ height: `${voiceWaveformBarHeight(level)}px` }}
          />
        );
      })}
    </span>
  );
}
