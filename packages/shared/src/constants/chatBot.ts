import type {
  ChatBotErrorCode,
  ChatBotType,
} from '../types/client/chatBot.type';

export const CHAT_BOT_TYPE = {
  olala: 'OLALA',
  olavi: 'OLAVI',
} as const satisfies Record<string, ChatBotType>;

export const CHAT_BOT_DEFAULT_TYPE = CHAT_BOT_TYPE.olala;

export const CHAT_BOT_VISIBLE_SUGGESTIONS = 3;

export interface ChatBotI18n {
  title: string;
  subtitle: string;
  thinking: string;
  placeholder: string;
  emptyTitle: string;
  emptyHint: string | undefined;
  clearConfirm: string;
  suggestions: readonly string[];
  errors: Record<ChatBotErrorCode, string>;
}

const SHARED_ERROR_KEYS = {
  auth: 'chat.chatBotErrorAuth',
  rateLimited: 'chat.chatBotErrorRateLimited',
  network: 'chat.chatBotErrorNetwork',
} as const;

export const CHAT_BOT_I18N = {
  [CHAT_BOT_TYPE.olala]: {
    title: 'chat.chatBot',
    subtitle: 'chat.chatBotSub',
    thinking: 'chat.chatBotThinking',
    placeholder: 'chat.chatBotPlaceholder',
    emptyTitle: 'chat.chatBotEmptyTitle',
    emptyHint: undefined,
    clearConfirm: 'chat.chatBotClearConfirm',
    suggestions: [
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
    ],
    errors: {
      ...SHARED_ERROR_KEYS,
      upstream: 'chat.chatBotErrorUpstream',
      emptyPrompt: 'chat.chatBotErrorUpstream',
    },
  },
  [CHAT_BOT_TYPE.olavi]: {
    title: 'chat.fortuneBot',
    subtitle: 'chat.fortuneBotSub',
    thinking: 'chat.fortuneBotThinking',
    placeholder: 'chat.fortuneBotPlaceholder',
    emptyTitle: 'chat.fortuneBotEmptyTitle',
    emptyHint: 'chat.fortuneBotDisclaimer',
    clearConfirm: 'chat.fortuneBotClearConfirm',
    suggestions: [
      'chat.fortuneBotSuggestion1',
      'chat.fortuneBotSuggestion2',
      'chat.fortuneBotSuggestion3',
      'chat.fortuneBotSuggestion4',
      'chat.fortuneBotSuggestion5',
      'chat.fortuneBotSuggestion6',
      'chat.fortuneBotSuggestion7',
      'chat.fortuneBotSuggestion8',
      'chat.fortuneBotSuggestion9',
      'chat.fortuneBotSuggestion10',
      'chat.fortuneBotSuggestion11',
      'chat.fortuneBotSuggestion12',
      'chat.fortuneBotSuggestion13',
      'chat.fortuneBotSuggestion14',
      'chat.fortuneBotSuggestion15',
      'chat.fortuneBotSuggestion16',
      'chat.fortuneBotSuggestion17',
      'chat.fortuneBotSuggestion18',
      'chat.fortuneBotSuggestion19',
      'chat.fortuneBotSuggestion20',
    ],
    errors: {
      ...SHARED_ERROR_KEYS,
      upstream: 'chat.fortuneBotErrorUpstream',
      emptyPrompt: 'chat.fortuneBotErrorUpstream',
    },
  },
} as const satisfies Record<ChatBotType, ChatBotI18n>;
