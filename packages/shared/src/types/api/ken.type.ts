export interface TransferKenRequest {
  toUserId: string;
  amount: number;
  password: string;
}

export interface TransferKenResult {
  toUserId: string;
  amount: number;
  kenBalance: number;
}

export type KenDirection = 'credit' | 'debit';

export type KenTxType =
  | 'VIP_PACKAGE'
  | 'VIP_ICON'
  | 'ADMIN_GRANT'
  | 'ADMIN_DEDUCT'
  | 'REWARD'
  | 'EGG_OPEN'
  | 'TOPUP'
  | 'REFUND'
  | 'GIFT_SENT'
  | 'GIFT_RECEIVED'
  | 'TRANSFER_IN'
  | 'TRANSFER_OUT'
  | 'PEN_SHOOT'
  | 'PEN_CATCH'
  | 'PEN_WIN'
  | 'PEN_REFUND'
  | 'KEN_CHEST'
  | 'CLAN_CREATE';

export interface KenTransaction {
  id: string;
  direction: KenDirection;
  type: KenTxType;
  amount: number;
  balanceAfter: number;
  description?: string;
  createdAt: string;
  counterpartyId?: string;
  counterpartyName?: string;
}

export interface KenHistoryParams {
  direction?: KenDirection;
  limit?: number;
  offset?: number;
}

export interface KenHistoryResult {
  items: KenTransaction[];
  total: number;
  limit: number;
  offset: number;
}
