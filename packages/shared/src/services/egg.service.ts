import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  EggDrawHistoryFilter,
  EggDrawHistoryResult,
  EggDrawResult,
  EggGiftListResult,
  EggPackListResult,
} from '../types/api/egg.type';

export class EggService {
  static listPacks(): Promise<EggPackListResult> {
    return http.get<EggPackListResult>(API_PATH.egg.packs);
  }

  static listGifts(packId: string): Promise<EggGiftListResult> {
    return http.get<EggGiftListResult>(API_PATH.egg.gifts(packId));
  }

  static draw(packId: string, idempotencyKey: string): Promise<EggDrawResult> {
    return http.post<EggDrawResult>(API_PATH.egg.draw(packId), { idempotencyKey });
  }

  static listDraws(
    limit: number,
    offset: number,
    outcome: EggDrawHistoryFilter
  ): Promise<EggDrawHistoryResult> {
    return http.get<EggDrawHistoryResult>(API_PATH.egg.draws, {
      params: { limit, offset, ...(outcome === 'all' ? {} : { outcome }) },
    });
  }
}
