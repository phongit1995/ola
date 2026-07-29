import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { OpenChestResult } from '../types/api/kenTreasure.type';

export class KenTreasureService {
  static open(chestId: string): Promise<OpenChestResult> {
    return http.post<OpenChestResult>(API_PATH.kenTreasure.open(chestId));
  }
}
