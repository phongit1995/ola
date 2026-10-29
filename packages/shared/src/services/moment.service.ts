import { http } from '../api/http';
import { API_PATH } from '../config/api';
import {
  MOMENT_COMMENTS_PAGE_SIZE,
  MOMENT_HISTORY_PAGE_SIZE,
  MOMENT_UPLOAD_TIMEOUT_MS,
  MOMENT_VIEWERS_PAGE_SIZE,
} from '../constants/moment';
import { appendUploadFile, type UploadFile } from '../lib/upload';
import type {
  CreateMomentItem,
  CreateMomentsResult,
  MarkMomentsSeenResult,
  Moment,
  MomentCommentsPage,
  MomentHistoryPage,
  MomentMyComment,
  MomentReactorsPage,
  MomentReactResult,
  MyMomentsResult,
  MomentTrayPage,
  MomentType,
  MomentUserPage,
  MomentViewersPage,
  MomentVisibility,
} from '../types/api/moment.type';
import type { ReactionType } from '../types/api/chat.type';

export interface CreateMomentsInput {
  type: MomentType;
  visibility: MomentVisibility;
  items: CreateMomentItem[];
  images?: UploadFile[];
  thumbs?: UploadFile[];
  video?: UploadFile;
  thumb?: UploadFile;
}

async function firstFilledPage<T>(
  load: (offset: number) => Promise<MomentUserPage<T>>,
  offset: number
): Promise<MomentUserPage<T>> {
  let page = await load(offset);
  while (page.items.length === 0 && page.nextOffset != null) {
    page = await load(page.nextOffset);
  }
  return page;
}

export class MomentService {
  static tray(cursor?: string): Promise<MomentTrayPage> {
    return http.get<MomentTrayPage>(API_PATH.moments.tray, {
      params: cursor ? { cursor } : undefined,
    });
  }

  static mine(): Promise<MyMomentsResult> {
    return http.get<MyMomentsResult>(API_PATH.moments.mine);
  }

  static create(input: CreateMomentsInput): Promise<CreateMomentsResult> {
    const form = new FormData();
    form.append('type', input.type);
    form.append('visibility', input.visibility);
    form.append('items', JSON.stringify(input.items));
    input.images?.forEach((file) => appendUploadFile(form, 'images', file));
    input.thumbs?.forEach((file) => appendUploadFile(form, 'thumbs', file));
    if (input.video) appendUploadFile(form, 'video', input.video);
    if (input.thumb) appendUploadFile(form, 'thumb', input.thumb);
    return http.postForm<CreateMomentsResult>(API_PATH.moments.base, form, {
      timeout: MOMENT_UPLOAD_TIMEOUT_MS,
    });
  }

  static markSeen(ids: string[]): Promise<MarkMomentsSeenResult> {
    return http.post<MarkMomentsSeenResult>(API_PATH.moments.seen, { ids });
  }

  static react(id: string, type: ReactionType, count: number): Promise<MomentReactResult> {
    return http.post<MomentReactResult>(API_PATH.moments.reactions(id), { type, count });
  }

  static viewers(id: string, offset = 0): Promise<MomentViewersPage> {
    return http.get<MomentViewersPage>(API_PATH.moments.viewers(id), {
      params: { limit: MOMENT_VIEWERS_PAGE_SIZE, offset },
    });
  }

  static visibleViewers(id: string, offset = 0): Promise<MomentViewersPage> {
    return firstFilledPage((at) => MomentService.viewers(id, at), offset);
  }

  static reactors(id: string, offset = 0): Promise<MomentReactorsPage> {
    return http.get<MomentReactorsPage>(API_PATH.moments.reactions(id), {
      params: { limit: MOMENT_VIEWERS_PAGE_SIZE, offset },
    });
  }

  static visibleReactors(id: string, offset = 0): Promise<MomentReactorsPage> {
    return firstFilledPage((at) => MomentService.reactors(id, at), offset);
  }

  static comment(id: string, content: string): Promise<MomentMyComment> {
    return http.post<MomentMyComment>(API_PATH.moments.comments(id), { content });
  }

  static comments(id: string, offset = 0): Promise<MomentCommentsPage> {
    return http.get<MomentCommentsPage>(API_PATH.moments.comments(id), {
      params: { limit: MOMENT_COMMENTS_PAGE_SIZE, offset },
    });
  }

  static visibleComments(id: string, offset = 0): Promise<MomentCommentsPage> {
    return firstFilledPage((at) => MomentService.comments(id, at), offset);
  }

  static history(offset = 0): Promise<MomentHistoryPage> {
    return http.get<MomentHistoryPage>(API_PATH.moments.history, {
      params: { limit: MOMENT_HISTORY_PAGE_SIZE, offset },
    });
  }

  static get(id: string): Promise<Moment> {
    return http.get<Moment>(API_PATH.moments.detail(id));
  }

  static setHidden(id: string, hidden: boolean): Promise<Moment> {
    return http.patch<Moment>(API_PATH.moments.hidden(id), { hidden });
  }
}
