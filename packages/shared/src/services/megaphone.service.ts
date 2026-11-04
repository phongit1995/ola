import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  MegaphoneActiveResult,
  MegaphoneConfig,
  MegaphoneHistoryParams,
  MegaphoneHistoryResult,
  SendMegaphoneRequest,
  SendMegaphoneResult,
} from '../types/api/megaphone.type';

export class MegaphoneService {
  static config(): Promise<MegaphoneConfig> {
    return http.get<MegaphoneConfig>(API_PATH.megaphones.config);
  }

  static active(): Promise<MegaphoneActiveResult> {
    return http.get<MegaphoneActiveResult>(API_PATH.megaphones.active);
  }

  static history(params: MegaphoneHistoryParams = {}): Promise<MegaphoneHistoryResult> {
    return http.get<MegaphoneHistoryResult>(API_PATH.megaphones.base, { params });
  }

  static send(body: SendMegaphoneRequest): Promise<SendMegaphoneResult> {
    return http.post<SendMegaphoneResult>(API_PATH.megaphones.base, body);
  }
}
