import type { SourceClip } from './types/ClipTypes';

/** Same piecewise cubic coefficients exported for the original NGUI UI. */
export function sampleClip(clip: SourceClip, time: number, defaults: number[]): number[] {
  const t = Math.max(0, Math.min(time, clip.duration)),
    values = defaults.slice();
  let frame: SourceClip['frames'][number] | undefined;
  for (const f of clip.frames) {
    if (f.time > t) break;
    frame = f;
  }
  if (frame)
    for (const [index, a, b, c, d] of frame.keys) {
      const dt = t - frame.time;
      values[index] = ((a * dt + b) * dt + c) * dt + d;
    }
  return values;
}
