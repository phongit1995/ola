import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { RedeemGiftCodeResult } from '../types/api/giftCode.type';

export class GiftCodeService {
  static redeem(code: string): Promise<RedeemGiftCodeResult> {
    return http.post<RedeemGiftCodeResult>(API_PATH.giftCodes.redeem, { code });
  }
}
