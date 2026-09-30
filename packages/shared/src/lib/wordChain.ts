import type { TFunction } from 'i18next';
import {
  WORD_CHAIN_CODE,
  WORD_CHAIN_ERROR_CODE,
  WORD_CHAIN_MESSAGE_TYPE,
} from '../constants/wordChain';
import type {
  WordChainMessage,
  WordChainMessageType,
} from '../types/api/wordChain.type';
import type { WordChainFeedItem } from '../types/client/wordChain.type';
import { toApiError } from './apiError';
import { messageDayKey } from './messageGroups';

const HTTP_CONFLICT = 409;
const HTTP_TOO_MANY_REQUESTS = 429;

const REPLYING_TYPES = new Set<WordChainMessageType>([
  WORD_CHAIN_MESSAGE_TYPE.win,
  WORD_CHAIN_MESSAGE_TYPE.wrongAnswer,
]);

export function lastSyllable(word: string | undefined): string {
  if (word == null) return '';
  return word.split(' ').pop() ?? '';
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

export function wordChainMoveErrorText(t: TFunction, error: unknown): string {
  const apiError = toApiError(error);
  if (apiError.code === WORD_CHAIN_ERROR_CODE.verifyFailed) return t('wordChain.verifyFailed');
  if (apiError.code === WORD_CHAIN_ERROR_CODE.noGuesses) return t('wordChain.noGuesses');
  if (apiError.status === HTTP_CONFLICT) return t('wordChain.busy');
  if (apiError.status === HTTP_TOO_MANY_REQUESTS) return t('wordChain.tooFast');
  return t('wordChain.sendError');
}

export function wordChainLookupErrorText(t: TFunction, error: unknown): string {
  const apiError = toApiError(error);
  if (apiError.code === WORD_CHAIN_ERROR_CODE.cooldown) return t('wordChain.lookupCooldown');
  return t('wordChain.lookupError');
}
