import type {
  Gift,
  GiftHistoryDirection,
  GiftHistoryItem,
  GiftLeaderboardPeriod,
  GiftLeaderboardResult,
  GiftLeaderboardType,
  GiftSettings,
  GiftSource,
  SendGiftResult,
} from '../api/gift.type';

export interface GiftCatalogState {
  items: Gift[];
  settings: GiftSettings;
  loaded: boolean;
  loading: boolean;
  error: boolean;
  load: (force?: boolean) => Promise<void>;
  reset: () => void;
}

export interface GiftAnimationItem {
  id: string;
  imageUrl: string;
  name: string;
  quantity: number;
  charmPoints: number;
  caption?: string;
  seed?: number;
}

export interface GiftAnimationState {
  queue: GiftAnimationItem[];
  seen: Set<string>;
  play: (item: GiftAnimationItem) => void;
  next: () => void;
}

export interface GiftPickerOptions {
  receiverId: string;
  source: GiftSource;
  onClose: () => void;
  onSent?: (result: SendGiftResult) => void;
}

export type GiftPickerStep = 'pick' | 'confirm';

export interface GiftPicker {
  gifts: Gift[];
  settings: GiftSettings;
  loaded: boolean;
  loadError: boolean;
  ready: boolean;
  balance: number;
  selected: Gift | null;
  selectedName: string;
  quantity: number;
  note: string;
  total: number;
  affordable: boolean;
  step: GiftPickerStep;
  submitting: boolean;
  canSend: boolean;
  selectGift: (giftId: string) => void;
  selectQuantity: (quantity: number) => void;
  changeNote: (note: string) => void;
  requestSend: () => void;
  confirmSend: () => void;
  cancelConfirm: () => void;
}

export interface GiftHistory {
  direction: GiftHistoryDirection;
  selectDirection: (direction: GiftHistoryDirection) => void;
  items: GiftHistoryItem[];
  done: boolean;
  loading: boolean;
  loadMore: () => void;
}

export interface GiftLeaderboard {
  type: GiftLeaderboardType;
  period: GiftLeaderboardPeriod;
  selectType: (type: GiftLeaderboardType) => void;
  selectPeriod: (period: GiftLeaderboardPeriod) => void;
  board: GiftLeaderboardResult | undefined;
  failed: boolean;
}
