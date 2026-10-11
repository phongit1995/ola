import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  CreateStoryCommentRequest,
  CreateStoryCommentResult,
  DeleteStoryCommentResult,
  Story,
  StoryChapter,
  StoryChapterListResult,
  StoryChapterSummary,
  StoryCommentLikeResult,
  StoryCommentListQuery,
  StoryCommentListResult,
  StoryGenreItem,
  StoryGenreListResult,
  StoryListQuery,
  StoryListResult,
} from '../types/api/story.type';

export class StoryService {
  static list(query: StoryListQuery = {}): Promise<StoryListResult> {
    return http.get<StoryListResult>(API_PATH.stories.list, { params: query });
  }

  static async genres(): Promise<StoryGenreItem[]> {
    const { items } = await http.get<StoryGenreListResult>(API_PATH.stories.genres);
    return items;
  }

  static detail(storyId: string): Promise<Story> {
    return http.get<Story>(API_PATH.stories.detail(storyId));
  }

  static async chapters(storyId: string): Promise<StoryChapterSummary[]> {
    const { items } = await http.get<StoryChapterListResult>(API_PATH.stories.chapters(storyId));
    return items;
  }

  static chapter(storyId: string, position: number, prefetch = false): Promise<StoryChapter> {
    return http.get<StoryChapter>(API_PATH.stories.chapter(storyId, position), {
      params: prefetch ? { prefetch: 1 } : undefined,
    });
  }

  static comments(storyId: string, query: StoryCommentListQuery = {}): Promise<StoryCommentListResult> {
    return http.get<StoryCommentListResult>(API_PATH.stories.comments(storyId), { params: query });
  }

  static addComment(storyId: string, body: CreateStoryCommentRequest): Promise<CreateStoryCommentResult> {
    return http.post<CreateStoryCommentResult>(API_PATH.stories.comments(storyId), body);
  }

  static deleteComment(storyId: string, commentId: string): Promise<DeleteStoryCommentResult> {
    return http.del<DeleteStoryCommentResult>(API_PATH.stories.comment(storyId, commentId));
  }

  static likeComment(storyId: string, commentId: string): Promise<StoryCommentLikeResult> {
    return http.post<StoryCommentLikeResult>(API_PATH.stories.commentLike(storyId, commentId));
  }
}
