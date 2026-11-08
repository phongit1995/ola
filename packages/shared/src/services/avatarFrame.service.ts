import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  AvatarFramePrivacy,
  AvatarFramePurchaseHistoryResult,
  AvatarFrameShopResult,
  AvatarFrameStoreResult,
  AvatarFrameTransferHistoryResult,
  BuyAvatarFrameResult,
  EquipAvatarFrameResult,
  GiftAvatarFrameResult,
} from '../types/api/avatarFrame.type';

interface PageParams {
  limit?: number;
  offset?: number;
}

export class AvatarFrameService {
  static shop(): Promise<AvatarFrameShopResult> {
    return http.get<AvatarFrameShopResult>(API_PATH.avatarFrame.shop);
  }

  static buy(shopItemId: string, expectedKenPrice: number): Promise<BuyAvatarFrameResult> {
    return http.post<BuyAvatarFrameResult>(API_PATH.avatarFrame.buy, { shopItemId, expectedKenPrice });
  }

  static gift(
    shopItemId: string,
    expectedKenPrice: number,
    toUsername: string,
    password: string,
  ): Promise<GiftAvatarFrameResult> {
    return http.post<GiftAvatarFrameResult>(API_PATH.avatarFrame.gift, {
      shopItemId,
      expectedKenPrice,
      toUsername,
      password,
    });
  }

  static myStore(params?: PageParams): Promise<AvatarFrameStoreResult> {
    return http.get<AvatarFrameStoreResult>(API_PATH.avatarFrame.mine, { params });
  }

  static peerStore(userId: string, params?: PageParams): Promise<AvatarFrameStoreResult> {
    return http.get<AvatarFrameStoreResult>(API_PATH.avatarFrame.userStore(userId), { params });
  }

  static equip(frameId: string | null): Promise<EquipAvatarFrameResult> {
    return http.put<EquipAvatarFrameResult>(API_PATH.avatarFrame.equip, { frameId: frameId ?? '' });
  }

  static transfer(frameId: string, toUserId: string, password: string): Promise<unknown> {
    return http.post<unknown>(API_PATH.avatarFrame.transfer(frameId), { toUserId, password });
  }

  static setPrivacy(privacy: AvatarFramePrivacy): Promise<unknown> {
    return http.put<unknown>(API_PATH.avatarFrame.storePrivacy, { privacy });
  }

  static history(params?: PageParams): Promise<AvatarFramePurchaseHistoryResult> {
    return http.get<AvatarFramePurchaseHistoryResult>(API_PATH.avatarFrame.history, { params });
  }

  static transfers(params?: PageParams): Promise<AvatarFrameTransferHistoryResult> {
    return http.get<AvatarFrameTransferHistoryResult>(API_PATH.avatarFrame.transfers, { params });
  }
}
