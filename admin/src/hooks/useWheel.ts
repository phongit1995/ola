import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminWheelService } from '@/services/adminWheel.service'
import type {
  CreateWheelRequest,
  SaveWheelConfigRequest,
  UpdateWheelRequest,
  WheelSpinListParams,
  WheelStatsParams,
  WheelUserStatsParams,
  WheelVipStatsParams,
} from '@/types'

const WHEELS_KEY = 'admin-wheels'
const WHEEL_SPINS_KEY = 'admin-wheel-spins'
const WHEEL_STATS_KEY = 'admin-wheel-stats'
const WHEEL_USER_STATS_KEY = 'admin-wheel-user-stats'
const WHEEL_VIP_STATS_KEY = 'admin-wheel-vip-stats'

export function useWheels() {
  return useQuery({
    queryKey: [WHEELS_KEY],
    queryFn: () => AdminWheelService.listWheels(),
  })
}

export function useWheelSpins(params: WheelSpinListParams, enabled = true) {
  return useQuery({
    queryKey: [WHEEL_SPINS_KEY, params],
    queryFn: () => AdminWheelService.listSpins(params),
    enabled,
  })
}

export function useWheelStats(params: WheelStatsParams, enabled = true) {
  return useQuery({
    queryKey: [WHEEL_STATS_KEY, params],
    queryFn: () => AdminWheelService.getStats(params),
    enabled,
  })
}

export function useWheelUserStats(params: WheelUserStatsParams, enabled = true) {
  return useQuery({
    queryKey: [WHEEL_USER_STATS_KEY, params],
    queryFn: () => AdminWheelService.getUserStats(params),
    enabled,
  })
}

export function useWheelVipStats(params: WheelVipStatsParams, enabled = true) {
  return useQuery({
    queryKey: [WHEEL_VIP_STATS_KEY, params],
    queryFn: () => AdminWheelService.getVipStats(params),
    enabled,
  })
}

export function useCreateWheel() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateWheelRequest) => AdminWheelService.createWheel(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [WHEELS_KEY] })
    },
  })
}

export function useUpdateWheel() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateWheelRequest }) =>
      AdminWheelService.updateWheel(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [WHEELS_KEY] })
    },
  })
}

export function useDeleteWheel() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminWheelService.removeWheel(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [WHEELS_KEY] })
    },
  })
}

export function useSaveWheelConfig() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: SaveWheelConfigRequest }) =>
      AdminWheelService.saveConfig(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [WHEELS_KEY] })
    },
  })
}
