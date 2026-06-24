import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { encodeSecret } from '@lib';

export interface SavedAccount {
  username: string;
  secret: string;
  lastAccessTime: number;
}

interface SavedAccountsState {
  accounts: SavedAccount[];
  saveAccount: (username: string, password: string) => void;
  removeAccount: (username: string) => void;
}

function byMostRecent(a: SavedAccount, b: SavedAccount): number {
  return b.lastAccessTime - a.lastAccessTime;
}

export const useSavedAccountsStore = create<SavedAccountsState>()(
  persist(
    (set) => ({
      accounts: [],
      saveAccount: (username, password) =>
        set((state) => {
          const others = state.accounts.filter((item) => item.username !== username);
          const updated: SavedAccount = {
            username,
            secret: encodeSecret(password),
            lastAccessTime: Date.now(),
          };
          return { accounts: [updated, ...others].sort(byMostRecent) };
        }),
      removeAccount: (username) =>
        set((state) => ({
          accounts: state.accounts.filter((item) => item.username !== username),
        })),
    }),
    {
      name: 'ola.savedAccounts',
      version: 1,
      migrate: (persisted, version) => {
        if (version >= 1) {
          return persisted as SavedAccountsState;
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
        return { accounts } as SavedAccountsState;
      },
    }
  )
);
