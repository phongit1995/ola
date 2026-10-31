import type { AdminGameMatch, AdminGameMatchPlayer } from '@/types'
import { GAME_ID_LABEL } from './constants'

export function gameLabel(gameId: string, names?: Record<string, string>) {
  return names?.[gameId] ?? GAME_ID_LABEL[gameId] ?? gameId
}

export function matchPlayers(match: AdminGameMatch): AdminGameMatchPlayer[] {
  if (match.players?.length) return match.players
  return [match.player0, match.player1].flatMap((user, seat) => (user ? [{ user, seat }] : []))
}

export function placeLabel(place: number, playerCount: number): string {
  if (place === 1) return 'Nhất'
  if (place === playerCount) return 'Bét'
  if (place === 2) return 'Nhì'
  if (place === 3) return 'Ba'
  return `Hạng ${place}`
}
