import type { ParseKeys } from 'i18next';

export interface TransferTarget {
  id: string;
  name: string;
  username?: string;
}

export type TransferKenStep = 'recipient' | 'input' | 'confirm';

export type TransferPickStep = 'select' | 'confirm';

export interface TransferErrorKeys {
  network: ParseKeys;
  unauthorized: ParseKeys;
  forbidden: ParseKeys;
  blocked?: ParseKeys;
}

export type ChatTransferKind = 'ken' | 'vip' | 'vipDays' | 'vipDayTransfer' | 'gift';
