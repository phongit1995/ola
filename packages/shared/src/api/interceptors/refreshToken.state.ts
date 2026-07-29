import type { AxiosInstance } from 'axios';

let unauthorizedHandler: (() => void) | null = null;
let refreshHttpInstance: AxiosInstance | null = null;
let pendingRefresh: Promise<string> | null = null;

export function setUnauthorizedHandler(handler: (() => void) | null): void {
  unauthorizedHandler = handler;
}

export function notifyUnauthorized(): void {
  unauthorizedHandler?.();
}

export function setRefreshHttpInstance(instance: AxiosInstance): void {
  refreshHttpInstance = instance;
}

export function getRefreshHttpInstance(): AxiosInstance | null {
  return refreshHttpInstance;
}

export function getOrCreatePendingRefresh(
  createRefresh: () => Promise<string>
): Promise<string> {
  if (pendingRefresh == null) {
    pendingRefresh = createRefresh().finally(() => {
      pendingRefresh = null;
    });
  }
  return pendingRefresh;
}
