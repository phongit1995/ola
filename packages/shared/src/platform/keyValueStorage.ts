import type { KeyValueStorage } from '../types/platform.type';
import {
  getCurrentStorage,
  setCurrentStorage,
} from './platformRuntime.state';

export type { KeyValueStorage } from '../types/platform.type';

export function configureKeyValueStorage(storage: KeyValueStorage): void {
  setCurrentStorage(storage);
}

export function getKeyValueStorage(): KeyValueStorage {
  const current = getCurrentStorage();
  if (current != null) return current;
  const globalStorage = (globalThis as { localStorage?: KeyValueStorage }).localStorage;
  if (globalStorage != null) return globalStorage;
  throw new Error(
    'Key-value storage is not configured. Call configureKeyValueStorage() at app bootstrap.'
  );
}
