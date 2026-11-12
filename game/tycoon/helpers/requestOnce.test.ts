import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';
import { REQUEST_TIMEOUT_MS, createRequestGuard, requestOnce } from './requestOnce';

interface Reply {
  tab: string;
  value: number;
}

function channel() {
  const handlers = new Set<(data: Reply) => void>();
  const off = vi.fn();
  return {
    handlers,
    off,
    subscribe(handler: (data: Reply) => void) {
      handlers.add(handler);
      return () => {
        off();
        handlers.delete(handler);
      };
    },
    emit(data: Reply) {
      [...handlers].forEach((handler) => handler(data));
    },
  };
}

describe('requestOnce', () => {
  beforeEach(() => {
    vi.useFakeTimers();
  });

  afterEach(() => {
    vi.useRealTimers();
  });

  it('subscribes before sending and resolves with the first reply', async () => {
    const ch = channel();
    const send = vi.fn(() => expect(ch.handlers.size).toBe(1));
    const promise = requestOnce({ subscribe: ch.subscribe, send });
    expect(send).toHaveBeenCalledTimes(1);
    ch.emit({ tab: 'day', value: 1 });
    ch.emit({ tab: 'day', value: 2 });
    await expect(promise).resolves.toEqual({ status: 'reply', data: { tab: 'day', value: 1 } });
    expect(ch.off).toHaveBeenCalledTimes(1);
    expect(ch.handlers.size).toBe(0);
  });

  it('clears the timeout after a reply', async () => {
    const ch = channel();
    const promise = requestOnce({ subscribe: ch.subscribe, send: () => {} });
    ch.emit({ tab: 'day', value: 1 });
    await promise;
    expect(vi.getTimerCount()).toBe(0);
  });

  it('times out after the shared timeout and unsubscribes', async () => {
    const ch = channel();
    const promise = requestOnce({ subscribe: ch.subscribe, send: () => {} });
    vi.advanceTimersByTime(REQUEST_TIMEOUT_MS - 1);
    expect(ch.off).not.toHaveBeenCalled();
    vi.advanceTimersByTime(1);
    await expect(promise).resolves.toEqual({ status: 'timeout' });
    expect(ch.off).toHaveBeenCalledTimes(1);
    expect(ch.handlers.size).toBe(0);
    ch.emit({ tab: 'day', value: 1 });
    expect(ch.off).toHaveBeenCalledTimes(1);
  });

  it('honours a custom timeout', async () => {
    const ch = channel();
    const promise = requestOnce({ subscribe: ch.subscribe, send: () => {}, timeoutMs: 50 });
    vi.advanceTimersByTime(50);
    await expect(promise).resolves.toEqual({ status: 'timeout' });
  });

  it('ignores replies the matcher rejects', async () => {
    const ch = channel();
    const promise = requestOnce({ subscribe: ch.subscribe, send: () => {}, matches: (data) => data.tab === 'week' });
    ch.emit({ tab: 'day', value: 1 });
    expect(ch.off).not.toHaveBeenCalled();
    ch.emit({ tab: 'week', value: 2 });
    await expect(promise).resolves.toEqual({ status: 'reply', data: { tab: 'week', value: 2 } });
    expect(ch.off).toHaveBeenCalledTimes(1);
  });

  it('times out when only non-matching replies arrive', async () => {
    const ch = channel();
    const promise = requestOnce({ subscribe: ch.subscribe, send: () => {}, matches: () => false });
    ch.emit({ tab: 'day', value: 1 });
    vi.advanceTimersByTime(REQUEST_TIMEOUT_MS);
    await expect(promise).resolves.toEqual({ status: 'timeout' });
    expect(ch.off).toHaveBeenCalledTimes(1);
  });

  it('reports a stale reply when a newer request has started', async () => {
    const ch = channel();
    const next = createRequestGuard();
    const first = requestOnce({ subscribe: ch.subscribe, send: () => {}, isCurrent: next() });
    const second = requestOnce({ subscribe: ch.subscribe, send: () => {}, isCurrent: next() });
    ch.emit({ tab: 'day', value: 1 });
    await expect(first).resolves.toEqual({ status: 'stale' });
    await expect(second).resolves.toEqual({ status: 'reply', data: { tab: 'day', value: 1 } });
    expect(ch.off).toHaveBeenCalledTimes(2);
  });

  it('reports a stale timeout when a newer request has started', async () => {
    const ch = channel();
    const next = createRequestGuard();
    const promise = requestOnce({ subscribe: ch.subscribe, send: () => {}, isCurrent: next() });
    next();
    vi.advanceTimersByTime(REQUEST_TIMEOUT_MS);
    await expect(promise).resolves.toEqual({ status: 'stale' });
    expect(ch.off).toHaveBeenCalledTimes(1);
  });

  it('unsubscribes when the reply arrives synchronously during subscribe', async () => {
    const off = vi.fn();
    const send = vi.fn();
    const promise = requestOnce<number>({
      subscribe(handler) {
        handler(7);
        return off;
      },
      send,
    });
    await expect(promise).resolves.toEqual({ status: 'reply', data: 7 });
    expect(off).toHaveBeenCalledTimes(1);
    expect(send).not.toHaveBeenCalled();
    expect(vi.getTimerCount()).toBe(0);
  });
});

describe('createRequestGuard', () => {
  it('keeps only the latest request current', () => {
    const next = createRequestGuard();
    const a = next();
    expect(a()).toBe(true);
    const b = next();
    expect(a()).toBe(false);
    expect(b()).toBe(true);
  });

  it('keeps separate guards independent', () => {
    const day = createRequestGuard();
    const week = createRequestGuard();
    const a = day();
    week();
    expect(a()).toBe(true);
  });

  it('cleans up and fails like a timeout when send throws', async () => {
    let subscribed = 0;
    const result = await requestOnce<number>({
      subscribe: () => {
        subscribed += 1;
        return () => {
          subscribed -= 1;
        };
      },
      send: () => {
        throw new Error('socket gone');
      },
    });
    expect(result).toEqual({ status: 'timeout' });
    expect(subscribed).toBe(0);
  });
});
