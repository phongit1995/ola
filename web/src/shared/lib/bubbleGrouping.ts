import type { CSSProperties } from 'react';
import {
  LOBBY_WALLPAPER_OPACITY,
  WALLPAPER_OPACITY,
} from '@ola/shared/constants';

export const BUBBLE_SURFACE_OUT = 'bg-ola-primary text-ola-on-primary';
export const BUBBLE_SURFACE_IN = 'bg-white text-black/87 shadow-sm';
export const BUBBLE_SURFACE_FAILED = 'bg-ola-bubble-failed text-black/87';
export const BUBBLE_WALLPAPER = 'bg-ola-wallpaper';

const WALLPAPER_SCRIM_PERCENT = Math.round((1 - WALLPAPER_OPACITY) * 100);

const LOBBY_WALLPAPER_SCRIM_PERCENT = Math.round(
  (1 - LOBBY_WALLPAPER_OPACITY) * 100
);

function wallpaperStyle(
  wallpaperUrl: string,
  scrimPercent: number
): CSSProperties | undefined {
  if (wallpaperUrl === '') return undefined;
  const scrim = `color-mix(in srgb, var(--color-ola-wallpaper) ${scrimPercent}%, transparent)`;
  return {
    backgroundImage:
      scrimPercent > 0
        ? `linear-gradient(${scrim}, ${scrim}), url(${wallpaperUrl})`
        : `url(${wallpaperUrl})`,
    backgroundSize: 'cover',
    backgroundPosition: 'center',
    backgroundRepeat: 'no-repeat',
  };
}

export function chatWallpaperStyle(
  wallpaperUrl: string
): CSSProperties | undefined {
  return wallpaperStyle(wallpaperUrl, WALLPAPER_SCRIM_PERCENT);
}

export function lobbyWallpaperStyle(
  wallpaperUrl: string
): CSSProperties | undefined {
  return wallpaperStyle(wallpaperUrl, LOBBY_WALLPAPER_SCRIM_PERCENT);
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
