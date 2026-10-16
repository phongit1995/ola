import { GAME_ID_LABEL } from './constants'

export function gameLabel(gameId: string, names?: Record<string, string>) {
  return names?.[gameId] ?? GAME_ID_LABEL[gameId] ?? gameId
}
