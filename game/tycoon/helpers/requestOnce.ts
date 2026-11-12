export const REQUEST_TIMEOUT_MS = 10_000;

export type RequestOnceResult<T> = { status: 'reply'; data: T } | { status: 'timeout' } | { status: 'stale' };

export interface RequestOnceOptions<T> {
  subscribe(handler: (data: T) => void): () => void;
  send(): void;
  matches?(data: T): boolean;
  isCurrent?(): boolean;
  timeoutMs?: number;
}

export function createRequestGuard(): () => () => boolean {
  let current = 0;
  return () => {
    const seq = ++current;
    return () => seq === current;
  };
}

export function requestOnce<T>({ subscribe, send, matches, isCurrent, timeoutMs = REQUEST_TIMEOUT_MS }: RequestOnceOptions<T>): Promise<RequestOnceResult<T>> {
  return new Promise((resolve) => {
    let done = false;
    let off: (() => void) | null = null;
    const finish = (result: RequestOnceResult<T>) => {
      done = true;
      clearTimeout(timer);
      off?.();
      off = null;
      resolve(isCurrent && !isCurrent() ? { status: 'stale' } : result);
    };
    const timer = setTimeout(() => finish({ status: 'timeout' }), timeoutMs);
    const unsubscribe = subscribe((data) => {
      if (done || (matches && !matches(data))) return;
      finish({ status: 'reply', data });
    });
    if (done) {
      unsubscribe();
      return;
    }
    off = unsubscribe;
    try {
      send();
    } catch {
      finish({ status: 'timeout' });
    }
  });
}
