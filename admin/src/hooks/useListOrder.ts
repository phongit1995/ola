import { useMutation, useQueryClient, type QueryKey } from '@tanstack/react-query'
import { App } from 'antd'
import { ApiError, errorMessage } from '@/lib/apiError'

const HTTP_CONFLICT = 409

interface ListOrderOptions<T extends { id: string }> {
  items: T[]
  queryKey: QueryKey
  orderKey: keyof T
  reorder: (ids: string[]) => Promise<unknown>
  nameOf: (item: T) => string
}

function applyOrder<T extends { id: string }>(items: T[], ids: string[], orderKey: keyof T): T[] {
  const byId = new Map(items.map((item) => [item.id, item]))
  return ids.flatMap((id, index) => {
    const item = byId.get(id)
    return item == null ? [] : [{ ...item, [orderKey]: index + 1 }]
  })
}

export function useListOrder<T extends { id: string }>({
  items,
  queryKey,
  orderKey,
  reorder,
  nameOf,
}: ListOrderOptions<T>) {
  const { message } = App.useApp()
  const queryClient = useQueryClient()
  const mutation = useMutation({
    mutationFn: reorder,
    onMutate: async (ids) => {
      await queryClient.cancelQueries({ queryKey })
      const previous = queryClient.getQueryData<T[]>(queryKey)
      if (previous != null) queryClient.setQueryData(queryKey, applyOrder(previous, ids, orderKey))
      return { previous }
    },
    onError: (_error, _ids, context) => {
      if (context?.previous != null) queryClient.setQueryData(queryKey, context.previous)
    },
    onSettled: () => queryClient.invalidateQueries({ queryKey }),
  })

  function save(ids: string[], successText = 'Đã lưu thứ tự') {
    mutation.mutate(ids, {
      onSuccess: () => message.success(successText),
      onError: (err) =>
        message.error(
          err instanceof ApiError && err.status === HTTP_CONFLICT
            ? 'Danh sách vừa thay đổi, đã tải lại. Hãy thử lại.'
            : errorMessage(err, 'Không lưu được thứ tự'),
        ),
    })
  }

  function moveToTop(item: T) {
    save(
      [item.id, ...items.filter((other) => other.id !== item.id).map((other) => other.id)],
      `Đã đưa ${nameOf(item)} lên đầu`,
    )
  }

  function renumber() {
    save(
      items.map((item) => item.id),
      `Đã đánh số lại từ 1 đến ${items.length}`,
    )
  }

  return {
    saving: mutation.isPending,
    numbered: items.every((item, index) => item[orderKey] === index + 1),
    nextPosition: items.length + 1,
    isFirst: (item: T) => items[0]?.id === item.id,
    save,
    moveToTop,
    renumber,
  }
}
