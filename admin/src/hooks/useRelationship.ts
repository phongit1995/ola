import { useQuery } from '@tanstack/react-query'
import { AdminRelationshipService } from '@/services/adminRelationship.service'
import type {
  FollowListParams,
  RelationshipListParams,
  RelationshipStatsParams,
  RelationshipUserStatsParams,
} from '@/types'

const RELATIONSHIP_STATS_KEY = 'admin-relationship-stats'
const RELATIONSHIPS_KEY = 'admin-relationships'
const FOLLOWS_KEY = 'admin-relationship-follows'
const RELATIONSHIP_USER_STATS_KEY = 'admin-relationship-user-stats'

export function useRelationshipStats(params: RelationshipStatsParams) {
  return useQuery({
    queryKey: [RELATIONSHIP_STATS_KEY, params],
    queryFn: () => AdminRelationshipService.getStats(params),
  })
}

export function useRelationships(params: RelationshipListParams) {
  return useQuery({
    queryKey: [RELATIONSHIPS_KEY, params],
    queryFn: () => AdminRelationshipService.list(params),
  })
}

export function useFollows(params: FollowListParams) {
  return useQuery({
    queryKey: [FOLLOWS_KEY, params],
    queryFn: () => AdminRelationshipService.listFollows(params),
  })
}

export function useRelationshipUserStats(params: RelationshipUserStatsParams) {
  return useQuery({
    queryKey: [RELATIONSHIP_USER_STATS_KEY, params],
    queryFn: () => AdminRelationshipService.getUserStats(params),
  })
}
