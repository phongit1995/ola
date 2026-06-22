import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminEggService } from '@/services/adminEgg.service'
import type {
  CreateEggPackRequest,
  EggDrawListParams,
  SaveEggConfigRequest,
  UpdateEggPackRequest,
} from '@/types'

const EGG_PACKS_KEY = 'admin-egg-packs'
const EGG_DRAWS_KEY = 'admin-egg-draws'

export function useEggDraws(params: EggDrawListParams, enabled = true) {
  return useQuery({
    queryKey: [EGG_DRAWS_KEY, params],
    queryFn: () => AdminEggService.listDraws(params),
    enabled,
  })
}

export function useEggPacks() {
  return useQuery({
    queryKey: [EGG_PACKS_KEY],
    queryFn: () => AdminEggService.listPacks(),
  })
}

export function useCreateEggPack() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateEggPackRequest) => AdminEggService.createPack(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [EGG_PACKS_KEY] })
    },
  })
}

export function useUpdateEggPack() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateEggPackRequest }) =>
      AdminEggService.updatePack(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [EGG_PACKS_KEY] })
    },
  })
}

export function useDeleteEggPack() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminEggService.removePack(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [EGG_PACKS_KEY] })
    },
  })
}

export function useSaveEggConfig() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: SaveEggConfigRequest }) =>
      AdminEggService.saveConfig(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [EGG_PACKS_KEY] })
    },
  })
}
