import {
  MOMENT_MUSIC_EXTENSIONS,
  MOMENT_MUSIC_START_STEP_MS,
  MOMENT_MUSIC_TITLE_MAX,
  MOMENT_MUSIC_TOTAL_MS,
  MOMENT_SLIDE_MS,
  MOMENT_TYPE,
} from '../constants/moment';
import type { Moment } from '../types/api/moment.type';
import type { MomentMusicDraft } from '../types/client/moment.type';

const MS_PER_SECOND = 1000;
const SECONDS_PER_MINUTE = 60;
const TRIM_BAR_FLOOR = 0.28;
const TRIM_WAVE_FAST = { step: 1.7, weight: 0.6 };
const TRIM_WAVE_SLOW = { step: 0.45, shift: 1, weight: 0.4 };

function fileExtension(name: string): string {
  const dot = name.lastIndexOf('.');
  return dot < 0 ? '' : name.slice(dot + 1).toLowerCase();
}

export function isMomentMusicFile(name: string): boolean {
  return (MOMENT_MUSIC_EXTENSIONS as readonly string[]).includes(fileExtension(name));
}

export function momentMusicDefaultTitle(fileName: string): string {
  const dot = fileName.lastIndexOf('.');
  const base = dot > 0 ? fileName.slice(0, dot) : fileName;
  const title = base.replace(/[_]+/g, ' ').trim();
  return (title || fileName.trim()).slice(0, MOMENT_MUSIC_TITLE_MAX).trim();
}

export function resolveMomentMusicTitle(draft: Pick<MomentMusicDraft, 'title' | 'fileName'>): string {
  return draft.title.trim() || momentMusicDefaultTitle(draft.fileName);
}

export function momentMusicLoops(durationMs: number): boolean {
  return durationMs < MOMENT_MUSIC_TOTAL_MS;
}

export function momentMusicMaxStartMs(durationMs: number): number {
  return Math.max(0, durationMs - MOMENT_MUSIC_TOTAL_MS);
}

export function momentMusicEndMs(draft: Pick<MomentMusicDraft, 'startMs' | 'durationMs'>): number {
  return Math.min(draft.durationMs, draft.startMs + MOMENT_MUSIC_TOTAL_MS);
}

export function snapMomentMusicStart(valueMs: number, maxStartMs: number): number {
  const stepped = Math.round(valueMs / MOMENT_MUSIC_START_STEP_MS) * MOMENT_MUSIC_START_STEP_MS;
  return Math.min(maxStartMs, Math.max(0, stepped));
}

export function momentMusicTrimBars(count: number): number[] {
  return Array.from({ length: count }, (_, index) => {
    const wave = Math.abs(
      Math.sin(index * TRIM_WAVE_FAST.step) * TRIM_WAVE_FAST.weight +
        Math.sin(index * TRIM_WAVE_SLOW.step + TRIM_WAVE_SLOW.shift) * TRIM_WAVE_SLOW.weight
    );
    return TRIM_BAR_FLOOR + wave * (1 - TRIM_BAR_FLOOR);
  });
}

export function momentSlideMs(moment: Pick<Moment, 'type' | 'music' | 'duration'>): number {
  if (moment.type === MOMENT_TYPE.video || moment.music == null || !moment.duration) {
    return MOMENT_SLIDE_MS;
  }
  return moment.duration * MS_PER_SECOND;
}

export function formatMomentMusicTime(ms: number): string {
  const total = Math.max(0, Math.round(ms / MS_PER_SECOND));
  const minutes = Math.floor(total / SECONDS_PER_MINUTE);
  const seconds = total % SECONDS_PER_MINUTE;
  return `${minutes}:${String(seconds).padStart(2, '0')}`;
}
