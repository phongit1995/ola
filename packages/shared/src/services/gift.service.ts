import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  GiftCatalog,
  GiftHistoryParams,
  GiftHistoryResult,
  GiftLeaderboardParams,
  GiftLeaderboardResult,
  GiftWall,
  SendGiftRequest,
  SendGiftResult,
} from '../types/api/gift.type';

export class GiftService {
  static catalog(): Promise<GiftCatalog> {
    return http.get<GiftCatalog>(API_PATH.gifts.base);
  }

  static send(body: SendGiftRequest): Promise<SendGiftResult> {
    return http.post<SendGiftResult>(API_PATH.gifts.send, body);
  }

  static wall(userId: string): Promise<GiftWall> {
    return http.get<GiftWall>(API_PATH.gifts.wall(userId));
  }

  static received(params: GiftHistoryParams = {}): Promise<GiftHistoryResult> {
    return http.get<GiftHistoryResult>(API_PATH.gifts.received, { params });
  }

  static sent(params: GiftHistoryParams = {}): Promise<GiftHistoryResult> {
    return http.get<GiftHistoryResult>(API_PATH.gifts.sent, { params });
  }

  static leaderboard(params: GiftLeaderboardParams): Promise<GiftLeaderboardResult> {
    return http.get<GiftLeaderboardResult>(API_PATH.gifts.leaderboard, { params });
  }
}
