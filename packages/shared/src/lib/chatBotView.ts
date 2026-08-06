import {
  CHAT_BOT_I18N,
  CHAT_BOT_VISIBLE_SUGGESTIONS,
} from '../constants/chatBot';
import type {
  ChatBotGrouping,
  ChatBotMessage,
  ChatBotSurfaceKind,
  ChatBotType,
} from '../types/client/chatBot.type';
import { formatClockHM } from './datetime';

export type ChatBotSuggestionKey =
  (typeof CHAT_BOT_I18N)[ChatBotType]['suggestions'][number];

export function chatBotIso(createdAt: number): string {
  return new Date(createdAt).toISOString();
}

export function pickChatBotSuggestions(bot: ChatBotType): ChatBotSuggestionKey[] {
  const pool = [...CHAT_BOT_I18N[bot].suggestions];
  for (let index = pool.length - 1; index > 0; index -= 1) {
    const swap = Math.floor(Math.random() * (index + 1));
    [pool[index], pool[swap]] = [pool[swap]!, pool[index]!];
  }
  return pool.slice(0, CHAT_BOT_VISIBLE_SUGGESTIONS);
}

export function renderableChatBotMessages(
  messages: ChatBotMessage[]
): ChatBotMessage[] {
  return messages.filter((message) => message.content !== '');
}

function surfaceKindOf(
  isOut: boolean,
  status: ChatBotMessage['status']
): ChatBotSurfaceKind {
  if (status === 'failed') return 'failed';
  return isOut ? 'out' : 'in';
}

function cornersOf(
  isOut: boolean,
  firstInGroup: boolean,
  lastInGroup: boolean
): string {
  const top = firstInGroup ? '' : isOut ? 'rounded-tr-sm' : 'rounded-tl-sm';
  const bottom = lastInGroup ? '' : isOut ? 'rounded-br-sm' : 'rounded-bl-sm';
  return `${top} ${bottom}`;
}

export function chatBotGrouping(
  message: ChatBotMessage,
  prev?: ChatBotMessage,
  next?: ChatBotMessage
): ChatBotGrouping {
  const isOut = message.role === 'user';
  const boundary = prev == null;
  const firstInGroup = boundary || prev.role !== message.role;
  const lastInGroup = next == null || next.role !== message.role;
  const time = formatClockHM(chatBotIso(message.createdAt));
  const showTime =
    lastInGroup || formatClockHM(chatBotIso(next.createdAt)) !== time;

  return {
    isOut,
    firstInGroup,
    lastInGroup,
    spaced: firstInGroup && !boundary,
    showTime,
    time,
    corners: cornersOf(isOut, firstInGroup, lastInGroup),
    surfaceKind: surfaceKindOf(isOut, message.status),
  };
}
