import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminRoomService } from '@/services/adminRoom.service'
import type { CreateRoomRequest, ListParams, UpdateRoomRequest } from '@/types'

const ROOMS_KEY = 'admin-rooms'

export function useRooms(params: ListParams) {
  return useQuery({
    queryKey: [ROOMS_KEY, params],
    queryFn: () => AdminRoomService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useRoomMessages(id: string | null) {
  return useQuery({
    queryKey: [ROOMS_KEY, 'messages', id],
    queryFn: () => AdminRoomService.messages(id as string, { limit: 100 }),
    enabled: id != null,
  })
}

export function useCreateRoom() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateRoomRequest) => AdminRoomService.create(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [ROOMS_KEY] })
    },
  })
}

export function useUpdateRoom() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateRoomRequest }) =>
      AdminRoomService.update(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [ROOMS_KEY] })
    },
  })
}

export function useDeleteRoom() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminRoomService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [ROOMS_KEY] })
    },
  })
}
