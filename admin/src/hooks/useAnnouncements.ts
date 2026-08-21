import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminAnnouncementService } from '@/services/adminAnnouncement.service'
import type { CreateAnnouncementRequest, UpdateAnnouncementRequest } from '@/types'

const ANNOUNCEMENTS_KEY = 'admin-announcements'

export function useAnnouncements() {
  return useQuery({
    queryKey: [ANNOUNCEMENTS_KEY],
    queryFn: () => AdminAnnouncementService.list(),
    placeholderData: (prev) => prev,
  })
}

export function useCreateAnnouncement() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateAnnouncementRequest) => AdminAnnouncementService.create(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [ANNOUNCEMENTS_KEY] })
    },
  })
}

export function useUpdateAnnouncement() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateAnnouncementRequest }) =>
      AdminAnnouncementService.update(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [ANNOUNCEMENTS_KEY] })
    },
  })
}

export function useDeleteAnnouncement() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminAnnouncementService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [ANNOUNCEMENTS_KEY] })
    },
  })
}
