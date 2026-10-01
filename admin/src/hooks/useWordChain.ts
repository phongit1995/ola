import { useInfiniteQuery, useQuery } from '@tanstack/react-query'
import { AdminWordChainService } from '@/services/adminWordChain.service'
import type { WordChainPage, WordChainWinsParams } from '@/types'

const WORD_CHAIN_KEY = 'admin-word-chain'
const MESSAGE_PAGE_SIZE = 50
const WIN_PAGE_SIZE = 30

function nextCursor<T>(page: WordChainPage<T>) {
  return page.hasMore ? page.nextBefore : undefined
}

export function useWordChainOverview() {
  return useQuery({
    queryKey: [WORD_CHAIN_KEY, 'overview'],
    queryFn: () => AdminWordChainService.overview(),
  })
}

export function useWordChainMessages() {
  return useInfiniteQuery({
    queryKey: [WORD_CHAIN_KEY, 'messages'],
    queryFn: ({ pageParam }) =>
      AdminWordChainService.messages({ limit: MESSAGE_PAGE_SIZE, before: pageParam }),
    initialPageParam: undefined as string | undefined,
    getNextPageParam: nextCursor,
  })
}

export function useWordChainWins(params: WordChainWinsParams) {
  return useInfiniteQuery({
    queryKey: [WORD_CHAIN_KEY, 'wins', params],
    queryFn: ({ pageParam }) =>
      AdminWordChainService.wins({ ...params, limit: WIN_PAGE_SIZE, before: pageParam }),
    initialPageParam: undefined as string | undefined,
    getNextPageParam: nextCursor,
  })
}
