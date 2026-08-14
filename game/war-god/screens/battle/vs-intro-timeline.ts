export const VS_INTRO_DURATION_MS = 900;
export const VS_INTRO_REDUCED_DURATION_MS = 520;

export interface VsIntroFrame {
  done: boolean;
  dimAlpha: number;
  rowAlpha: number;
  leftRowOffset: number;
  rightRowOffset: number;
  swordAlpha: number;
  leftSwordX: number;
  rightSwordX: number;
  swordY: number;
  swordScale: number;
  impactAlpha: number;
  impactScale: number;
}

function clamp01(value: number): number {
  return Math.max(0, Math.min(1, value));
}

function easeOutCubic(value: number): number {
  const inverse = 1 - value;
  return 1 - inverse * inverse * inverse;
}

function easeInCubic(value: number): number {
  return value * value * value;
}

function pulse(value: number, start: number, peak: number, end: number): number {
  if (value <= start || value >= end) return 0;
  if (value <= peak) return (value - start) / (peak - start);
  return 1 - (value - peak) / (end - peak);
}

export function vsIntroFrame(elapsedMs: number, reducedMotion = false): VsIntroFrame {
  const elapsed = Math.max(0, elapsedMs);
  if (reducedMotion) {
    const fadeIn = clamp01(elapsed / 100);
    const fadeOut = clamp01((elapsed - 360) / 160);
    const alpha = fadeIn * (1 - fadeOut);
    return {
      done: elapsed >= VS_INTRO_REDUCED_DURATION_MS,
      dimAlpha: 0.86 * alpha,
      rowAlpha: alpha,
      leftRowOffset: 0,
      rightRowOffset: 0,
      swordAlpha: alpha,
      leftSwordX: 0,
      rightSwordX: 0,
      swordY: 0,
      swordScale: 1,
      impactAlpha: 0,
      impactScale: 1,
    };
  }

  const rowIn = easeOutCubic(clamp01(elapsed / 180));
  const swordIn = easeOutCubic(clamp01((elapsed - 130) / 260));
  const swordFadeIn = clamp01((elapsed - 80) / 110);
  const exit = easeInCubic(clamp01((elapsed - 650) / 250));
  const visible = 1 - exit;
  const impact = pulse(elapsed, 350, 410, 535);

  return {
    done: elapsed >= VS_INTRO_DURATION_MS,
    dimAlpha: 0.86 * Math.min(rowIn, swordFadeIn) * visible,
    rowAlpha: rowIn * visible,
    leftRowOffset: -250 * (1 - rowIn) - 190 * exit,
    rightRowOffset: 250 * (1 - rowIn) + 190 * exit,
    swordAlpha: swordFadeIn * visible,
    leftSwordX: -190 * (1 - swordIn) - 38 * exit,
    rightSwordX: 190 * (1 - swordIn) + 38 * exit,
    swordY: -95 * (1 - swordIn),
    swordScale: 0.68 + 0.32 * swordIn + 0.08 * exit,
    impactAlpha: impact * visible,
    impactScale: 0.55 + 0.75 * impact,
  };
}
