export function normalizeVoiceWaveform(
  waveform: number[] | undefined,
  count: number,
  seed = 0
): number[] {
  const samples = (waveform ?? []).filter(
    (sample) => Number.isFinite(sample) && sample >= 0
  );

  if (samples.length === 0) {
    return Array.from({ length: count }, (_, index) => {
      const variation = Math.abs(Math.sin((index + seed) * 1.7));
      return 0.18 + variation * 0.72;
    });
  }

  return Array.from({ length: count }, (_, index) => {
    const sourceIndex = Math.min(
      samples.length - 1,
      Math.floor((index * samples.length) / count)
    );
    return Math.max(0.08, Math.min(1, samples[sourceIndex] ?? 0.08));
  });
}
