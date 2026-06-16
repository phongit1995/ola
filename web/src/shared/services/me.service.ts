import { http } from '@api';
import { API_PATH } from '@config';
import type {
  MessageResult,
  Post,
  PostComment,
  PostCommentListResult,
  PostLikerListResult,
  PostListResult,
  MeFeedResult,
  CreatePostRequest,
  UpdatePostRequest,
  CreateCommentRequest,
  ReactRequest,
  FeedParams,
  FeedCursorParams,
  PostReaction,
  UploadImagesResult,
} from '@app-types';

export class MeService {
  static feed(params: FeedCursorParams = {}): Promise<MeFeedResult> {
    return http.get<MeFeedResult>(API_PATH.me.base, { params });
  }

  static mine(params: FeedParams = {}): Promise<PostListResult> {
    return http.get<PostListResult>(API_PATH.me.mine, { params });
  }

  static byUser(userId: string, params: FeedParams = {}): Promise<PostListResult> {
    return http.get<PostListResult>(API_PATH.me.users(userId), { params });
  }

  static getById(id: string): Promise<Post> {
    return http.get<Post>(API_PATH.me.detail(id));
  }

  static create(payload: CreatePostRequest): Promise<Post> {
    return http.post<Post>(API_PATH.me.base, payload);
  }

  static update(id: string, payload: UpdatePostRequest): Promise<Post> {
    return http.put<Post>(API_PATH.me.detail(id), payload);
  }

  static remove(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.me.detail(id));
  }

  static uploadImages(files: File[]): Promise<UploadImagesResult> {
    const form = new FormData();
    files.forEach((file) => form.append('images', file));
    return http.postForm<UploadImagesResult>(API_PATH.me.images, form);
  }

  static react(id: string, type: PostReaction): Promise<Post> {
    const payload: ReactRequest = { type };
    return http.post<Post>(API_PATH.me.react(id), payload);
  }

  static removeReaction(id: string): Promise<Post> {
    return http.del<Post>(API_PATH.me.react(id));
  }

  static likers(id: string, params: FeedParams = {}): Promise<PostLikerListResult> {
    return http.get<PostLikerListResult>(API_PATH.me.likers(id), { params });
  }

  static comments(id: string, params: FeedParams = {}): Promise<PostCommentListResult> {
    return http.get<PostCommentListResult>(API_PATH.me.comments(id), { params });
  }

  static addComment(id: string, payload: CreateCommentRequest): Promise<PostComment> {
    return http.post<PostComment>(API_PATH.me.comments(id), payload);
  }

  static deleteComment(id: string, commentId: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.me.comment(id, commentId));
  }
}
