import { describe, expect, it } from 'vitest';
import { battleActionAvailability, battleActionLayout } from './action-layout';

describe('War God battle action layout', () => {
  it('shows replay for bot matches', () => {
    expect(battleActionLayout('bot')).toEqual({
      restartVisible: true,
      restartX: 0,
      forfeitX: 152,
      exitX: 304,
    });
  });

  it('hides the unsupported in-match replay action and centers PvP actions', () => {
    const layout = battleActionLayout('pvp');
    expect(layout).toEqual({
      restartVisible: false,
      restartX: 0,
      forfeitX: 76,
      exitX: 228,
    });
    expect((layout.forfeitX + layout.exitX + 140) / 2).toBe(222);
  });

  it('keeps PvP forfeit and exit enabled while either player action is animating', () => {
    expect(battleActionAvailability('pvp', true, false)).toEqual({
      restartEnabled: false,
      forfeitEnabled: true,
      exitEnabled: true,
    });
  });

  it('only disables PvP forfeit after the match is over', () => {
    expect(battleActionAvailability('pvp', true, true)).toEqual({
      restartEnabled: false,
      forfeitEnabled: false,
      exitEnabled: true,
    });
  });

  it('preserves busy-state guards for bot matches', () => {
    expect(battleActionAvailability('bot', true, false)).toEqual({
      restartEnabled: false,
      forfeitEnabled: false,
      exitEnabled: false,
    });
  });
});
