import { createJSONStorage } from 'zustand/middleware';
import { getKeyValueStorage } from './keyValueStorage';

export function sharedPersistStorage<T>() {
  return createJSONStorage<T>(() => ({
    getItem: (name: string) => getKeyValueStorage().getItem(name),
    setItem: (name: string, value: string) => getKeyValueStorage().setItem(name, value),
    removeItem: (name: string) => getKeyValueStorage().removeItem(name),
  }));
}
