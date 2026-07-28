export const VOICE_RECORDING_BAR_COUNT = 30;
export const VOICE_MESSAGE_BAR_COUNT = 22;
export const VOICE_MIN_LEVEL = 0.08;

const METERING_FLOOR_DB = -60;

export function voiceLevelFromMetering(metering: number | undefined): number {
  if (metering == null || !Number.isFinite(metering)) return VOICE_MIN_LEVEL;
  const normalized = Math.min(1, Math.max(0, (metering - METERING_FLOOR_DB) / -METERING_FLOOR_DB));
  return VOICE_MIN_LEVEL + Math.sqrt(normalized) * (1 - VOICE_MIN_LEVEL);
}

export function smoothVoiceLevel(previous: number, next: number): number {
  const weight = next > previous ? 0.72 : 0.28;
  return previous + (next - previous) * weight;
}

export function voiceWaveformBarHeight(level: number): number {
  const normalized = Math.min(1, Math.max(0, (level - VOICE_MIN_LEVEL) / (1 - VOICE_MIN_LEVEL)));
  return 4 + Math.round(Math.pow(normalized, 0.72) * 20);
}

export function summarizeVoiceWaveform(
  samples: number[],
  count = VOICE_RECORDING_BAR_COUNT
): number[] {
  if (samples.length === 0) {
    return Array.from({ length: count }, () => VOICE_MIN_LEVEL);
  }

  if (samples.length <= count) {
    return Array.from({ length: count }, (_, index) => {
      const position = count === 1 ? 0 : (index * (samples.length - 1)) / (count - 1);
      const left = Math.floor(position);
      const right = Math.min(samples.length - 1, Math.ceil(position));
      const ratio = position - left;
      return (
        (samples[left] ?? VOICE_MIN_LEVEL) * (1 - ratio) +
        (samples[right] ?? VOICE_MIN_LEVEL) * ratio
      );
    });
  }

  return Array.from({ length: count }, (_, index) => {
    const start = Math.floor((index * samples.length) / count);
    const end = Math.max(start + 1, Math.floor(((index + 1) * samples.length) / count));
    const bucket = samples.slice(start, end);
    const average = bucket.reduce((sum, sample) => sum + sample, 0) / bucket.length;
    const peak = Math.max(...bucket);
    return Math.max(VOICE_MIN_LEVEL, Math.min(1, average * 0.65 + peak * 0.35));
  });
}

export function normalizeVoiceWaveform(
  waveform: number[] | undefined,
  count: number,
  seed = 0
): number[] {
  const samples = (waveform ?? []).filter((sample) => Number.isFinite(sample) && sample >= 0);

  if (samples.length === 0) {
    return Array.from({ length: count }, (_, index) => {
      const variation = Math.abs(Math.sin((index + seed) * 1.7));
      return 0.18 + variation * 0.72;
    });
  }

  return Array.from({ length: count }, (_, index) => {
    const sourceIndex = Math.min(samples.length - 1, Math.floor((index * samples.length) / count));
    return Math.max(VOICE_MIN_LEVEL, Math.min(1, samples[sourceIndex] ?? VOICE_MIN_LEVEL));
  });
}
