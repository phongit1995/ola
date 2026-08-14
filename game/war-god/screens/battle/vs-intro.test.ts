import { describe, expect, it } from 'vitest';
import type { MatchFoundData, UserInfoData } from '../../../src/sdk';
import { buildBotVsIntroData, buildPvpVsIntroData } from './vs-intro-data';
import {
  VS_INTRO_DURATION_MS,
  VS_INTRO_REDUCED_DURATION_MS,
  vsIntroFrame,
} from './vs-intro-timeline';

const user: UserInfoData = {
  id: 'self',
  username: 'phong',
  vipType: '135',
  vipDays: 2,
  ken: 1000,
};

describe('War God VS intro data', () => {
  it('keeps the opponent on the left and local PvP player on the right', () => {
    const match = {
      players: [
        { id: 'foe', name: 'doi-thu', vipType: '2' },
        { id: 'self', name: 'phong', vipType: '135' },
      ],
      you: 1,
    } as MatchFoundData<unknown>;
    expect(buildPvpVsIntroData(match, user)).toEqual({
      left: { name: 'doi-thu', vipType: '2' },
      right: { name: 'phong', vipType: '135' },
    });
  });

  it('maps bot difficulty to a stable VIP icon and label', () => {
    expect(buildBotVsIntroData(user, 'hard')).toEqual({
      left: { name: 'máy · KHÓ', vipType: '3' },
      right: { name: 'phong', vipType: '135' },
    });
  });
});

describe('War God VS intro timeline', () => {
  it('brings the swords together, flashes once, and completes within board drop time', () => {
    const start = vsIntroFrame(0);
    const crossed = vsIntroFrame(410);
    const end = vsIntroFrame(VS_INTRO_DURATION_MS);
    expect(start.swordAlpha).toBe(0);
    expect(crossed.leftSwordX).toBeCloseTo(0);
    expect(crossed.rightSwordX).toBeCloseTo(0);
    expect(crossed.impactAlpha).toBe(1);
    expect(end.done).toBe(true);
    expect(end.dimAlpha).toBe(0);
    expect(VS_INTRO_DURATION_MS).toBeLessThanOrEqual(985);
  });

  it('uses a static, shorter reduced-motion presentation', () => {
    const middle = vsIntroFrame(220, true);
    const end = vsIntroFrame(VS_INTRO_REDUCED_DURATION_MS, true);
    expect(middle.leftRowOffset).toBe(0);
    expect(middle.rightRowOffset).toBe(0);
    expect(middle.impactAlpha).toBe(0);
    expect(end.done).toBe(true);
    expect(end.rowAlpha).toBe(0);
  });
});
