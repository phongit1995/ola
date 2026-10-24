import { App } from 'antd'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminReelService } from '@/services/adminReel.service'
import { errorMessage } from '@/lib/apiError'
import type { AdminReel, AdminReelListParams } from '@/types'

export const REELS_QUERY_KEY = 'admin-reels'

export function useReelList(params: AdminReelListParams) {
  return useQuery({
    queryKey: [REELS_QUERY_KEY, params],
    queryFn: () => AdminReelService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useReelDetail(id: string | null) {
  return useQuery({
    queryKey: [REELS_QUERY_KEY, 'detail', id],
    queryFn: () => AdminReelService.get(id as string),
    enabled: id != null,
  })
}

export function useReelViewers(id: string | null, params: { limit: number; offset: number }) {
  return useQuery({
    queryKey: [REELS_QUERY_KEY, 'viewers', id, params],
    queryFn: () => AdminReelService.listViewers(id as string, params),
    enabled: id != null,
    placeholderData: (prev) => prev,
  })
}

export function useToggleReelStatus() {
  const { message, modal } = App.useApp()
  const queryClient = useQueryClient()
  const mutation = useMutation({
    mutationFn: ({ id, enabled }: { id: string; enabled: boolean }) =>
      AdminReelService.setStatus(id, enabled),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [REELS_QUERY_KEY] })
    },
  })

  function toggle(reel: AdminReel, enabled: boolean) {
    modal.confirm({
      title: enabled ? 'Hiện reel này?' : 'Ẩn reel này?',
      content: enabled
        ? 'Reel hiện lại trong khay của người xem nếu vẫn còn hạn 24 giờ.'
        : 'Reel bị ẩn khỏi khay của mọi người, kể cả tác giả.',
      okText: enabled ? 'Hiện' : 'Ẩn',
      okButtonProps: { danger: !enabled },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await mutation.mutateAsync({ id: reel.id, enabled })
          message.success(enabled ? 'Đã hiện reel' : 'Đã ẩn reel')
        } catch (err) {
          message.error(errorMessage(err, 'Thao tác thất bại'))
        }
      },
    })
  }

  const pendingId = mutation.isPending ? mutation.variables?.id : undefined

  return { toggle, pendingId }
}
