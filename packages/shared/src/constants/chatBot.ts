import type { ChatBotErrorCode } from '../types/client/chatBot.type';

export const CHAT_BOT_SUGGESTION_KEYS = [
  'chat.chatBotSuggestion1',
  'chat.chatBotSuggestion2',
  'chat.chatBotSuggestion3',
  'chat.chatBotSuggestion4',
  'chat.chatBotSuggestion5',
  'chat.chatBotSuggestion6',
  'chat.chatBotSuggestion7',
  'chat.chatBotSuggestion8',
  'chat.chatBotSuggestion9',
  'chat.chatBotSuggestion10',
  'chat.chatBotSuggestion11',
  'chat.chatBotSuggestion12',
  'chat.chatBotSuggestion13',
  'chat.chatBotSuggestion14',
  'chat.chatBotSuggestion15',
  'chat.chatBotSuggestion16',
  'chat.chatBotSuggestion17',
  'chat.chatBotSuggestion18',
  'chat.chatBotSuggestion19',
  'chat.chatBotSuggestion20',
] as const;

export const CHAT_BOT_VISIBLE_SUGGESTIONS = 3;

export const CHAT_BOT_ERROR_KEYS = {
  auth: 'chat.chatBotErrorAuth',
  rateLimited: 'chat.chatBotErrorRateLimited',
  upstream: 'chat.chatBotErrorUpstream',
  network: 'chat.chatBotErrorNetwork',
  emptyPrompt: 'chat.chatBotErrorUpstream',
} as const satisfies Record<ChatBotErrorCode, string>;
