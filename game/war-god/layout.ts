export const DESIGN_W = 520;
// Desktop DPR 1-1.5 otherwise minifies the painted assets into too few samples,
// making every thin outline look stair-stepped. Retina-class devices already
// meet this floor, so they keep their native density.
export const MIN_RENDER_RESOLUTION = 2;

export function renderResolution(devicePixelRatio: number | undefined): number {
  const dpr =
    typeof devicePixelRatio === 'number' && Number.isFinite(devicePixelRatio) && devicePixelRatio > 0
      ? devicePixelRatio
      : 1;
  return Math.max(MIN_RENDER_RESOLUTION, dpr);
}

type ResolutionWindow = Pick<Window, 'devicePixelRatio' | 'setInterval' | 'clearInterval'>;

export function watchDevicePixelRatio(
  target: ResolutionWindow,
  onChange: () => void,
): () => void {
  let observedDpr = target.devicePixelRatio;
  // Chromium can move a fixed-size Electron window between monitors without
  // dispatching a window resize, so do not rely on resize alone for DPR sync.
  const interval = target.setInterval(() => {
    if (target.devicePixelRatio === observedDpr) return;
    observedDpr = target.devicePixelRatio;
    onChange();
  }, 500);

  return () => {
    target.clearInterval(interval);
  };
}
