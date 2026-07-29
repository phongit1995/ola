import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { PresenceBatchResult } from '../types/api/user.type';

export class PresenceService {
  static batch(userIds: string[]): Promise<PresenceBatchResult> {
    return http.post<PresenceBatchResult>(API_PATH.user.presence, { userIds });
  }
}
