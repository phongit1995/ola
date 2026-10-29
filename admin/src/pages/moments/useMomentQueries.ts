import { App } from 'antd'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminMomentService } from '@/services/adminMoment.service'
import { errorMessage } from '@/lib/apiError'
import {
  MOMENT_PURGE_LOGS_PAGE_SIZE,
  MOMENT_PURGE_LOGS_REFRESH_MS,
  MOMENT_PURGE_RUNNING_REFRESH_MS,
} from './constants'
import type { AdminMoment, AdminMomentDetail, AdminMomentListParams } from '@/types'

export const MOMENTS_QUERY_KEY = 'admin-moments'

export function useMomentList(params: AdminMomentListParams) {
  return useQuery({
    queryKey: [MOMENTS_QUERY_KEY, params],
    queryFn: () => AdminMomentService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useMomentDetail(id: string | null) {
  return useQuery({
    queryKey: [MOMENTS_QUERY_KEY, 'detail', id],
    queryFn: () => AdminMomentService.get(id as string),
    enabled: id != null,
  })
}

export function useSeedMomentDetail() {
  const queryClient = useQueryClient()
  return (page: AdminMoment, pages: AdminMoment[]) => {
    const key = [MOMENTS_QUERY_KEY, 'detail', page.id]
    if (queryClient.getQueryData(key) == null) {
      queryClient.setQueryData<AdminMomentDetail>(key, { ...page, pages })
    }
  }
}

export function useMomentViewers(id: string | null, params: { limit: number; offset: number }) {
  return useQuery({
    queryKey: [MOMENTS_QUERY_KEY, 'viewers', id, params],
    queryFn: () => AdminMomentService.listViewers(id as string, params),
    enabled: id != null,
    placeholderData: (prev) => prev,
  })
}

export function useMomentComments(id: string | null, params: { limit: number; offset: number }) {
  return useQuery({
    queryKey: [MOMENTS_QUERY_KEY, 'comments', id, params],
    queryFn: () => AdminMomentService.listComments(id as string, params),
    enabled: id != null,
    placeholderData: (prev) => prev,
  })
}

export function useToggleMomentStatus() {
  const { message, modal } = App.useApp()
  const queryClient = useQueryClient()
  const mutation = useMutation({
    mutationFn: ({ id, enabled }: { id: string; enabled: boolean }) =>
      AdminMomentService.setStatus(id, enabled),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [MOMENTS_QUERY_KEY] })
    },
  })

  function toggle(moment: AdminMoment, enabled: boolean) {
    modal.confirm({
      title: enabled ? 'Hiện khoảnh khắc này?' : 'Ẩn khoảnh khắc này?',
      content: enabled
        ? 'Khoảnh khắc hiện lại trong khay của người xem nếu vẫn còn hạn 24 giờ.'
        : 'Khoảnh khắc bị ẩn khỏi khay của mọi người. Tác giả vẫn thấy trong trang quản lý nhưng không tự hiện lại được.',
      okText: enabled ? 'Hiện' : 'Ẩn',
      okButtonProps: { danger: !enabled },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await mutation.mutateAsync({ id: moment.id, enabled })
          message.success(enabled ? 'Đã hiện khoảnh khắc' : 'Đã ẩn khoảnh khắc')
        } catch (err) {
          message.error(errorMessage(err, 'Thao tác thất bại'))
        }
      },
    })
  }

  const pendingId = mutation.isPending ? mutation.variables?.id : undefined

  return { toggle, pendingId }
}

export function usePurgeMomentMedia() {
  const { message, modal } = App.useApp()
  const queryClient = useQueryClient()
  const mutation = useMutation({
    mutationFn: (id: string) => AdminMomentService.purgeMedia(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [MOMENTS_QUERY_KEY] })
    },
  })

  function purge(moment: AdminMoment) {
    modal.confirm({
      title: 'Xoá file ảnh/video của khoảnh khắc này?',
      content:
        'File trên bộ nhớ bị xoá vĩnh viễn và không khôi phục được. Bản ghi vẫn giữ lại, tác giả chỉ thấy thông báo ảnh/video đã bị xoá.',
      okText: 'Xoá file',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await mutation.mutateAsync(moment.id)
          message.success('Đã xoá file của khoảnh khắc')
        } catch (err) {
          message.error(errorMessage(err, 'Không xoá được file'))
        }
      },
    })
  }

  const pendingId = mutation.isPending ? mutation.variables : undefined

  return { purge, pendingId }
}

export const MOMENT_PURGE_LOGS_QUERY_KEY = [MOMENTS_QUERY_KEY, 'purge-logs']

export function useMomentPurgeLogs(page: number) {
  const params = {
    limit: MOMENT_PURGE_LOGS_PAGE_SIZE,
    offset: (page - 1) * MOMENT_PURGE_LOGS_PAGE_SIZE,
  }
  return useQuery({
    queryKey: [...MOMENT_PURGE_LOGS_QUERY_KEY, params],
    queryFn: () => AdminMomentService.purgeLogs(params),
    placeholderData: (prev) => prev,
    refetchInterval: (query) =>
      query.state.data?.running ? MOMENT_PURGE_RUNNING_REFRESH_MS : MOMENT_PURGE_LOGS_REFRESH_MS,
  })
}

export function useRunMomentPurge() {
  const { message } = App.useApp()
  const queryClient = useQueryClient()
  const mutation = useMutation({
    mutationFn: () => AdminMomentService.runPurge(),
    onSettled: () => {
      void queryClient.invalidateQueries({ queryKey: MOMENT_PURGE_LOGS_QUERY_KEY })
    },
  })

  async function run() {
    try {
      const result = await mutation.mutateAsync()
      if (result.started) {
        message.success('Đã bắt đầu xoá file, nhật ký cập nhật sau ít giây')
      } else {
        message.info('Đang có một lượt khác chạy, đợi lượt đó xong rồi thử lại')
      }
    } catch (err) {
      message.error(errorMessage(err, 'Không chạy được'))
    }
  }

  return { run, pending: mutation.isPending }
}
