import { useInfiniteQuery, useQuery } from '@tanstack/react-query'
import { AdminConversationService } from '@/services/adminConversation.service'

const CONVERSATIONS_KEY = 'admin-conversations'
const MESSAGES_PAGE_SIZE = 50
const CONVERSATIONS_PAGE_SIZE = 30

export function useUserConversations(userId: string | null, hidden: boolean) {
  return useInfiniteQuery({
    queryKey: [CONVERSATIONS_KEY, 'by-user', userId, hidden],
    queryFn: ({ pageParam }) =>
      AdminConversationService.listByUser({
        userId: userId as string,
        hidden,
        limit: CONVERSATIONS_PAGE_SIZE,
        offset: pageParam.offset,
        snapshot: pageParam.snapshot || undefined,
      }),
    initialPageParam: { offset: 0, snapshot: '' },
    // Later pages read the order frozen by the first page, so a full refetch starts a new snapshot.
    getNextPageParam: (last, pages) =>
      last.hasMore && last.snapshot
        ? { offset: pages.reduce((sum, page) => sum + page.items.length, 0), snapshot: last.snapshot }
        : undefined,
    enabled: userId != null,
  })
}

export function useConversationDetail(id: string | null) {
  return useQuery({
    queryKey: [CONVERSATIONS_KEY, 'detail', id],
    queryFn: () => AdminConversationService.detail(id as string),
    enabled: id != null,
  })
}

export function useConversationMessages(id: string | null, around?: string) {
  return useInfiniteQuery({
    queryKey: [CONVERSATIONS_KEY, 'messages', id, around ?? null],
    queryFn: ({ pageParam }) =>
      AdminConversationService.messages(
        id as string,
        pageParam ? { limit: MESSAGES_PAGE_SIZE, before: pageParam } : { limit: MESSAGES_PAGE_SIZE, around },
      ),
    initialPageParam: '',
    getNextPageParam: (last) => (last.hasMore && last.nextBefore ? last.nextBefore : undefined),
    enabled: id != null,
  })
}
