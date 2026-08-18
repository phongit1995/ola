import { describe, expect, it } from 'vitest';
import {
  applyDamageThroughArmor,
  applyTileEffects,
  castUltimate,
  createFighter,
} from './battle';
import { emptyCounts } from './core';

describe('armor damage absorption', () => {
  it('absorbs normal, fire-sword and full-fury damage before HP', () => {
    const attacker = { ...createFighter(), hp: 100, fury: 100 };
    const defender = { ...createFighter(), hp: 100, armor: 30 };
    const counts = Object.assign(emptyCounts(), { sword: 3, fireSword: 1 });

    const effects = applyTileEffects(attacker, defender, counts);

    expect(effects).toMatchObject({
      damage: 20,
      armorDamage: 30,
      furied: true,
    });
    expect(attacker).toMatchObject({ hp: 100, fury: 0 });
    expect(defender).toMatchObject({ hp: 80, armor: 0 });
  });

  it('makes an ultimate consume defender armor without decaying attacker armor', () => {
    const attacker = { ...createFighter(), mp: 100, armor: 12 };
    const defender = { ...createFighter(), hp: 100, armor: 30 };

    expect(castUltimate(attacker, defender)).toEqual({ damage: 20, armorDamage: 30 });
    expect(attacker).toMatchObject({ mp: 0, armor: 12 });
    expect(defender).toMatchObject({ hp: 80, armor: 0 });
  });

  it('lets armor fully absorb fixed lightning ultimate damage', () => {
    const defender = { ...createFighter(), hp: 100, armor: 30 };

    expect(applyDamageThroughArmor(defender, 20)).toEqual({ damage: 0, armorDamage: 20 });
    expect(defender).toMatchObject({ hp: 100, armor: 10 });
  });
});
