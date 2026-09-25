import type { Label, Node } from 'cc';

export interface BubbleActions {
  harvest(id: number): void;
  unlock(id: number): void;
  finish(id: number): void;
  /** Not in Golden Island, but our farm refunds part of the seed; without the footer this is its only entry. */
  cancel(id: number): void;
}

export type BubbleKind = 'none' | 'locked' | 'ready' | 'growing';

export interface BubbleView {
  root: Node;
  kind: BubbleKind;
  key: string;
  time: Label | null;
  price: Label | null;
}
