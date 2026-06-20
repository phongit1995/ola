import { http } from '@api';
import { API_PATH } from '@config';
import type {
  AuthUser,
  UpdateProfileRequest,
  UploadAvatarResult,
  PublicProfile,
  KissResult,
  FollowResult,
  FollowListResult,
  FollowListParams,
  SearchUsersResult,
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

  static search(query: string, limit = 20): Promise<SearchUsersResult> {
    return http.get<SearchUsersResult>(API_PATH.user.search, { params: { q: query, limit } });
  }

  static publicProfile(id: string): Promise<PublicProfile> {
    return http.get<PublicProfile>(API_PATH.user.detail(id));
  }

  static kiss(id: string): Promise<KissResult> {
    return http.post<KissResult>(API_PATH.user.kiss(id));
  }

  static follow(id: string): Promise<FollowResult> {
    return http.post<FollowResult>(API_PATH.user.follow(id));
  }

  static unfollow(id: string): Promise<FollowResult> {
    return http.del<FollowResult>(API_PATH.user.follow(id));
  }

  static followers(id: string, params: FollowListParams = {}): Promise<FollowListResult> {
    return http.get<FollowListResult>(API_PATH.user.followers(id), { params });
  }

  static following(id: string, params: FollowListParams = {}): Promise<FollowListResult> {
    return http.get<FollowListResult>(API_PATH.user.following(id), { params });
  }
}
