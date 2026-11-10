import {
  MOMENT_MUSIC_EXTENSIONS,
  MOMENT_MUSIC_SLIDE_SECONDS,
  MOMENT_MUSIC_TITLE_MAX,
  MOMENT_SLIDE_MS,
  MOMENT_TYPE,
} from '../constants/moment';
import type { Moment } from '../types/api/moment.type';
import type { MomentMusicDraft, MomentMusicSeconds } from '../types/client/moment.type';

const MS_PER_SECOND = 1000;
const SECONDS_PER_MINUTE = 60;

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

export function momentMusicTotalMs(slideSeconds: number, slideCount: number): number {
  return slideSeconds * MS_PER_SECOND * slideCount;
}

export function momentMusicMaxStartMs(
  durationMs: number,
  slideSeconds: number,
  slideCount: number
): number {
  return Math.max(0, durationMs - momentMusicTotalMs(slideSeconds, slideCount));
}

export function momentMusicFits(
  durationMs: number,
  slideSeconds: number,
  slideCount: number
): boolean {
  return momentMusicTotalMs(slideSeconds, slideCount) <= durationMs;
}

export function fitMomentMusic(
  draft: MomentMusicDraft,
  slideCount: number
): MomentMusicDraft | null {
  const seconds = [...MOMENT_MUSIC_SLIDE_SECONDS]
    .reverse()
    .find(
      (value): value is MomentMusicSeconds =>
        value <= draft.slideSeconds && momentMusicFits(draft.durationMs, value, slideCount)
    );
  if (seconds == null) return null;
  const maxStart = momentMusicMaxStartMs(draft.durationMs, seconds, slideCount);
  return { ...draft, slideSeconds: seconds, startMs: Math.min(draft.startMs, maxStart) };
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
