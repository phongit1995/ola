import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { MAX_SAVED_ACCOUNTS } from '../constants/storage';
import { encodeSecret } from '../lib/secret';
import { sharedPersistStorage } from '../platform/persistStorage';
import type {
  SavedAccount,
  SavedAccountsState,
} from '../types/client/savedAccount.type';

export { MAX_SAVED_ACCOUNTS } from '../constants/storage';
export type { SavedAccount } from '../types/client/savedAccount.type';

function byMostRecent(a: SavedAccount, b: SavedAccount): number {
  return b.lastAccessTime - a.lastAccessTime;
}

export const useSavedAccountsStore = create<SavedAccountsState>()(
  persist(
    (set) => ({
      accounts: [],
      saveAccount: (username, password, avatar) =>
        set((state) => {
          const others = state.accounts.filter((item) => item.username !== username);
          const updated: SavedAccount = {
            username,
            secret: encodeSecret(password),
            avatar,
            lastAccessTime: Date.now(),
          };
          return {
            accounts: [updated, ...others].sort(byMostRecent).slice(0, MAX_SAVED_ACCOUNTS),
          };
        }),
      removeAccount: (username) =>
        set((state) => ({
          accounts: state.accounts.filter((item) => item.username !== username),
        })),
    }),
    {
      name: 'ola.savedAccounts',
      version: 2,
      storage: sharedPersistStorage<SavedAccountsState>(),
      migrate: (persisted, version) => {
        if (version >= 2) {
          return persisted as SavedAccountsState;
        }
        if (version === 1) {
          const state = persisted as SavedAccountsState;
          return {
            ...state,
            accounts: [...(state.accounts ?? [])].sort(byMostRecent).slice(0, MAX_SAVED_ACCOUNTS),
          };
        }
        const legacy = persisted as { accounts?: Array<Record<string, unknown>> } | undefined;
        const accounts: SavedAccount[] = (legacy?.accounts ?? [])
          .filter((item) => typeof item.username === 'string')
          .map((item) => ({
            username: item.username as string,
            secret:
              typeof item.password === 'string'
                ? encodeSecret(item.password)
                : typeof item.secret === 'string'
                  ? item.secret
                  : '',
            lastAccessTime: typeof item.lastAccessTime === 'number' ? item.lastAccessTime : 0,
          }));
        return {
          accounts: accounts.sort(byMostRecent).slice(0, MAX_SAVED_ACCOUNTS),
        } as SavedAccountsState;
      },
    }
  )
);
