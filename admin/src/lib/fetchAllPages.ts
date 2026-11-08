import { ALL_PAGES_LIMIT } from '@/lib/constants'
import type { ListResult } from '@/types'

export async function fetchAllPages<T>(
  fetchPage: (params: { limit: number; offset: number }) => Promise<ListResult<T>>,
): Promise<T[]> {
  const items: T[] = []
  for (;;) {
    const page = await fetchPage({ limit: ALL_PAGES_LIMIT, offset: items.length })
    items.push(...page.items)
    if (page.items.length === 0 || items.length >= page.total) return items
  }
}
