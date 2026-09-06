import { http } from '../api/http';
import { API_PATH } from '../config/api';

export class PushService {
  static registerToken(token: string): Promise<{ message: string }> {
    return http.post<{ message: string }>(API_PATH.push.token, { token });
  }
}
