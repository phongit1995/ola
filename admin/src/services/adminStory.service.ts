import http from '@/api/http'
import type { StoryGenreItem } from '@ola/shared/types'
import type {
  AdminStory,
  AdminStoryBulkVisibilityInput,
  AdminStoryBulkVisibilityResult,
  AdminStoryChapter,
  AdminStoryChapterDetail,
  AdminStoryFetchResult,
  AdminStoryListParams,
  AdminStorySource,
  AdminStorySummary,
  ApiResponse,
  ListResult,
  MessageResult,
} from '@/types'

export const AdminStoryService = {
  async list(params: AdminStoryListParams = {}): Promise<ListResult<AdminStory>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminStory>>>('/admin/stories', {
      params,
    })
    return data.data
  },

  async summary(): Promise<AdminStorySummary> {
    const { data } = await http.get<ApiResponse<AdminStorySummary>>('/admin/stories/summary')
    return data.data
  },

  async genres(): Promise<StoryGenreItem[]> {
    const { data } = await http.get<ApiResponse<{ items: StoryGenreItem[] }>>(
      '/admin/stories/genres',
    )
    return data.data.items
  },

  async sources(): Promise<AdminStorySource[]> {
    const { data } = await http.get<ApiResponse<{ items: AdminStorySource[] }>>(
      '/admin/stories/sources',
    )
    return data.data.items
  },

  async setHiddenMany(
    input: AdminStoryBulkVisibilityInput,
  ): Promise<AdminStoryBulkVisibilityResult> {
    const { data } = await http.patch<ApiResponse<AdminStoryBulkVisibilityResult>>(
      '/admin/stories',
      input,
    )
    return data.data
  },

  async setHidden(id: string, isHidden: boolean): Promise<AdminStory> {
    const { data } = await http.patch<ApiResponse<AdminStory>>(`/admin/stories/${id}`, {
      isHidden,
    })
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/stories/${id}`)
    return data.data
  },

  async chapters(id: string): Promise<AdminStoryChapter[]> {
    const { data } = await http.get<ApiResponse<{ items: AdminStoryChapter[] }>>(
      `/admin/stories/${id}/chapters`,
    )
    return data.data.items
  },

  async chapter(id: string, position: number): Promise<AdminStoryChapterDetail> {
    const { data } = await http.get<ApiResponse<AdminStoryChapterDetail>>(
      `/admin/stories/${id}/chapters/${position}`,
    )
    return data.data
  },

  async refetchChapter(id: string, position: number): Promise<AdminStoryChapterDetail> {
    const { data } = await http.post<ApiResponse<AdminStoryChapterDetail>>(
      `/admin/stories/${id}/chapters/${position}/refetch`,
    )
    return data.data
  },

  async fetchMissing(id: string): Promise<AdminStoryFetchResult> {
    const { data } = await http.post<ApiResponse<AdminStoryFetchResult>>(
      `/admin/stories/${id}/fetch-content`,
    )
    return data.data
  },
}
