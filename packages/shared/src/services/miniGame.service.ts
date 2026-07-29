import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { MiniGame } from '../types/api/miniGame.type';

export class MiniGameService {
  static list(): Promise<MiniGame[]> {
    return http.get<MiniGame[]>(API_PATH.miniGame.list);
  }
}
