import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminStoryService } from '@/services/adminStory.service'
import type { AdminStoryBulkVisibilityInput, AdminStoryListParams } from '@/types'

const STORIES_KEY = 'admin-stories'
const FILTER_OPTIONS_STALE_MS = 5 * 60 * 1000
const BULK_FETCH_POLL_MS = 3000

export function useStories(params: AdminStoryListParams) {
  return useQuery({
    queryKey: [STORIES_KEY, 'list', params],
    queryFn: () => AdminStoryService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useStorySummary() {
  return useQuery({
    queryKey: [STORIES_KEY, 'summary'],
    queryFn: () => AdminStoryService.summary(),
  })
}

export function useStoryGenres() {
  return useQuery({
    queryKey: [STORIES_KEY, 'genres'],
    queryFn: () => AdminStoryService.genres(),
    staleTime: FILTER_OPTIONS_STALE_MS,
  })
}

export function useStorySources() {
  return useQuery({
    queryKey: [STORIES_KEY, 'sources'],
    queryFn: () => AdminStoryService.sources(),
    staleTime: FILTER_OPTIONS_STALE_MS,
  })
}

export function useSetStoriesHidden() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (input: AdminStoryBulkVisibilityInput) => AdminStoryService.setHiddenMany(input),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [STORIES_KEY] })
    },
  })
}

export function useStoryChapters(id: string | null, pollUntil: number) {
  return useQuery({
    queryKey: [STORIES_KEY, 'chapters', id],
    queryFn: () => AdminStoryService.chapters(id as string),
    enabled: id != null,
    refetchInterval: (query) => {
      const missing = query.state.data?.some((chapter) => !chapter.hasContent) ?? false
      return missing && Date.now() < pollUntil ? BULK_FETCH_POLL_MS : false
    },
  })
}

export function useStoryChapter(id: string | null, position: number | null) {
  return useQuery({
    queryKey: [STORIES_KEY, 'chapter', id, position],
    queryFn: () => AdminStoryService.chapter(id as string, position as number),
    enabled: id != null && position != null,
  })
}

export function useRefreshStoryLists() {
  const queryClient = useQueryClient()
  return () => {
    void queryClient.invalidateQueries({ queryKey: [STORIES_KEY, 'list'] })
    void queryClient.invalidateQueries({ queryKey: [STORIES_KEY, 'summary'] })
  }
}

export function useSetStoryHidden() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, isHidden }: { id: string; isHidden: boolean }) =>
      AdminStoryService.setHidden(id, isHidden),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [STORIES_KEY] })
    },
  })
}

export function useDeleteStory() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminStoryService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [STORIES_KEY] })
    },
  })
}

export function useRefetchStoryChapter(id: string | null) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (position: number) => AdminStoryService.refetchChapter(id as string, position),
    onSuccess: (chapter) => {
      queryClient.setQueryData([STORIES_KEY, 'chapter', id, chapter.position], chapter)
      void queryClient.invalidateQueries({ queryKey: [STORIES_KEY, 'chapters', id] })
      void queryClient.invalidateQueries({ queryKey: [STORIES_KEY, 'list'] })
      void queryClient.invalidateQueries({ queryKey: [STORIES_KEY, 'summary'] })
    },
  })
}

export function useFetchMissingStoryContent() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminStoryService.fetchMissing(id),
    onSuccess: (_, id) => {
      void queryClient.invalidateQueries({ queryKey: [STORIES_KEY, 'chapters', id] })
    },
  })
}
