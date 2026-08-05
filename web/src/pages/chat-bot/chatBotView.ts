import { formatClockHM } from '@lib';
import type { ChatBotMessage } from '@app-types';
import {
  BOT_SURFACE_FAILED,
  BOT_SURFACE_IN,
  BOT_SURFACE_OUT,
  SUGGESTION_KEYS,
  VISIBLE_SUGGESTIONS,
} from './constants';

export type SuggestionKey = (typeof SUGGESTION_KEYS)[number];

export interface ChatBotViewer {
  name: string;
  color: string;
  avatar?: string;
}

export interface MessageGrouping {
  isOut: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  spaced: boolean;
  showTime: boolean;
  time: string;
  surface: string;
  corners: string;
}

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
  const failed = message.status === 'failed';

  return {
    isOut,
    firstInGroup,
    lastInGroup,
    spaced: firstInGroup && !boundary,
    showTime,
    time,
    surface: failed
      ? BOT_SURFACE_FAILED
      : isOut
        ? BOT_SURFACE_OUT
        : BOT_SURFACE_IN,
    corners: isOut
      ? `${firstInGroup ? '' : 'rounded-tr-sm'} ${lastInGroup ? '' : 'rounded-br-sm'}`
      : `${firstInGroup ? '' : 'rounded-tl-sm'} ${lastInGroup ? '' : 'rounded-bl-sm'}`,
  };
}
