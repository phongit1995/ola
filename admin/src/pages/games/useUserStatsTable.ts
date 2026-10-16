import { useMemo, useState } from 'react'
import type { TablePaginationConfig } from 'antd/es/table'
import type { SorterResult } from 'antd/es/table/interface'

export const USER_STATS_PAGE_SIZE = 10

export function useUserStatsTable<S extends string>(
  sorts: readonly S[],
  fallback: S,
  mapField: (field: string) => string = (field) => field,
) {
  const [userSort, setUserSort] = useState<S>(fallback)
  const [userPage, setUserPage] = useState(1)
  const [userSearch, setUserSearch] = useState('')

  const userQuery = useMemo(
    () => ({
      userId: userSearch || undefined,
      sortBy: userSort,
      limit: USER_STATS_PAGE_SIZE,
      offset: (userPage - 1) * USER_STATS_PAGE_SIZE,
    }),
    [userSearch, userSort, userPage],
  )

  function onUserTableChange<T>(
    _pagination: TablePaginationConfig,
    _filters: unknown,
    sorter: SorterResult<T> | SorterResult<T>[],
  ) {
    const single = Array.isArray(sorter) ? sorter[0] : sorter
    const field = single?.order ? mapField(String(single.field)) : fallback
    const next = sorts.find((key) => key === field) ?? fallback
    if (next !== userSort) {
      setUserSort(next)
      setUserPage(1)
    }
  }

  return { userSort, userPage, setUserPage, setUserSearch, userQuery, onUserTableChange }
}
