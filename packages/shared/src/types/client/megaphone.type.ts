import type { Megaphone, MegaphoneConfig, SendMegaphoneResult } from '../api/megaphone.type';

export interface MegaphoneState {
  items: Megaphone[];
  removedIds: Record<string, true>;
  clockOffset: number;
  synced: boolean;
  receive: (megaphone: Megaphone, serverTime?: string) => void;
  remove: (id: string) => void;
  sync: () => Promise<void>;
  reset: () => void;
}

export type MegaphoneComposerStep = 'compose' | 'confirm';

export interface MegaphoneComposerOptions {
  onClose: () => void;
  onSent?: (result: SendMegaphoneResult) => void;
}

export interface MegaphoneComposer {
  config: MegaphoneConfig;
  loaded: boolean;
  loadError: boolean;
  content: string;
  normalizedContent: string;
  length: number;
  remaining: number;
  tooLong: boolean;
  balance: number;
  affordable: boolean;
  cooldownLeft: number;
  dailyLeft: number;
  waitMinutes: number;
  step: MegaphoneComposerStep;
  submitting: boolean;
  canSend: boolean;
  changeContent: (value: string) => void;
  requestSend: () => void;
  confirmSend: () => void;
  cancelConfirm: () => void;
}

export interface MegaphoneHistory {
  items: Megaphone[];
  done: boolean;
  loading: boolean;
  loadMore: () => void;
  refresh: () => void;
}
