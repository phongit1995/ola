import { describe, expect, it } from 'vitest';
import { flightKeyframes, SEAT_FLIGHT_SCALE } from './cardFlight';

const target = { x: 200, bottom: 400, width: 52, height: 75 };

function startOf(frames: Keyframe[]): { dx: number; dy: number; scale: number; rotate: number } {
  const match = /translate\((-?[\d.]+)px, (-?[\d.]+)px\) scale\(([\d.]+)\) rotate\((-?[\d.]+)deg\)/.exec(String(frames[0].transform));
  if (!match) throw new Error('missing start transform');
  return { dx: Number(match[1]), dy: Number(match[2]), scale: Number(match[3]), rotate: Number(match[4]) };
}

describe('flightKeyframes', () => {
  it('starts a seat flight small, centered on the avatar and transparent', () => {
    const frames = flightKeyframes({ x: 60, y: 300, width: 0 }, target, 4);
    const start = startOf(frames);
    expect(start.scale).toBe(SEAT_FLIGHT_SCALE);
    expect(target.x + start.dx).toBe(60);
    expect(target.bottom + start.dy - (start.scale * target.height) / 2).toBeCloseTo(300);
    expect(frames[0].opacity).toBe(0);
    expect(start.rotate).toBe(-26);
  });

  it('starts a hand flight at the hand card size, fully visible and upright', () => {
    const frames = flightKeyframes({ x: 120, y: 700, width: 65 }, target, -4);
    const start = startOf(frames);
    expect(start.scale).toBeCloseTo(65 / 52);
    expect(target.bottom + start.dy - (start.scale * target.height) / 2).toBeCloseTo(700);
    expect(frames[0].opacity).toBe(1);
    expect(start.rotate).toBe(0);
  });

  it('lands on the final trick rotation', () => {
    const frames = flightKeyframes({ x: 60, y: 300, width: 0 }, target, 4);
    expect(frames[frames.length - 1].transform).toBe('translate(0px, 0px) scale(1) rotate(4deg)');
  });
});
