import type { Megaphone, MegaphoneAppConfig, MegaphoneConfig, SendMegaphoneResult } from '../api/megaphone.type';

export interface MegaphoneConfigState {
  config: MegaphoneAppConfig | null;
  load: () => Promise<void>;
}

export interface MegaphoneState {
  current: Megaphone | null;
  removedIds: Record<string, true>;
  seenIds: Record<string, number>;
  play: (megaphone: Megaphone) => void;
  stop: (id: string) => void;
  markSeen: (id: string) => void;
  remove: (id: string) => void;
  reset: () => void;
}

export type PersistedMegaphoneState = Pick<MegaphoneState, 'seenIds'>;

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
  prepend: (megaphone: Megaphone) => void;
}
