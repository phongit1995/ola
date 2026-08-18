import { describe, expect, it } from 'vitest';
import { applyAuthoritativeEffects, applyTileEffects, createFighter } from './battle';
import { emptyCounts } from './core';

describe('cascade tile-effect scaling', () => {
  it.each([
    { level: 0, damage: 21, heal: 15, mana: 21, armor: 15, fury: 30 },
    { level: 1, damage: 23, heal: 17, mana: 23, armor: 17, fury: 33 },
    { level: 2, damage: 25, heal: 18, mana: 25, armor: 18, fury: 36 },
    { level: 3, damage: 27, heal: 20, mana: 27, armor: 20, fury: 39 },
    { level: 4, damage: 27, heal: 20, mana: 27, armor: 20, fury: 39 },
  ])('scales damage, healing, mana, armor and fury at level $level', (expected) => {
    const attacker = { ...createFighter(), hp: 100 };
    const defender = createFighter();
    const counts = Object.assign(emptyCounts(), {
      sword: 3,
      heart: 3,
      water: 3,
      shield: 3,
      peach: 3,
    });

    const effects = applyTileEffects(attacker, defender, counts, expected.level);

    expect(effects).toMatchObject({
      damage: expected.damage,
      heal: expected.heal,
      mana: expected.mana,
      armor: expected.armor,
      fury: expected.fury,
    });
  });

  it('does not scale fixed reflect damage', () => {
    const attacker = createFighter();
    const defender = { ...createFighter(), armor: 30 };
    const counts = Object.assign(emptyCounts(), { sword: 3 });

    const effects = applyTileEffects(attacker, defender, counts, 3);

    expect(effects.reflect).toBe(2);
  });

  it('keeps full-fury sword damage doubled through the entire cascade chain', () => {
    const attacker = { ...createFighter(), fury: 100 };
    const defender = createFighter();
    const furyChain = { active: false };
    const counts = Object.assign(emptyCounts(), { sword: 3 });

    const firstWave = applyTileEffects(attacker, defender, counts, 0, furyChain);
    const firstCascade = applyTileEffects(attacker, defender, counts, 1, furyChain);
    const secondCascade = applyTileEffects(attacker, defender, counts, 2, furyChain);

    expect(firstWave).toMatchObject({ damage: 42, furied: true });
    expect(firstCascade.damage).toBe(46);
    expect(secondCascade.damage).toBe(50);
    expect(attacker.fury).toBe(0);
    expect(defender.hp).toBe(62);
  });

  it('replays Fury consumption before applying same-wave peach recharge', () => {
    const attacker = { ...createFighter(), fury: 100 };
    const defender = createFighter();

    applyAuthoritativeEffects(attacker, defender, {
      damage: 28,
      heal: 0,
      mana: 0,
      armor: 0,
      fury: 10,
      furied: true,
    });

    expect(attacker.fury).toBe(10);
    expect(defender.hp).toBe(172);
  });
});
