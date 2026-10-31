import { describe, expect, it } from 'vitest';
import { handArc, handArcDrop, handLayout, trickLayout } from './cardLayout';

describe('handLayout', () => {
  it.each([320, 360, 390, 430, 520])('keeps a full hand inside a %ipx row with every corner readable', (width) => {
    const layout = handLayout(13, width);
    const step = layout.lefts[1] - layout.lefts[0];
    expect(layout.lefts[0]).toBeGreaterThanOrEqual(7);
    expect(layout.lefts[12] + layout.cardWidth).toBeLessThanOrEqual(width - 7);
    expect(step / layout.cardWidth).toBeGreaterThanOrEqual(0.4);
  });

  it('grows the cards on wider screens', () => {
    expect(handLayout(13, 430).cardWidth).toBeGreaterThan(handLayout(13, 320).cardWidth);
    expect(handLayout(13, 520).cardWidth).toBeLessThanOrEqual(76);
  });

  it('centers a short hand without spreading the cards apart', () => {
    const layout = handLayout(3, 390);
    const step = layout.lefts[1] - layout.lefts[0];
    expect(step).toBeLessThanOrEqual(layout.cardWidth * 0.62 + 0.01);
    const middle = layout.lefts[1] + layout.cardWidth / 2;
    expect(Math.abs(middle - 195)).toBeLessThan(1);
  });
});

describe('handArc', () => {
  it('fans a full hand symmetrically with the edges lowest', () => {
    const first = handArc(0, 13, 100);
    const middle = handArc(6, 13, 100);
    const last = handArc(12, 13, 100);
    expect(first.angle).toBe(-4);
    expect(last.angle).toBe(4);
    expect(middle).toEqual({ angle: 0, drop: 0 });
    expect(first.drop).toBe(handArcDrop(100));
    expect(last.drop).toBe(first.drop);
  });

  it('keeps a short hand almost flat', () => {
    expect(Math.abs(handArc(0, 3, 100).angle)).toBeLessThan(1);
  });

  it.each([320, 390, 430])('keeps the tilted edge cards inside a %ipx row', (width) => {
    const layout = handLayout(13, width);
    const tilt = layout.cardHeight * Math.sin((4 * Math.PI) / 180);
    expect(layout.lefts[0] - tilt).toBeGreaterThanOrEqual(0);
    expect(layout.lefts[12] + layout.cardWidth + tilt).toBeLessThanOrEqual(width);
  });
});

describe('trickLayout', () => {
  it('uses smaller cards in a narrow table center', () => {
    expect(trickLayout(2, 140).cardWidth).toBeLessThan(trickLayout(2, 252).cardWidth);
  });

  it('keeps a long straight inside the table center', () => {
    const layout = trickLayout(12, 160);
    expect(layout.lefts[0]).toBeGreaterThanOrEqual(0);
    expect(layout.lefts[11] + layout.cardWidth).toBeLessThanOrEqual(160.01);
  });
});
