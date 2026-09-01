import { describe, expect, it } from 'vitest';
import { calculateHeartVacuumHeal } from './heart-vacuum';

describe('calculateHeartVacuumHeal', () => {
  it('heals 5 HP per normal Heart', () => {
    expect(calculateHeartVacuumHeal(100, 3, 0)).toBe(15);
  });

  it('heals 10 HP per Greater Heart', () => {
    expect(calculateHeartVacuumHeal(100, 0, 2)).toBe(20);
  });

  it('does not cap the total, but still respects MAX_HP', () => {
    expect(calculateHeartVacuumHeal(100, 20, 5)).toBe(100);
  });

  it('does not heal beyond maximum HP', () => {
    expect(calculateHeartVacuumHeal(198, 5, 1)).toBe(2);
  });
});
