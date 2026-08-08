import type { CSSProperties } from 'react';
import { WALLPAPER_OPACITY } from '@ola/shared/constants';

export const BUBBLE_SURFACE_OUT = 'bg-ola-bubble-out';
export const BUBBLE_SURFACE_IN = 'bg-white shadow-sm';
export const BUBBLE_SURFACE_FAILED = 'bg-ola-bubble-failed';
export const BUBBLE_WALLPAPER = 'bg-ola-wallpaper';

const WALLPAPER_SCRIM_PERCENT = Math.round((1 - WALLPAPER_OPACITY) * 100);

export function chatWallpaperStyle(
  wallpaperUrl: string
): CSSProperties | undefined {
  if (wallpaperUrl === '') return undefined;
  const scrim = `color-mix(in srgb, var(--color-ola-wallpaper) ${WALLPAPER_SCRIM_PERCENT}%, transparent)`;
  return {
    backgroundImage: `linear-gradient(${scrim}, ${scrim}), url(${wallpaperUrl})`,
    backgroundSize: 'cover',
    backgroundPosition: 'center',
    backgroundRepeat: 'no-repeat',
  };
}

export function bubbleSurface(isOut: boolean, failed: boolean): string {
  if (failed) return BUBBLE_SURFACE_FAILED;
  return isOut ? BUBBLE_SURFACE_OUT : BUBBLE_SURFACE_IN;
}

export function bubbleCorners(
  isOut: boolean,
  firstInGroup: boolean,
  lastInGroup: boolean
): string {
  const top = firstInGroup ? '' : isOut ? 'rounded-tr-sm' : 'rounded-tl-sm';
  const bottom = lastInGroup ? '' : isOut ? 'rounded-br-sm' : 'rounded-bl-sm';
  return `${top} ${bottom}`;
}
