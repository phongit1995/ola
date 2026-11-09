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
  ago: (elapsed: string) => string;
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

export type VipDayTransferErrorKey =
  | 'vip.buy.errDayTransferDisabled'
  | 'vip.buy.errDayTransferInvalid'
  | 'vip.buy.errDayTransferNotEnough'
  | 'vip.buy.errDayTransferRateChanged'
  | 'vip.buy.errReceiverNotFound'
  | 'vip.buy.errGiftSelf'
  | 'vip.buy.errBlocked'
  | 'vip.buy.errWrongPassword';

export type GiftErrorKey =
  | 'gift.errors.disabled'
  | 'gift.errors.notFound'
  | 'gift.errors.self'
  | 'gift.errors.blocked'
  | 'gift.errors.receiverUnavailable'
  | 'gift.errors.insufficientKen'
  | 'gift.errors.invalidQuantity'
  | 'gift.errors.noteTooLong'
  | 'gift.errors.rateLimited'
  | 'gift.errors.failed';

export type MegaphoneErrorKey =
  | 'megaphone.errors.disabled'
  | 'megaphone.errors.empty'
  | 'megaphone.errors.tooLong'
  | 'megaphone.errors.link'
  | 'megaphone.errors.blocked'
  | 'megaphone.errors.cooldown'
  | 'megaphone.errors.dailyLimit'
  | 'megaphone.errors.queueFull'
  | 'megaphone.errors.insufficientKen'
  | 'megaphone.errors.rateLimited'
  | 'megaphone.errors.failed';

export type GiftCodeErrorKey =
  | 'giftCode.errors.empty'
  | 'giftCode.errors.invalid'
  | 'giftCode.errors.notStarted'
  | 'giftCode.errors.expired'
  | 'giftCode.errors.soldOut'
  | 'giftCode.errors.used'
  | 'giftCode.errors.alreadyRedeemed'
  | 'giftCode.errors.deviceRedeemed'
  | 'giftCode.errors.accountTooNew'
  | 'giftCode.errors.platformNotAllowed'
  | 'giftCode.errors.tooManyAttempts'
  | 'giftCode.errors.emailNotVerified'
  | 'giftCode.errors.deviceUnknown'
  | 'giftCode.errors.frameOwned'
  | 'giftCode.errors.rateLimited'
  | 'giftCode.errors.failed';

export type CallMessageStatus = 'ended' | 'missed' | 'declined';

export interface MessageMetadata {
  url?: string;
  duration?: number;
  waveform?: number[];
  uploadName?: string;
  uploadType?: string;
  callId?: string;
  callType?: 'audio' | 'video';
  callStatus?: CallMessageStatus;
  durationSeconds?: number;
}

export interface VipCatalogEntry {
  id: number;
  name: string;
}

export interface AvatarFrame {
  id: string;
  name: string;
  file: string;
  url: string;
}

export interface VietQrImageParams {
  bankBin: string;
  accountNumber: string;
  amount?: number;
  memo?: string;
  accountName?: string;
}
