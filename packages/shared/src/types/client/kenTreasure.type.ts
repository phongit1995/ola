export type KenTreasurePhase = 'closed' | 'opening' | 'result';

export interface KenTreasureResult {
  isEmpty: boolean;
  kenAmount: number;
}

export interface KenTreasureChest {
  id: string;
  expiresAt: string;
  phase: KenTreasurePhase;
  result: KenTreasureResult | null;
}

export interface KenTreasureState {
  chests: Record<string, KenTreasureChest>;
  show: (payload: { id: string; expiresAt: string }) => void;
  open: (id: string) => Promise<void>;
  dismiss: (id: string) => void;
  reset: () => void;
}

export interface KenTreasurePositionState {
  x: number;
  y: number;
  setPosition: (x: number, y: number) => void;
}
