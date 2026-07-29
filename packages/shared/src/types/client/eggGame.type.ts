import type { EggDrawResult, EggPack } from '../api/egg.type';

export interface Nest {
  x: number;
  y: number;
}

export interface SmashTail {
  frames: string[];
  revealAt: number;
}

export type EggPacksStatus = 'idle' | 'loading' | 'ready' | 'error';

export interface EggGameState {
  ken: number;
  totalWin: number;
  muted: boolean;
  packs: EggPack[];
  packsStatus: EggPacksStatus;
  drawing: boolean;
  smashing: boolean;
  suppressKenSync: boolean;
  winReward: EggDrawResult | null;
  loadPacks: () => Promise<void>;
  draw: (packId: string, idempotencyKey: string) => Promise<EggDrawResult | null>;
  applyResult: (result: EggDrawResult) => void;
  syncKen: (ken: number) => void;
  beginSmash: () => void;
  endSmash: () => void;
  showWin: (result: EggDrawResult) => void;
  closeWin: () => void;
  toggleMute: () => void;
}
