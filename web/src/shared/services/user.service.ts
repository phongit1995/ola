import { api } from '@api';
import { API_PATH } from '@config';
import type {
  AuthUser,
  IApiResponse,
  UpdateProfileRequest,
  UploadAvatarResult,
} from '@app-types';

export class UserService {
  static async me(): Promise<AuthUser> {
    const { data } = await api.get<IApiResponse<AuthUser>>(API_PATH.user.me);
    return data.data;
  }

  static async updateMe(payload: UpdateProfileRequest): Promise<AuthUser> {
    const { data } = await api.put<IApiResponse<AuthUser>>(API_PATH.user.me, payload);
    return data.data;
  }

  static async uploadAvatar(file: File): Promise<UploadAvatarResult> {
    const form = new FormData();
    form.append('file', file);
    const { data } = await api.post<IApiResponse<UploadAvatarResult>>(API_PATH.user.upload, form, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return data.data;
  }
}
