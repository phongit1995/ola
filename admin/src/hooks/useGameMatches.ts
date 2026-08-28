import { useQuery } from '@tanstack/react-query'
import { AdminGameMatchService } from '@/services/adminGameMatch.service'
import type {
  GameLevelListParams,
  GameMatchListParams,
  GameMatchStatsParams,
  GameMatchSuspectsParams,
} from '@/types'

const GAME_MATCHES_KEY = 'admin-game-matches'
const GAME_MATCH_STATS_KEY = 'admin-game-match-stats'
const GAME_MATCH_SUSPECTS_KEY = 'admin-game-match-suspects'
const GAME_LEVELS_KEY = 'admin-game-levels'

export function useGameMatches(params: GameMatchListParams, enabled = true) {
  return useQuery({
    queryKey: [GAME_MATCHES_KEY, params],
    queryFn: () => AdminGameMatchService.listMatches(params),
    enabled,
  })
}

export function useGameMatchStats(params: GameMatchStatsParams, enabled = true) {
  return useQuery({
    queryKey: [GAME_MATCH_STATS_KEY, params],
    queryFn: () => AdminGameMatchService.getStats(params),
    enabled,
  })
}

export function useGameMatchSuspects(params: GameMatchSuspectsParams, enabled = true) {
  return useQuery({
    queryKey: [GAME_MATCH_SUSPECTS_KEY, params],
    queryFn: () => AdminGameMatchService.getSuspects(params),
    enabled,
  })
}

export function useGameLevels(params: GameLevelListParams, enabled = true) {
  return useQuery({
    queryKey: [GAME_LEVELS_KEY, params],
    queryFn: () => AdminGameMatchService.listLevels(params),
    enabled,
  })
}
