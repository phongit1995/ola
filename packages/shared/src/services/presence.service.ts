import { http } from '../api';
import { API_PATH } from '../config';
import type { PresenceBatchResult } from '../types';

export class PresenceService {
  static batch(userIds: string[]): Promise<PresenceBatchResult> {
    return http.post<PresenceBatchResult>(API_PATH.user.presence, { userIds });
  }
}
