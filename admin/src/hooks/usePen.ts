import { useQuery } from '@tanstack/react-query'
import { AdminPenService } from '@/services/adminPen.service'
import type { PenShotListParams, PenStatsParams } from '@/types'

const PEN_SHOTS_KEY = 'admin-pen-shots'
const PEN_STATS_KEY = 'admin-pen-stats'

export function usePenShots(params: PenShotListParams, enabled = true) {
  return useQuery({
    queryKey: [PEN_SHOTS_KEY, params],
    queryFn: () => AdminPenService.listShots(params),
    enabled,
  })
}

export function usePenStats(params: PenStatsParams, enabled = true) {
  return useQuery({
    queryKey: [PEN_STATS_KEY, params],
    queryFn: () => AdminPenService.getStats(params),
    enabled,
  })
}
