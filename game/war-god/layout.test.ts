import { describe, expect, it, vi } from 'vitest';
import { MIN_RENDER_RESOLUTION, renderResolution, watchDevicePixelRatio } from './layout';

describe('renderResolution', () => {
  it('supersamples low-DPR desktop displays at 2x', () => {
    expect(renderResolution(1)).toBe(2);
    expect(renderResolution(1.25)).toBe(2);
    expect(renderResolution(1.5)).toBe(2);
  });

  it('preserves native density at 2x and above', () => {
    expect(renderResolution(2)).toBe(2);
    expect(renderResolution(3)).toBe(3);
  });

  it('falls back safely for invalid DPR values', () => {
    expect(renderResolution(undefined)).toBe(MIN_RENDER_RESOLUTION);
    expect(renderResolution(0)).toBe(MIN_RENDER_RESOLUTION);
    expect(renderResolution(Number.NaN)).toBe(MIN_RENDER_RESOLUTION);
  });
});

describe('watchDevicePixelRatio', () => {
  it('detects a DPR-only change even when the viewport emits no resize event', () => {
    let poll: (() => void) | null = null;
    const targetState = {
      devicePixelRatio: 1,
      setInterval: vi.fn((next: () => void) => {
        poll = next;
        return 7;
      }),
      clearInterval: vi.fn(),
    };
    const target = targetState as unknown as Pick<
      Window,
      'devicePixelRatio' | 'setInterval' | 'clearInterval'
    >;
    const onChange = vi.fn();

    const dispose = watchDevicePixelRatio(target, onChange);
    expect(poll).not.toBeNull();
    (poll as unknown as () => void)();
    expect(onChange).not.toHaveBeenCalled();

    targetState.devicePixelRatio = 1.5;
    (poll as unknown as () => void)();
    expect(onChange).toHaveBeenCalledOnce();

    dispose();
    expect(targetState.clearInterval).toHaveBeenCalledWith(7);
  });
});
