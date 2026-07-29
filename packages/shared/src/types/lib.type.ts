export interface ApiGuardSignature {
  timestamp: string;
  nonce: string;
  signature: string;
}

export interface ApiErrorMeta {
  traceId?: string;
  path?: string;
  code?: string;
}

export interface ObjectUrlApi {
  createObjectURL?: (blob: Blob) => string;
  revokeObjectURL?: (url: string) => void;
}

export interface CryptoLike {
  randomUUID?: () => string;
  getRandomValues?: (array: Uint8Array) => Uint8Array;
}

export interface TimeLabels {
  justNow: string;
  minute: (n: number) => string;
  hour: (n: number) => string;
  today: string;
  yesterday: string;
  dayBefore: string;
  weekdays: string[];
}

export type BuyErrorKey =
  | 'vip.buy.errInsufficientKen'
  | 'vip.buy.errItemUnavailable'
  | 'vip.buy.errPackageUnavailable'
  | 'vip.buy.errReceiverNotFound'
  | 'vip.buy.errGiftSelf'
  | 'vip.buy.errBlocked'
  | 'vip.buy.errWrongPassword';

export interface MessageMetadata {
  url?: string;
  duration?: number;
  waveform?: number[];
  uploadName?: string;
  uploadType?: string;
}

export interface VipCatalogEntry {
  id: number;
  name: string;
}

export interface VietQrImageParams {
  bankBin: string;
  accountNumber: string;
  amount?: number;
  memo?: string;
  accountName?: string;
}
