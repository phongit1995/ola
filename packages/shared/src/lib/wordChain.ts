import type { TFunction } from 'i18next';
import {
  WORD_CHAIN_CODE,
  WORD_CHAIN_ERROR_CODE,
  WORD_CHAIN_MESSAGE_TYPE,
} from '../constants/wordChain';
import type {
  WordChainLeaderboardQuery,
  WordChainMessage,
  WordChainMessageType,
  WordChainState,
} from '../types/api/wordChain.type';
import type {
  WordChainFeedItem,
  WordChainGuesses,
  WordChainInputLock,
  WordChainLeaderboardKey,
  WordChainMoveStatus,
  WordChainTurnRef,
} from '../types/client/wordChain.type';
import { toApiError } from './apiError';
import { messageDayKey } from './messageGroups';

const HTTP_CONFLICT = 409;
const HTTP_TOO_MANY_REQUESTS = 429;

const REPLYING_TYPES = new Set<WordChainMessageType>([
  WORD_CHAIN_MESSAGE_TYPE.win,
  WORD_CHAIN_MESSAGE_TYPE.wrongAnswer,
]);

const MOVE_STATUS_BY_CODE = {
  [WORD_CHAIN_CODE.ok]: 'correct',
  [WORD_CHAIN_CODE.win]: 'win',
  [WORD_CHAIN_CODE.invalidFormat]: 'warning',
  [WORD_CHAIN_CODE.mismatch]: 'error',
  [WORD_CHAIN_CODE.repeated]: 'error',
  [WORD_CHAIN_CODE.notInDict]: 'error',
} as const satisfies Record<string, WordChainMoveStatus>;

export function lastSyllable(word: string | undefined): string {
  if (word == null) return '';
  return word.split(' ').pop() ?? '';
}

export function wordChainLeaderboardKey({
  sort,
  period,
}: WordChainLeaderboardQuery): WordChainLeaderboardKey {
  return `${sort}:${period}`;
}

export function isSameWordChainTurn(
  a: WordChainTurnRef | null | undefined,
  b: WordChainTurnRef | null | undefined
): boolean {
  return (
    a != null && b != null && a.sessionId === b.sessionId && a.turn === b.turn
  );
}

export function sessionMessages(
  messages: WordChainMessage[],
  sessionId: string | undefined
): WordChainMessage[] {
  if (sessionId == null) return [];
  return messages.filter((message) => message.sessionId === sessionId);
}

export function remainingGuesses(
  state: WordChainState | null,
  guesses: WordChainGuesses | null
): number {
  if (state == null) return 0;
  return guesses != null && isSameWordChainTurn(guesses, state)
    ? guesses.remaining
    : state.guessLimit;
}

export function wordChainInputLock(
  state: WordChainState | null,
  guesses: WordChainGuesses | null,
  userId: string | undefined
): WordChainInputLock | null {
  if (userId != null && userId !== '' && state?.wordOwnerId === userId) {
    return 'waitTurn';
  }
  return remainingGuesses(state, guesses) === 0 ? 'noGuesses' : null;
}

export function wordChainMoveStatus(
  message: Pick<WordChainMessage, 'code'>
): WordChainMoveStatus | undefined {
  return message.code == null ? undefined : MOVE_STATUS_BY_CODE[message.code];
}

export function buildWordChainFeed(
  messages: WordChainMessage[]
): WordChainFeedItem[] {
  const items: WordChainFeedItem[] = [];
  let lastDay = '';
  messages.forEach((message, index) => {
    const day = messageDayKey(message.createdAt);
    if (day !== lastDay) {
      items.push({ kind: 'date', key: `date-${message.id}`, createdAt: message.createdAt });
      lastDay = day;
    }
    const previous = messages[index - 1];
    const replyTo =
      REPLYING_TYPES.has(message.type) &&
      previous?.type === WORD_CHAIN_MESSAGE_TYPE.move &&
      previous.seq === message.seq - 1
        ? previous
        : undefined;
    items.push({ kind: 'message', key: message.id, message, replyTo });
  });
  return items;
}

export function wordChainWrongReason(
  t: TFunction,
  message: WordChainMessage
): string {
  const syllable = message.requiredSyllable ?? '';
  switch (message.code) {
    case WORD_CHAIN_CODE.invalidFormat:
      return t('wordChain.wrongInvalidFormat', { syllable });
    case WORD_CHAIN_CODE.mismatch:
      return t('wordChain.wrongMismatch', { syllable });
    case WORD_CHAIN_CODE.repeated:
      return t('wordChain.wrongRepeated');
    default:
      return t('wordChain.wrongNotInDict');
  }
}

export function wordChainGuessesText(t: TFunction, remaining: number): string {
  return remaining > 0
    ? t('wordChain.guessesLeft', { value: remaining })
    : t('wordChain.noGuesses');
}

function wordChainCommonErrorText(t: TFunction, code: string | undefined): string | null {
  switch (code) {
    case WORD_CHAIN_ERROR_CODE.disabled:
      return t('wordChain.disabled');
    case WORD_CHAIN_ERROR_CODE.verifyFailed:
      return t('wordChain.verifyFailed');
    case WORD_CHAIN_ERROR_CODE.noGuesses:
      return t('wordChain.noGuesses');
    case WORD_CHAIN_ERROR_CODE.waitTurn:
      return t('wordChain.waitTurn');
    case WORD_CHAIN_ERROR_CODE.wordChanged:
      return t('wordChain.wordChanged');
    case WORD_CHAIN_ERROR_CODE.unavailable:
      return t('wordChain.unavailable');
    default:
      return null;
  }
}

export function wordChainMoveErrorText(t: TFunction, error: unknown): string {
  const apiError = toApiError(error);
  const common = wordChainCommonErrorText(t, apiError.code);
  if (common != null) return common;
  if (apiError.status === HTTP_CONFLICT) return t('wordChain.busy');
  if (apiError.status === HTTP_TOO_MANY_REQUESTS) return t('wordChain.tooFast');
  return t('wordChain.sendError');
}

export function wordChainHintErrorText(t: TFunction, error: unknown): string {
  const apiError = toApiError(error);
  if (apiError.code === WORD_CHAIN_ERROR_CODE.kenShort) return t('wordChain.hintKenShort');
  if (apiError.code === WORD_CHAIN_ERROR_CODE.noHint) return t('wordChain.hintNone');
  const common = wordChainCommonErrorText(t, apiError.code);
  if (common != null) return common;
  if (apiError.status === HTTP_CONFLICT) return t('wordChain.busy');
  if (apiError.status === HTTP_TOO_MANY_REQUESTS) return t('wordChain.tooFast');
  return t('wordChain.hintError');
}

export function wordChainLookupErrorText(t: TFunction, error: unknown): string {
  const apiError = toApiError(error);
  if (apiError.code === WORD_CHAIN_ERROR_CODE.cooldown) return t('wordChain.lookupCooldown');
  return t('wordChain.lookupError');
}
