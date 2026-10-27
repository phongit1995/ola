export interface LoadingFrame {
  ringAngle: number;
  dieAngles: [number, number];
}

export function loadingFrame(time: number): LoadingFrame {
  const elapsed = Math.max(0, time);
  const turn = Math.floor(elapsed / 2800) % 4;
  const t = elapsed % 2800;
  const p = Math.min(1, t / 1400);
  const roll = Math.max(0, Math.min(1, (t - 1600) / 700));
  const easedRoll = roll * roll * (3 - 2 * roll);
  return {
    ringAngle: 360 * p * p * (3 - 2 * p),
    dieAngles: [40, -30 - 90 * (turn + easedRoll)],
  };
}
