import { activeVipTypeId } from '../../lib/vip';
import type {
  WordChainMessage,
  WordChainState,
} from '../../types/api/wordChain.type';
import type { WordChainGuesses } from '../../types/client/wordChain.type';
import { toRecord } from '../room/roomHelpers';

export function toWordChainMessage(value: unknown): WordChainMessage | null {
  const record = toRecord(value);
  if (
    record == null ||
    typeof record.id !== 'string' ||
    typeof record.seq !== 'number' ||
    typeof record.sessionId !== 'string'
  ) {
    return null;
  }
  return record as unknown as WordChainMessage;
}

export function toWordChainState(value: unknown): WordChainState | null {
  const record = toRecord(value);
  if (record == null || typeof record.revision !== 'number') return null;
  return record as unknown as WordChainState;
}

export function withWordChainSenderVip(
  message: WordChainMessage
): WordChainMessage {
  return {
    ...message,
    senderVipTypeId: activeVipTypeId(message.senderVip, message.senderVipEnd),
  };
}

export function mergeWordChainMessages(
  current: WordChainMessage[],
  incoming: WordChainMessage[]
): WordChainMessage[] {
  if (incoming.length === 0) return current;
  const byId = new Map(current.map((message) => [message.id, message]));
  for (const message of incoming) {
    byId.set(message.id, withWordChainSenderVip(message));
  }
  return [...byId.values()].sort((a, b) => a.seq - b.seq);
}

export function withLatestPage(
  current: WordChainMessage[],
  page: WordChainMessage[]
): WordChainMessage[] {
  const newestSeq = page.reduce((max, message) => Math.max(max, message.seq), 0);
  const newer = current.filter((message) => message.seq > newestSeq);
  return mergeWordChainMessages(newer, page);
}

export function isNewerWordChainState(
  current: WordChainState | null,
  incoming: WordChainState
): boolean {
  return current == null || incoming.revision > current.revision;
}

export function sessionMessages(
  messages: WordChainMessage[],
  sessionId: string | undefined
): WordChainMessage[] {
  if (sessionId == null) return [];
  return messages.filter((message) => message.sessionId === sessionId);
}

export function guessesFor(
  state: WordChainState,
  remaining: number
): WordChainGuesses | null {
  if (state.sessionId == null) return null;
  return { sessionId: state.sessionId, turn: state.turn, remaining };
}

export function remainingGuesses(
  state: WordChainState | null,
  guesses: WordChainGuesses | null
): number {
  if (state == null) return 0;
  if (
    guesses != null &&
    guesses.sessionId === state.sessionId &&
    guesses.turn === state.turn
  ) {
    return guesses.remaining;
  }
  return state.guessLimit;
}
