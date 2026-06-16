import { http } from '@api';
import { API_PATH } from '@config';
import type {
  AuthUser,
  UpdateProfileRequest,
  UploadAvatarResult,
} from '@app-types';

export class UserService {
  static me(): Promise<AuthUser> {
    return http.get<AuthUser>(API_PATH.user.me);
  }

  static updateMe(payload: UpdateProfileRequest): Promise<AuthUser> {
    return http.put<AuthUser>(API_PATH.user.me, payload);
  }

  static uploadAvatar(file: File): Promise<UploadAvatarResult> {
    const form = new FormData();
    form.append('file', file);
    return http.postForm<UploadAvatarResult>(API_PATH.user.upload, form);
  }
}
