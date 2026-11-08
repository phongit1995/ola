import type { GiftCodeAppConfig, RedeemGiftCodeResult } from '../api/giftCode.type';

export interface GiftCodeConfigState {
  config: GiftCodeAppConfig | null;
  load: () => Promise<void>;
}

export interface GiftCodeRedeemOptions {
  onRedeemed?: (result: RedeemGiftCodeResult) => void;
}

export interface GiftCodeFailure {
  code?: string;
  text: string;
}

export interface GiftCodeRedeem {
  code: string;
  setCode: (value: string) => void;
  submitting: boolean;
  error: string | null;
  result: RedeemGiftCodeResult | null;
  canSubmit: boolean;
  needsEmailVerify: boolean;
  submit: () => Promise<void>;
  reset: () => void;
}
