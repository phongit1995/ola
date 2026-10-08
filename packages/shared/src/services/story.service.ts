import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  Story,
  StoryChapter,
  StoryChapterListResult,
  StoryChapterSummary,
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

  static chapter(storyId: string, position: number): Promise<StoryChapter> {
    return http.get<StoryChapter>(API_PATH.stories.chapter(storyId, position));
  }
}
