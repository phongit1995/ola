import assert from 'node:assert/strict';
import { FarmGame } from '../../assets/farm/scripts/core/FarmGame';
import { progression, xpToNext } from '../../assets/farm/scripts/core/Progression';
import type { BuildXP } from '../../assets/farm/scripts/core/types/EconomyTypes';
import type { FarmState } from '../../assets/farm/scripts/core/types/StateTypes';

export function xpForLevel(game: FarmGame, level: number): number {
  return Array.from({ length: level - 1 }, (_, index) =>
    xpToNext(index + 1, game.catalog.economy?.experience.curve)
  ).reduce((sum, xp) => sum + xp, 0);
}

/** Applies a construction purchase's one-time XP to an expected state, with the diamonds of any new level it reaches. */
export function addBuildXP(game: FarmGame, state: FarmState, kind: keyof BuildXP): void {
  const experience = game.catalog.economy!.experience,
    level = (xp: number) => progression(xp, experience.curve).level,
    before = level(state.xp);
  state.xp += experience.buildXP[kind];
  const after = level(state.xp),
    paid = Math.max(state.rewardedLevel ?? 0, before);
  if (after > paid && experience.levelUpDiamonds > 0) {
    state.diamonds += (after - paid) * experience.levelUpDiamonds;
    state.rewardedLevel = after;
  }
}

/** Explicit owned-building fixture for production, livestock and historical-save tests.
 * Fresh games deliberately own no production buildings. Buy the former starters
 * through core actions, then restore the test's wallet and XP independently of
 * their construction costs. Catalog defaults are never replaced by this helper.
 */
export function establishFarm(game: FarmGame): FarmGame {
  const { coins, xp } = game.state;
  game.state.coins = 1000000;
  game.state.xp = 100000000;
  for (const type of [1, 4, 5]) {
    if (!game.state.machines.some(machine => machine.type === type)) {
      assert.equal(game.buyMachine(type).error, undefined, `fixture machine ${type}`);
    }
  }
  for (const id of [12, 13]) {
    if (!game.residentPlot(id)!.residents) {
      assert.equal(game.buyPen(id).error, undefined, `fixture pen ${id}`);
    }
  }
  game.state.coins = coins;
  game.state.xp = xp;
  return game;
}
