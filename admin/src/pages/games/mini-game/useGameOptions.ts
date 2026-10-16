import { useMemo } from 'react'
import { useMiniGames } from './useMiniGameQueries'
import { GAME_ID_LABEL, gameLabel } from './gameMatchMeta'

export function useGameOptions() {
  const { data: games } = useMiniGames()

  const gameNames = useMemo(() => {
    const names: Record<string, string> = {}
    for (const game of games?.items ?? []) {
      names[game.slug] = game.name
    }
    return names
  }, [games])

  const gameOptions = useMemo(() => {
    const slugs = new Set([
      ...Object.keys(GAME_ID_LABEL),
      ...(games?.items ?? []).map((game) => game.slug),
    ])
    return [...slugs].map((slug) => ({ value: slug, label: gameLabel(slug, gameNames) }))
  }, [games, gameNames])

  return { gameNames, gameOptions }
}
