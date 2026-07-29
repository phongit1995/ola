import {
  VOICE_LEVEL_DRIFT_DB_PER_SECOND,
  VOICE_LEVEL_FLOOR_FALL_DB_PER_SECOND,
  VOICE_LEVEL_MIN_SPAN_DB,
  VOICE_METERING_INTERVAL_MS,
  VOICE_MIN_LEVEL,
  VOICE_RECORDING_BAR_COUNT,
  VOICE_SILENCE_DB,
} from './voiceWaveform.constants';

export * from './voiceWaveform.constants';

export function smoothVoiceLevel(previous: number, next: number): number {
  const weight = next > previous ? 0.72 : 0.28;
  return previous + (next - previous) * weight;
}

export function voiceDbFromAmplitude(amplitude: number): number {
  if (!Number.isFinite(amplitude) || amplitude <= 0) return VOICE_SILENCE_DB;
  return Math.max(VOICE_SILENCE_DB, Math.min(0, 20 * Math.log10(amplitude)));
}

export function createVoiceLevelTracker(
  intervalMs = VOICE_METERING_INTERVAL_MS
): (decibels: number | undefined) => number {
  const seconds = Math.max(1, intervalMs) / 1000;
  const driftDb = VOICE_LEVEL_DRIFT_DB_PER_SECOND * seconds;
  const floorFallDb = VOICE_LEVEL_FLOOR_FALL_DB_PER_SECOND * seconds;
  let floor: number | null = null;
  let peak: number | null = null;
  let level = VOICE_MIN_LEVEL;

  return (decibels) => {
    if (decibels == null || !Number.isFinite(decibels) || decibels <= VOICE_SILENCE_DB) {
      level = smoothVoiceLevel(level, VOICE_MIN_LEVEL);
      return level;
    }
    if (floor == null) {
      floor = decibels;
    } else if (decibels < floor) {
      floor = Math.max(decibels, floor - floorFallDb);
    } else {
      floor = Math.min(decibels, floor + driftDb);
    }
    peak = peak == null ? decibels : Math.max(decibels, peak - driftDb);
    const span = Math.max(VOICE_LEVEL_MIN_SPAN_DB, peak - floor);
    const normalized = Math.min(1, Math.max(0, (decibels - floor) / span));
    level = smoothVoiceLevel(level, VOICE_MIN_LEVEL + normalized * (1 - VOICE_MIN_LEVEL));
    return level;
  };
}

function decibelPercentile(sorted: number[], ratio: number): number {
  const index = Math.min(sorted.length - 1, Math.max(0, Math.round((sorted.length - 1) * ratio)));
  return sorted[index] ?? VOICE_SILENCE_DB;
}

export function voiceLevelsFromDecibels(samples: number[]): number[] {
  const isAudible = (sample: number) => Number.isFinite(sample) && sample > VOICE_SILENCE_DB;
  const audible = samples.filter(isAudible);
  if (audible.length === 0) return samples.map(() => VOICE_MIN_LEVEL);

  const sorted = [...audible].sort((left, right) => left - right);
  const floor = decibelPercentile(sorted, 0.05);
  const peak = Math.max(
    decibelPercentile(sorted, 0.95),
    floor + VOICE_LEVEL_MIN_SPAN_DB
  );
  const span = peak - floor;

  return samples.map((sample) => {
    if (!isAudible(sample)) return VOICE_MIN_LEVEL;
    const normalized = Math.min(1, Math.max(0, (sample - floor) / span));
    return VOICE_MIN_LEVEL + normalized * (1 - VOICE_MIN_LEVEL);
  });
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
