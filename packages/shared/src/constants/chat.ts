export const CHAT_MESSAGE_PAGE_SIZE = 50;
export const CHAT_REPLY_EXCERPT_MAX_RUNES = 120;
export const CHAT_PEER_CARD_LONG_CHAT_SHOW_RATE = 0.3;
export const CHAT_TYPING_TTL_MS = 3_000;
export const CHAT_TYPING_THROTTLE_MS = 2_000;
export const CHAT_MARK_READ_DEBOUNCE_MS = 400;
export const CHAT_MARK_READ_MAX_WAIT_MS = 1_500;

export const CHAT_POLICY_ERROR_CODES = {
  messageBlocked: 'MESSAGE_BLOCKED',
  friendsOnly: 'MESSAGE_FRIENDS_ONLY',
  recipientUnavailable: 'DIRECT_RECIPIENT_UNAVAILABLE',
} as const;
