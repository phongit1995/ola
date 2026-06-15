import { api } from '@api';
import { API_PATH } from '@config';
import type { AuthUser, IApiResponse } from '@app-types';

export class UserService {
  static async me(): Promise<AuthUser> {
    const { data } = await api.get<IApiResponse<AuthUser>>(API_PATH.user.me);
    return data.data;
  }
}
