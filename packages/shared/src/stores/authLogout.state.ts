const logoutListeners = new Set<() => void>();

export function registerOnLogout(listener: () => void): () => void {
  logoutListeners.add(listener);
  return () => logoutListeners.delete(listener);
}

export function notifyLogoutListeners(): void {
  logoutListeners.forEach((listener) => listener());
}
