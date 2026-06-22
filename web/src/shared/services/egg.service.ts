import { http } from '@api';
import { API_PATH } from '@config';
import type { EggDrawResult, EggPackListResult } from '@app-types';

export class EggService {
  static listPacks(): Promise<EggPackListResult> {
    return http.get<EggPackListResult>(API_PATH.egg.packs);
  }

  static draw(packId: string, idempotencyKey: string): Promise<EggDrawResult> {
    return http.post<EggDrawResult>(API_PATH.egg.draw(packId), { idempotencyKey });
  }
}
