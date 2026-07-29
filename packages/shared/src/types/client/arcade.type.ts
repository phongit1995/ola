import type { MiniGame } from '../api/miniGame.type';

export interface ArcadeState {
  games: MiniGame[];
  loaded: boolean;
  fetchGames: () => Promise<void>;
}

export interface ArcadeOverlayState {
  active: MiniGame | null;
  minimized: boolean;
  notify: boolean;
  open: (game: MiniGame) => boolean;
  minimize: () => void;
  restore: () => void;
  setNotify: (value: boolean) => void;
  close: () => void;
}
