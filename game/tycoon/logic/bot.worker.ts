import { botMove, botRng } from './bot';
import type { BotLevel, GameState, Move } from './types';

export interface BotRequest {
  id: number;
  state: GameState;
  seat: number;
  level: BotLevel;
  seed: number;
  count: number;
}

export interface BotReply {
  id: number;
  move: Move | null;
}

self.addEventListener('message', (event: MessageEvent<BotRequest>) => {
  const { id, state, seat, level, seed, count } = event.data;
  const move = botMove(state, seat, level, botRng(seed, seat, count));
  self.postMessage({ id, move } satisfies BotReply);
});
