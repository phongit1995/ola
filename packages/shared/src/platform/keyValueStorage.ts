export interface KeyValueStorage {
  getItem(key: string): string | null;
  setItem(key: string, value: string): void;
  removeItem(key: string): void;
}

let current: KeyValueStorage | null = null;

export function configureKeyValueStorage(storage: KeyValueStorage): void {
  current = storage;
}

export function getKeyValueStorage(): KeyValueStorage {
  if (current != null) return current;
  const globalStorage = (globalThis as { localStorage?: KeyValueStorage }).localStorage;
  if (globalStorage != null) return globalStorage;
  throw new Error(
    'Key-value storage is not configured. Call configureKeyValueStorage() at app bootstrap.'
  );
}
