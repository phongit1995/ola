import { describe, expect, it } from 'vitest';
import { deriveUltimateControlState } from './ultimate-control-state';

const base = {
  cost: 100,
  inGame: true,
  roomPregame: false,
  over: false,
  myTurn: true,
  busy: false,
};

describe('deriveUltimateControlState', () => {
  it.each([
    [-1, 0],
    [0, 0],
    [25, 25],
    [50, 50],
    [98, 98],
    [99.4, 99],
    [100, 100],
    [101, 100],
  ])('maps %s mana to %s%% charge against the cast cost', (mana, chargePct) => {
    const state = deriveUltimateControlState({ ...base, mana });
    expect(state.chargePct).toBe(chargePct);
    expect(state.charged).toBe(chargePct === 100);
  });

  it('only enables casting when charged, visible, idle and on the player turn', () => {
    expect(deriveUltimateControlState({ ...base, mana: 100 }).canCast).toBe(true);
    expect(deriveUltimateControlState({ ...base, mana: 99 }).canCast).toBe(false);
    expect(deriveUltimateControlState({ ...base, mana: 100, myTurn: false }).canCast).toBe(false);
    expect(deriveUltimateControlState({ ...base, mana: 100, busy: true }).canCast).toBe(false);
    expect(deriveUltimateControlState({ ...base, mana: 100, over: true }).canCast).toBe(false);
    expect(deriveUltimateControlState({ ...base, mana: 100, disconnected: true }).canCast).toBe(false);
  });

  it('hides outside an active match', () => {
    expect(deriveUltimateControlState({ ...base, mana: 100, inGame: false }).visible).toBe(false);
    expect(deriveUltimateControlState({ ...base, mana: 100, roomPregame: true }).visible).toBe(false);
    expect(deriveUltimateControlState({ ...base, mana: 100, over: true }).visible).toBe(false);
  });

  it('fails closed when the configured mana cost is invalid', () => {
    expect(deriveUltimateControlState({ ...base, mana: 100, cost: 0 })).toMatchObject({
      chargePct: 0,
      charged: false,
      canCast: false,
    });
  });
});
