import { http } from '@api';
import { API_PATH } from '@config';
import type { ActiveChestListResult, OpenChestResult } from '@app-types';

export class KenTreasureService {
  static listActive(): Promise<ActiveChestListResult> {
    return http.get<ActiveChestListResult>(API_PATH.kenTreasure.active);
  }

  static open(chestId: string): Promise<OpenChestResult> {
    return http.post<OpenChestResult>(API_PATH.kenTreasure.open(chestId));
  }
}
