import type { KenTxType } from '../types/api/ken.type';
import type { KenHistoryTab } from '../types/client/kenHistory.type';

export const KEN_HISTORY_PAGE_SIZE = 20;
export const KEN_TREASURE_OPEN_ANIMATION_MS = 1_000;
export const TOPUP_PAID_REDIRECT_MS = 3_000;

export const KEN_TX_META = {
  VIP_PACKAGE: { icon: '👑', labelKey: 'ken.historyScreen.types.VIP_PACKAGE' },
  VIP_ICON: { icon: '👑', labelKey: 'ken.historyScreen.types.VIP_ICON' },
  ADMIN_GRANT: { icon: '➕', labelKey: 'ken.historyScreen.types.ADMIN_GRANT' },
  ADMIN_DEDUCT: {
    icon: '➖',
    labelKey: 'ken.historyScreen.types.ADMIN_DEDUCT',
  },
  REWARD: { icon: '🏆', labelKey: 'ken.historyScreen.types.REWARD' },
  EGG_OPEN: { icon: '🥚', labelKey: 'ken.historyScreen.types.EGG_OPEN' },
  TOPUP: { icon: '💰', labelKey: 'ken.historyScreen.types.TOPUP' },
  REFUND: { icon: '↩️', labelKey: 'ken.historyScreen.types.REFUND' },
  GIFT_SENT: { icon: '🎁', labelKey: 'ken.historyScreen.types.GIFT_SENT' },
  GIFT_RECEIVED: {
    icon: '🎁',
    labelKey: 'ken.historyScreen.types.GIFT_RECEIVED',
  },
  TRANSFER_IN: { icon: '📥', labelKey: 'ken.historyScreen.types.TRANSFER_IN' },
  TRANSFER_OUT: {
    icon: '📤',
    labelKey: 'ken.historyScreen.types.TRANSFER_OUT',
  },
  PEN_SHOOT: { icon: '⚽', labelKey: 'ken.historyScreen.types.PEN_SHOOT' },
  PEN_CATCH: { icon: '🧤', labelKey: 'ken.historyScreen.types.PEN_CATCH' },
  PEN_WIN: { icon: '🏆', labelKey: 'ken.historyScreen.types.PEN_WIN' },
  PEN_REFUND: { icon: '↩️', labelKey: 'ken.historyScreen.types.PEN_REFUND' },
  KEN_CHEST: { icon: '🧰', labelKey: 'ken.historyScreen.types.KEN_CHEST' },
  CLAN_CREATE: { icon: '🛡️', labelKey: 'ken.historyScreen.types.CLAN_CREATE' },
  WORD_CHAIN_HINT: {
    icon: '💡',
    labelKey: 'ken.historyScreen.types.WORD_CHAIN_HINT',
  },
} as const satisfies Record<KenTxType, { icon: string; labelKey: string }>;

export const KEN_TX_META_FALLBACK = {
  icon: '🪙',
  labelKey: 'ken.historyScreen.types.UNKNOWN',
} as const;

export const KEN_HISTORY_TABS = [
  { key: 'all', labelKey: 'ken.historyScreen.tabAll' },
  { key: 'credit', labelKey: 'ken.historyScreen.tabCredit' },
  { key: 'debit', labelKey: 'ken.historyScreen.tabDebit' },
] as const satisfies readonly { key: KenHistoryTab; labelKey: string }[];
