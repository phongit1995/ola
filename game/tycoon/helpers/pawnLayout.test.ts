import { describe, expect, it } from 'vitest';
import { tileCenter, tileRect } from './boardGeometry';
import { pawnLayout } from './pawnLayout';

describe('tileRect', () => {
  it('đặt 4 góc theo chiều đi của bàn', () => {
    expect(tileRect(0)).toMatchObject({ x: 0, y: 86.4, side: 'corner' });
    expect(tileRect(8)).toMatchObject({ x: 0, y: 0, side: 'corner' });
    expect(tileRect(16)).toMatchObject({ x: 86.4, y: 0, side: 'corner' });
    expect(tileRect(24)).toMatchObject({ x: 86.4, y: 86.4, side: 'corner' });
  });
});

describe('pawnLayout', () => {
  const noneOut = [false, false, false, false];

  it('quân đứng một mình nằm đúng giữa ô', () => {
    const spots = pawnLayout([3, 5, 7, 9], noneOut, 0);
    expect(spots[1]).toMatchObject(tileCenter(5));
  });

  it('nhiều quân cùng ô thì đè lên nhau quanh tâm ô, người tới lượt nằm trên cùng', () => {
    const spots = pawnLayout([20, 20, 20, 20], noneOut, 2);
    const xs = spots.map((spot) => spot!.x);
    expect(Math.max(...xs) - Math.min(...xs)).toBeLessThan(6.4);
    expect(xs.reduce((sum, x) => sum + x, 0) / 4).toBeCloseTo(tileCenter(20).x);
    expect(spots[2]!.z).toBe(Math.max(...spots.map((spot) => spot!.z)));
  });

  it('bỏ qua quân đã phá sản', () => {
    const spots = pawnLayout([4, 4], [true, false], 1);
    expect(spots[0]).toBeUndefined();
    expect(spots[1]).toMatchObject(tileCenter(4));
  });
});
