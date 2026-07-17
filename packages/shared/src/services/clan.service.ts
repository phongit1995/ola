import { http } from '../api';
import { appendUploadFile, type UploadFile } from '../lib/upload';
import { API_PATH } from '../config';
import type {
  Clan,
  ClanAssignRoleRequest,
  ClanBanListResult,
  ClanCheckNameResult,
  ClanMemberListResult,
  ClanPostsResult,
  ClanRole,
  ClanUploadImageResult,
  CreateClanRequest,
  CreatePostRequest,
  FeedParams,
  MessageResult,
  Post,
  UpdateClanRequest,
} from '../types';

export class ClanService {
  static checkName(name: string): Promise<ClanCheckNameResult> {
    return http.get<ClanCheckNameResult>(API_PATH.clans.checkName, { params: { name } });
  }

  static create(payload: CreateClanRequest): Promise<Clan> {
    return http.post<Clan>(API_PATH.clans.base, payload);
  }

  static mine(): Promise<Clan[]> {
    return http.get<Clan[]>(API_PATH.clans.mine);
  }

  static byHandle(handle: string): Promise<Clan> {
    return http.get<Clan>(API_PATH.clans.byHandle(handle));
  }

  static get(id: string): Promise<Clan> {
    return http.get<Clan>(API_PATH.clans.detail(id));
  }

  static update(id: string, payload: UpdateClanRequest): Promise<Clan> {
    return http.patch<Clan>(API_PATH.clans.detail(id), payload);
  }

  static join(id: string): Promise<Clan> {
    return http.post<Clan>(API_PATH.clans.join(id), {});
  }

  static leave(id: string): Promise<Clan> {
    return http.del<Clan>(API_PATH.clans.join(id));
  }

  static members(id: string, params: FeedParams = {}): Promise<ClanMemberListResult> {
    return http.get<ClanMemberListResult>(API_PATH.clans.members(id), { params });
  }

  static assignRole(id: string, payload: ClanAssignRoleRequest): Promise<MessageResult> {
    return http.put<MessageResult>(API_PATH.clans.roles(id), payload);
  }

  static revokeRole(id: string, role: Extract<ClanRole, 'deputy' | 'ambassador'>): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.clans.role(id, role));
  }

  static verify(id: string, username: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.clans.verify(id), { username });
  }

  static unverify(id: string, username: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.clans.verify(id), { data: { username } });
  }

  static bans(id: string, params: FeedParams = {}): Promise<ClanBanListResult> {
    return http.get<ClanBanListResult>(API_PATH.clans.bans(id), { params });
  }

  static ban(id: string, username: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.clans.bans(id), { username });
  }

  static unban(id: string, userId: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.clans.ban(id, userId));
  }

  static posts(id: string, params: { cursor?: string; limit?: number } = {}): Promise<ClanPostsResult> {
    return http.get<ClanPostsResult>(API_PATH.clans.posts(id), { params });
  }

  static createPost(id: string, payload: CreatePostRequest): Promise<Post> {
    return http.post<Post>(API_PATH.clans.posts(id), payload);
  }

  static pinPost(id: string, postId: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.clans.pin(id), { postId });
  }

  static unpinPost(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.clans.pin(id));
  }

  static deletePost(id: string, postId: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.clans.post(id, postId));
  }

  static deletePostsByUser(id: string, userId: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.clans.postsByUser(id, userId));
  }

  static uploadAvatar(id: string, file: UploadFile): Promise<ClanUploadImageResult> {
    const form = new FormData();
    appendUploadFile(form, 'image', file);
    return http.postForm<ClanUploadImageResult>(API_PATH.clans.avatar(id), form);
  }

  static uploadCover(id: string, file: UploadFile): Promise<ClanUploadImageResult> {
    const form = new FormData();
    appendUploadFile(form, 'image', file);
    return http.postForm<ClanUploadImageResult>(API_PATH.clans.cover(id), form);
  }
}
