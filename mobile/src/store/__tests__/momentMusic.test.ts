import { MOMENT_MUSIC_START_STEP_MS, MOMENT_MUSIC_TOTAL_MS, MOMENT_SLIDE_MS, MOMENT_TYPE } from '@ola/shared/constants';
import {
  momentMusicDefaultTitle,
  momentMusicEndMs,
  momentMusicLoops,
  momentMusicMaxStartMs,
  momentMusicTrimBars,
  momentSlideMs,
  resolveMomentMusicTitle,
  snapMomentMusicStart,
} from '@ola/shared/lib';

describe('momentMusic', () => {
  it('loops only when the song is shorter than the moment', () => {
    expect(momentMusicLoops(MOMENT_MUSIC_TOTAL_MS - 1)).toBe(true);
    expect(momentMusicLoops(MOMENT_MUSIC_TOTAL_MS)).toBe(false);
  });

  it('keeps the selected part inside the song', () => {
    expect(momentMusicMaxStartMs(75000)).toBe(75000 - MOMENT_MUSIC_TOTAL_MS);
    expect(momentMusicMaxStartMs(10000)).toBe(0);
    expect(momentMusicEndMs({ startMs: 21000, durationMs: 75000 })).toBe(21000 + MOMENT_MUSIC_TOTAL_MS);
    expect(momentMusicEndMs({ startMs: 0, durationMs: 10000 })).toBe(10000);
  });

  it('snaps the start to the step and clamps it', () => {
    expect(snapMomentMusicStart(1100, 60000) % MOMENT_MUSIC_START_STEP_MS).toBe(0);
    expect(snapMomentMusicStart(-500, 60000)).toBe(0);
    expect(snapMomentMusicStart(99999, 60000)).toBe(60000);
  });

  it('draws every trim bar inside the track', () => {
    const bars = momentMusicTrimBars(56);
    expect(bars).toHaveLength(56);
    expect(bars.every((height) => height > 0 && height <= 1)).toBe(true);
  });

  it('falls back to the file name for a blank title', () => {
    expect(momentMusicDefaultTitle('Mua_thu_Ha_Noi.mp3')).toBe('Mua thu Ha Noi');
    expect(resolveMomentMusicTitle({ title: '  ', fileName: 'bai.mp3' })).toBe('bai');
    expect(resolveMomentMusicTitle({ title: 'Mùa thu', fileName: 'bai.mp3' })).toBe('Mùa thu');
  });

  it('shows a page for the length of its music clip', () => {
    const music = { url: 'u', title: 't', durationMs: 7500 };
    expect(momentSlideMs({ type: MOMENT_TYPE.image, music, duration: 7.5 })).toBe(7500);
    expect(momentSlideMs({ type: MOMENT_TYPE.image, duration: 0 })).toBe(MOMENT_SLIDE_MS);
    expect(momentSlideMs({ type: MOMENT_TYPE.video, music, duration: 20 })).toBe(MOMENT_SLIDE_MS);
  });
});
