import { api } from '@api';
import { API_PATH } from '@config';
import type {
  IApiResponse,
  MessageResult,
  Post,
  PostComment,
  PostCommentListResult,
  PostLikerListResult,
  PostListResult,
  CreatePostRequest,
  UpdatePostRequest,
  CreateCommentRequest,
  ReactRequest,
  FeedParams,
  PostReaction,
  UploadImagesResult,
} from '@app-types';

export class MeService {
  static async feed(params: FeedParams = {}): Promise<PostListResult> {
    const { data } = await api.get<IApiResponse<PostListResult>>(API_PATH.me.base, { params });
    return data.data;
  }

  static async mine(params: FeedParams = {}): Promise<PostListResult> {
    const { data } = await api.get<IApiResponse<PostListResult>>(API_PATH.me.mine, { params });
    return data.data;
  }

  static async byUser(userId: string, params: FeedParams = {}): Promise<PostListResult> {
    const { data } = await api.get<IApiResponse<PostListResult>>(API_PATH.me.users(userId), {
      params,
    });
    return data.data;
  }

  static async getById(id: string): Promise<Post> {
    const { data } = await api.get<IApiResponse<Post>>(API_PATH.me.detail(id));
    return data.data;
  }

  static async create(payload: CreatePostRequest): Promise<Post> {
    const { data } = await api.post<IApiResponse<Post>>(API_PATH.me.base, payload);
    return data.data;
  }

  static async update(id: string, payload: UpdatePostRequest): Promise<Post> {
    const { data } = await api.put<IApiResponse<Post>>(API_PATH.me.detail(id), payload);
    return data.data;
  }

  static async remove(id: string): Promise<MessageResult> {
    const { data } = await api.delete<IApiResponse<MessageResult>>(API_PATH.me.detail(id));
    return data.data;
  }

  static async uploadImages(files: File[]): Promise<UploadImagesResult> {
    const form = new FormData();
    files.forEach((file) => form.append('images', file));
    const { data } = await api.post<IApiResponse<UploadImagesResult>>(API_PATH.me.images, form, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return data.data;
  }

  static async react(id: string, type: PostReaction): Promise<Post> {
    const payload: ReactRequest = { type };
    const { data } = await api.post<IApiResponse<Post>>(API_PATH.me.react(id), payload);
    return data.data;
  }

  static async removeReaction(id: string): Promise<Post> {
    const { data } = await api.delete<IApiResponse<Post>>(API_PATH.me.react(id));
    return data.data;
  }

  static async likers(id: string, params: FeedParams = {}): Promise<PostLikerListResult> {
    const { data } = await api.get<IApiResponse<PostLikerListResult>>(API_PATH.me.likers(id), {
      params,
    });
    return data.data;
  }

  static async comments(id: string, params: FeedParams = {}): Promise<PostCommentListResult> {
    const { data } = await api.get<IApiResponse<PostCommentListResult>>(API_PATH.me.comments(id), {
      params,
    });
    return data.data;
  }

  static async addComment(id: string, payload: CreateCommentRequest): Promise<PostComment> {
    const { data } = await api.post<IApiResponse<PostComment>>(API_PATH.me.comments(id), payload);
    return data.data;
  }

  static async deleteComment(id: string, commentId: string): Promise<MessageResult> {
    const { data } = await api.delete<IApiResponse<MessageResult>>(
      API_PATH.me.comment(id, commentId)
    );
    return data.data;
  }
}
