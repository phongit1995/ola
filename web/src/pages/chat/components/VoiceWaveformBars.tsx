import { normalizeVoiceWaveform } from './voiceWaveform';

export const VOICE_WAVEFORM_BAR_COUNT = 22;
export const VOICE_WAVEFORM_WIDTH_CLASS = 'w-[86px]';

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
  const barCount = fluid ? 30 : VOICE_WAVEFORM_BAR_COUNT;
  const bars = normalizeVoiceWaveform(
    waveform,
    barCount,
    Math.round(duration * 10)
  );

  return (
    <span
      aria-hidden="true"
      className={`flex h-7 shrink-0 items-center overflow-hidden ${
        fluid
          ? 'w-full justify-between'
          : `${VOICE_WAVEFORM_WIDTH_CLASS} justify-center gap-[2px]`
      }`}
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
            style={{
              height: `${
                4 +
                Math.round(
                  Math.pow(Math.max(0, (level - 0.08) / 0.92), 0.72) * 20
                )
              }px`,
            }}
          />
        );
      })}
    </span>
  );
}
