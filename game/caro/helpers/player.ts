import type { PlayerInfo } from '../../src/sdk';

export { avatarIconUrl as avatarIconSrc } from '../../src/sdk/avatar';

export function opponentOf(players: readonly PlayerInfo[], you: number): PlayerInfo | null {
  if (players.length !== 2 || (you !== 0 && you !== 1)) return null;
  return players[1 - you] ?? null;
}
