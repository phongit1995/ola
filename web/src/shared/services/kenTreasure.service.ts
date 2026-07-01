import { http } from '@api';
import { API_PATH } from '@config';
import type { OpenChestResult } from '@app-types';

export class KenTreasureService {
  static open(chestId: string): Promise<OpenChestResult> {
    return http.post<OpenChestResult>(API_PATH.kenTreasure.open(chestId));
  }
}
