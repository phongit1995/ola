import { useQuery } from '@tanstack/react-query'
import { AdminPenService } from '@/services/adminPen.service'
import type {
  PenShotListParams,
  PenSideStatsParams,
  PenStatsParams,
  PenUserStatsParams,
} from '@/types'

const PEN_SHOTS_KEY = 'admin-pen-shots'
const PEN_STATS_KEY = 'admin-pen-stats'
const PEN_USER_STATS_KEY = 'admin-pen-user-stats'
const PEN_SIDE_STATS_KEY = 'admin-pen-side-stats'

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

export function usePenUserStats(params: PenUserStatsParams, enabled = true) {
  return useQuery({
    queryKey: [PEN_USER_STATS_KEY, params],
    queryFn: () => AdminPenService.getUserStats(params),
    enabled,
  })
}

export function usePenSideStats(params: PenSideStatsParams, enabled = true) {
  return useQuery({
    queryKey: [PEN_SIDE_STATS_KEY, params],
    queryFn: () => AdminPenService.getSideStats(params),
    enabled,
  })
}
