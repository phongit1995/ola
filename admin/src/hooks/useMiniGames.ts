import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminMiniGameService } from '@/services/adminMiniGame.service'
import type { CreateMiniGameRequest, UpdateMiniGameRequest } from '@/types'

const MINI_GAMES_KEY = 'admin-mini-games'

export function useMiniGames() {
  return useQuery({
    queryKey: [MINI_GAMES_KEY],
    queryFn: () => AdminMiniGameService.list(),
    placeholderData: (prev) => prev,
  })
}

export function useCreateMiniGame() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateMiniGameRequest) => AdminMiniGameService.create(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [MINI_GAMES_KEY] })
    },
  })
}

export function useUpdateMiniGame() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateMiniGameRequest }) =>
      AdminMiniGameService.update(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [MINI_GAMES_KEY] })
    },
  })
}

export function useDeleteMiniGame() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminMiniGameService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [MINI_GAMES_KEY] })
    },
  })
}
