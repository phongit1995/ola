import { http } from '../api/http';
import { toApiError } from '../lib/apiError';
import { shouldCleanupRejectedPostUpload } from '../lib/mePost';
import { appendUploadFile, audioUploadFilename, uploadFileMimeType } from '../lib/upload';
import type { UploadFile } from '../types/client/upload.type';
import type { MeAudioDraft } from '../types/client/feed.type';
import { AUDIO_UPLOAD_TIMEOUT_MS } from '../constants/upload';
import { API_PATH } from '../config/api';
import type { MessageResult } from '../types/api/auth.type';
import type {
  Post,
  PostComment,
  PostCommentListResult,
  PostLikerListResult,
  PostListResult,
  MePhotoListResult,
  MeFeedResult,
  CreatePostRequest,
  UpdatePostRequest,
  CreateCommentRequest,
  ReactRequest,
  FeedParams,
  FeedCursorParams,
  PostReaction,
  UploadImagesResult,
  UploadAudioResult,
  UploadedAudio,
  PostAudio,
  PostUploadRef,
  MeNotificationListResult,
  MeNotificationUnreadResult,
} from '../types/api/me.type';

export class MeService {
  static feed(params: FeedCursorParams = {}): Promise<MeFeedResult> {
    return http.get<MeFeedResult>(API_PATH.me.base, { params });
  }

  static mine(params: FeedParams = {}): Promise<PostListResult> {
    return http.get<PostListResult>(API_PATH.me.mine, { params });
  }

  static photos(params: FeedParams = {}): Promise<MePhotoListResult> {
    return http.get<MePhotoListResult>(API_PATH.me.photos, { params });
  }

  static liked(params: FeedParams = {}): Promise<PostListResult> {
    return http.get<PostListResult>(API_PATH.me.liked, { params });
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

  static uploadImages(files: UploadFile[]): Promise<UploadImagesResult> {
    const form = new FormData();
    files.forEach((file) => appendUploadFile(form, 'images', file));
    return http.postForm<UploadImagesResult>(API_PATH.me.images, form);
  }

  static uploadAudio(
    file: UploadFile,
    duration: number,
    waveform?: number[]
  ): Promise<UploadAudioResult> {
    const form = new FormData();
    appendUploadFile(form, 'file', file, audioUploadFilename(uploadFileMimeType(file)));
    form.append('duration', String(duration));
    if (waveform != null && waveform.length > 0) {
      form.append('waveform', JSON.stringify(waveform));
    }
    return http.postForm<UploadAudioResult>(API_PATH.me.audio, form, {
      timeout: AUDIO_UPLOAD_TIMEOUT_MS,
    });
  }

  static async resolveAudios(
    draft: MeAudioDraft | null | undefined,
    existing: readonly PostAudio[] = []
  ): Promise<{ audios: PostAudio[]; uploaded: UploadedAudio[] }> {
    if (draft == null) return { audios: [], uploaded: [] };
    if (draft.file != null) {
      const { audio } = await this.uploadAudio(draft.file, draft.duration, draft.waveform);
      return { audios: [audio], uploaded: [audio] };
    }
    if (draft.url == null || draft.url === '') return { audios: [], uploaded: [] };
    const kept = existing.find((audio) => audio.url === draft.url) ?? {
      url: draft.url,
      duration: draft.duration,
      waveform: draft.waveform,
    };
    return { audios: [kept], uploaded: [] };
  }

  static async cleanupUploads(uploads: readonly PostUploadRef[]): Promise<void> {
    const objectNames = [
      ...new Set(
        uploads
          .map((upload) => upload.objectName)
          .filter((objectName): objectName is string => objectName != null && objectName !== '')
      ),
    ];
    if (objectNames.length === 0) return;
    await http.post<MessageResult>(API_PATH.me.cleanupImages, { objectNames });
  }

  static async cleanupRejectedUploads(
    error: unknown,
    uploads: readonly PostUploadRef[]
  ): Promise<void> {
    if (!shouldCleanupRejectedPostUpload(toApiError(error).status)) return;
    let lastError: unknown;
    for (let attempt = 0; attempt < 2; attempt += 1) {
      try {
        await this.cleanupUploads(uploads);
        return;
      } catch (cleanupError) {
        lastError = cleanupError;
      }
    }
    console.error('cleanup rejected post uploads failed', lastError);
  }

  static pin(id: string): Promise<Post> {
    return http.post<Post>(API_PATH.me.pin(id), {});
  }

  static unpin(id: string): Promise<Post> {
    return http.del<Post>(API_PATH.me.pin(id));
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

  static likeComment(id: string, commentId: string): Promise<PostComment> {
    return http.post<PostComment>(API_PATH.me.commentLike(id, commentId), {});
  }

  static commentLikers(
    id: string,
    commentId: string,
    params: FeedParams = {}
  ): Promise<PostLikerListResult> {
    return http.get<PostLikerListResult>(API_PATH.me.commentLikers(id, commentId), { params });
  }

  static notifications(params: FeedCursorParams = {}): Promise<MeNotificationListResult> {
    return http.get<MeNotificationListResult>(API_PATH.me.notifications, { params });
  }

  static notificationsUnreadCount(): Promise<MeNotificationUnreadResult> {
    return http.get<MeNotificationUnreadResult>(API_PATH.me.notificationsUnread);
  }

  static markNotificationsRead(): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.me.notificationsReadAll, {});
  }
}
