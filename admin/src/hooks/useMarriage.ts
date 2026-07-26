import { useQuery } from '@tanstack/react-query'
import { AdminMarriageService } from '@/services/adminMarriage.service'
import type {
  MarriageListParams,
  MarriageProposalListParams,
  MarriageStatsParams,
} from '@/types'

const MARRIAGE_STATS_KEY = 'admin-marriage-stats'
const MARRIAGES_KEY = 'admin-marriages'
const MARRIAGE_PROPOSALS_KEY = 'admin-marriage-proposals'

export function useMarriageStats(params: MarriageStatsParams) {
  return useQuery({
    queryKey: [MARRIAGE_STATS_KEY, params],
    queryFn: () => AdminMarriageService.getStats(params),
  })
}

export function useMarriages(params: MarriageListParams) {
  return useQuery({
    queryKey: [MARRIAGES_KEY, params],
    queryFn: () => AdminMarriageService.list(params),
  })
}

export function useMarriageProposals(params: MarriageProposalListParams) {
  return useQuery({
    queryKey: [MARRIAGE_PROPOSALS_KEY, params],
    queryFn: () => AdminMarriageService.listProposals(params),
  })
}
