import { toRecord } from '../../lib/utils';
import { activeVipTypeId } from '../../lib/vip';
import type {
  WordChainMessage,
  WordChainMessagesResult,
  WordChainState,
} from '../../types/api/wordChain.type';
import type { WordChainGuesses } from '../../types/client/wordChain.type';

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

function withWordChainSenderVip(message: WordChainMessage): WordChainMessage {
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

export function guessesFor(
  state: WordChainState,
  remaining: number
): WordChainGuesses | null {
  if (state.sessionId == null) return null;
  return {
    sessionId: state.sessionId,
    turn: state.turn,
    revision: state.revision,
    remaining,
  };
}

export function newerGuesses(
  current: WordChainGuesses | null,
  incoming: WordChainGuesses | null
): WordChainGuesses | null {
  if (incoming == null) return current;
  if (current != null && current.revision > incoming.revision) return current;
  return incoming;
}

export function hasMoreInSession(
  page: WordChainMessagesResult,
  sessionId: string | undefined
): boolean {
  return (
    page.hasMore && page.items.every((message) => message.sessionId === sessionId)
  );
}
