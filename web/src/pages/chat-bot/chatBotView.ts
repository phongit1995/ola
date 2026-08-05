import { bubbleCorners, bubbleSurface, formatClockHM } from '@lib';
import type { ChatBotMessage } from '@app-types';
import { SUGGESTION_KEYS, VISIBLE_SUGGESTIONS } from './constants';
import type { MessageGrouping } from './interface';
import type { SuggestionKey } from './types';

export function isoOf(createdAt: number): string {
  return new Date(createdAt).toISOString();
}

export function pickSuggestions(): SuggestionKey[] {
  const pool = [...SUGGESTION_KEYS];
  for (let index = pool.length - 1; index > 0; index -= 1) {
    const swap = Math.floor(Math.random() * (index + 1));
    [pool[index], pool[swap]] = [pool[swap]!, pool[index]!];
  }
  return pool.slice(0, VISIBLE_SUGGESTIONS);
}

export function renderableMessages(
  messages: ChatBotMessage[]
): ChatBotMessage[] {
  return messages.filter((message) => message.content !== '');
}

export function groupingOf(
  message: ChatBotMessage,
  prev?: ChatBotMessage,
  next?: ChatBotMessage
): MessageGrouping {
  const isOut = message.role === 'user';
  const boundary = prev == null;
  const firstInGroup = boundary || prev.role !== message.role;
  const lastInGroup = next == null || next.role !== message.role;
  const time = formatClockHM(isoOf(message.createdAt));
  const showTime =
    lastInGroup || formatClockHM(isoOf(next.createdAt)) !== time;

  return {
    isOut,
    firstInGroup,
    lastInGroup,
    spaced: firstInGroup && !boundary,
    showTime,
    time,
    surface: bubbleSurface(isOut, message.status === 'failed'),
    corners: bubbleCorners(isOut, firstInGroup, lastInGroup),
  };
}
