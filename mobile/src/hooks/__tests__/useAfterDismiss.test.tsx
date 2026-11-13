import { act, create, type ReactTestRenderer } from 'react-test-renderer';
import { fitImageInBox } from '@ola/shared/lib';
import { useTimedHighlight } from '@ola/shared/stores/useTimedHighlight';
import { useAfterDismiss } from '../useAfterDismiss';

let followUp: ReturnType<typeof useAfterDismiss>;
let timed: ReturnType<typeof useTimedHighlight>;

function Harness() {
  followUp = useAfterDismiss();
  timed = useTimedHighlight(100);
  return null;
}

describe('useAfterDismiss', () => {
  let renderer: ReactTestRenderer | null = null;

  beforeEach(() => {
    jest.useFakeTimers();
    act(() => {
      renderer = create(<Harness />);
    });
  });

  afterEach(() => {
    act(() => renderer?.unmount());
    jest.useRealTimers();
  });

  it('runs the scheduled action once on dismiss', () => {
    const action = jest.fn();
    followUp.schedule(action);
    followUp.onDismiss();
    followUp.onDismiss();
    expect(action).toHaveBeenCalledTimes(1);
  });

  it('keeps only the latest scheduled action and can cancel it', () => {
    const first = jest.fn();
    const second = jest.fn();
    followUp.schedule(first);
    followUp.schedule(second);
    followUp.onDismiss();
    expect(first).not.toHaveBeenCalled();
    expect(second).toHaveBeenCalledTimes(1);

    const cancelled = jest.fn();
    followUp.schedule(cancelled);
    followUp.cancel();
    followUp.onDismiss();
    expect(cancelled).not.toHaveBeenCalled();
  });

  it('highlights an id for the given duration', () => {
    act(() => timed.highlight('m1'));
    expect(timed.highlightedId).toBe('m1');
    act(() => jest.advanceTimersByTime(60));
    act(() => timed.highlight('m2'));
    act(() => jest.advanceTimersByTime(60));
    expect(timed.highlightedId).toBe('m2');
    act(() => jest.advanceTimersByTime(40));
    expect(timed.highlightedId).toBeNull();
  });
});

describe('fitImageInBox', () => {
  const box = { width: 200, height: 100 };
  const fallback = { width: 50, height: 50 };

  it('falls back when ratio is missing', () => {
    expect(fitImageInBox(null, box, fallback)).toBe(fallback);
    expect(fitImageInBox(0, box, fallback)).toBe(fallback);
  });

  it('fits wide and tall images', () => {
    expect(fitImageInBox(4, box, fallback)).toEqual({ width: 200, height: 50 });
    expect(fitImageInBox(1, box, fallback)).toEqual({ width: 100, height: 100 });
  });
});
