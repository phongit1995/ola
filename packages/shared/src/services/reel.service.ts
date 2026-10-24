import { http } from '../api/http';
import { API_PATH } from '../config/api';
import { REEL_UPLOAD_TIMEOUT_MS, REEL_VIEWERS_PAGE_SIZE } from '../constants/reel';
import { appendUploadFile, type UploadFile } from '../lib/upload';
import type { MessageResult } from '../types/api/auth.type';
import type {
  CreateReelItem,
  CreateReelsResult,
  MarkReelsSeenResult,
  MyReelsResult,
  ReelTrayPage,
  ReelType,
  ReelViewersPage,
  ReelVisibility,
} from '../types/api/reel.type';

export interface CreateReelsInput {
  type: ReelType;
  visibility: ReelVisibility;
  items: CreateReelItem[];
  images?: UploadFile[];
  thumbs?: UploadFile[];
  video?: UploadFile;
  thumb?: UploadFile;
}

export class ReelService {
  static tray(cursor?: string): Promise<ReelTrayPage> {
    return http.get<ReelTrayPage>(API_PATH.reels.tray, {
      params: cursor ? { cursor } : undefined,
    });
  }

  static mine(): Promise<MyReelsResult> {
    return http.get<MyReelsResult>(API_PATH.reels.mine);
  }

  static create(input: CreateReelsInput): Promise<CreateReelsResult> {
    const form = new FormData();
    form.append('type', input.type);
    form.append('visibility', input.visibility);
    form.append('items', JSON.stringify(input.items));
    input.images?.forEach((file) => appendUploadFile(form, 'images', file));
    input.thumbs?.forEach((file) => appendUploadFile(form, 'thumbs', file));
    if (input.video) appendUploadFile(form, 'video', input.video);
    if (input.thumb) appendUploadFile(form, 'thumb', input.thumb);
    return http.postForm<CreateReelsResult>(API_PATH.reels.base, form, {
      timeout: REEL_UPLOAD_TIMEOUT_MS,
    });
  }

  static markSeen(ids: string[]): Promise<MarkReelsSeenResult> {
    return http.post<MarkReelsSeenResult>(API_PATH.reels.seen, { ids });
  }

  static viewers(id: string, offset = 0): Promise<ReelViewersPage> {
    return http.get<ReelViewersPage>(API_PATH.reels.viewers(id), {
      params: { limit: REEL_VIEWERS_PAGE_SIZE, offset },
    });
  }

  static async visibleViewers(id: string, offset = 0): Promise<ReelViewersPage> {
    let page = await ReelService.viewers(id, offset);
    while (page.items.length === 0 && page.nextOffset != null) {
      page = await ReelService.viewers(id, page.nextOffset);
    }
    return page;
  }

  static remove(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.reels.detail(id));
  }
}
