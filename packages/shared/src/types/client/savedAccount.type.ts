export interface SavedAccount {
  username: string;
  secret: string;
  avatar?: string;
  lastAccessTime: number;
}

export interface SavedAccountsState {
  accounts: SavedAccount[];
  saveAccount: (username: string, password: string, avatar?: string) => void;
  removeAccount: (username: string) => void;
}
