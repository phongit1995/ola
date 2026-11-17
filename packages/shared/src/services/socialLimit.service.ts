import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { PostQuotaResult } from '../types/api/socialLimit.type';

export class SocialLimitService {
  static postQuotas(): Promise<PostQuotaResult> {
    return http.get<PostQuotaResult>(API_PATH.socialLimit.posts);
  }
}
