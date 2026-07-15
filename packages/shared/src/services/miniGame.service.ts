import { http } from '../api';
import { API_PATH } from '../config';
import type { MiniGame } from '../types';

export class MiniGameService {
  static list(): Promise<MiniGame[]> {
    return http.get<MiniGame[]>(API_PATH.miniGame.list);
  }
}
