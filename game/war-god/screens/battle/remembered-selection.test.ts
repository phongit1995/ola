import { describe, expect, it } from 'vitest';
import { confirmedSwapDestination, rememberedSelectionsForTurn } from './remembered-selection';

describe('remembered battle selection', () => {
  it('remembers the second cell of a confirmed swap', () => {
    expect(confirmedSwapDestination({ type: 'swap', a: 18, b: 19 })).toBe(19);
  });

  it('ignores ultimate moves', () => {
    expect(confirmedSwapDestination({ type: 'ult', skill: 'myriad-swords' })).toBeNull();
  });

  it('shows only the current PvP player remembered cell', () => {
    const activeTurn = {
      inGame: true,
      myTurn: true,
      busy: false,
      over: false,
      roomPregame: false,
      mode: 'pvp' as const,
    };
    expect(rememberedSelectionsForTurn(19, 31, activeTurn)).toEqual({ mine: 19, foe: null });
    expect(rememberedSelectionsForTurn(19, 31, { ...activeTurn, myTurn: false })).toEqual({
      mine: null,
      foe: 31,
    });
  });

  it('does not persist the bot selector between bot moves', () => {
    const botTurn = {
      inGame: true,
      myTurn: false,
      busy: false,
      over: false,
      roomPregame: false,
      mode: 'bot' as const,
    };
    expect(rememberedSelectionsForTurn(19, 31, botTurn)).toEqual({ mine: null, foe: null });
  });

  it('hides both remembered cells outside an idle turn', () => {
    const activeTurn = {
      inGame: true,
      myTurn: true,
      busy: false,
      over: false,
      roomPregame: false,
      mode: 'pvp' as const,
    };

    for (const blocked of [
      { ...activeTurn, inGame: false },
      { ...activeTurn, busy: true },
      { ...activeTurn, over: true },
      { ...activeTurn, roomPregame: true },
    ]) {
      expect(rememberedSelectionsForTurn(19, 31, blocked)).toEqual({ mine: null, foe: null });
    }
  });
});
