export const SOCKET_GUARD_PATH = '/socket.io/';
export const SOCKET_ENVELOPE_EVENT = 'message';
export const SOCKET_PING_EVENT = 'ping';
export const SOCKET_APP_STATE_EVENT = 'app_state';
export const SOCKET_PING_INTERVAL_MS = 60_000;
export const SOCKET_STALE_SILENCE_MS = 30_000;
export const SOCKET_SESSION_REPLACED_EVENT = 'SESSION_REPLACED';
export const SOCKET_FORCE_LOGOUT_EVENT = 'FORCE_LOGOUT';
export const SOCKET_AUTH_CONNECT_ERROR_MESSAGES: readonly string[] = [
  'Unauthorized',
  'session revoked',
  'access_token is required',
];

export const CHAT_SOCKET_EVENTS = {
  message: 'message',
  newMessage: 'NEW_MESSAGE',
  messageUpdated: 'MESSAGE_UPDATED',
  messageDeleted: 'MESSAGE_DELETED',
  reactionUpdated: 'MESSAGE_REACTION_UPDATED',
  conversationCreated: 'CONVERSATION_CREATED',
  conversationUpdated: 'CONVERSATION_UPDATED',
  conversationDeleted: 'CONVERSATION_DELETED',
  userTyping: 'USER_TYPING',
  userStopTyping: 'USER_STOP_TYPING',
} as const;

export const ROOM_SOCKET_EVENTS = {
  message: 'message',
  join: 'ROOM:JOIN',
  leave: 'ROOM:LEAVE',
  newMessage: 'NEW_ROOM_MESSAGE',
  messageDeleted: 'ROOM_MESSAGE_DELETED',
  reactionUpdated: 'ROOM_MESSAGE_REACTION_UPDATED',
  memberJoined: 'ROOM_MEMBER_JOINED',
  memberLeft: 'ROOM_MEMBER_LEFT',
  blockListChanged: 'ROOM_BLOCK_LIST_CHANGED',
} as const;

export const CALL_SOCKET_EVENTS = {
  incoming: 'INCOMING_CALL',
  accepted: 'CALL_ACCEPTED',
  declined: 'CALL_DECLINED',
  ended: 'CALL_ENDED',
} as const;

export const CALL_CONNECT_TIMEOUT_MS = 15_000;
export const CALL_PEER_LEFT_GRACE_MS = 4_000;

export const APP_NOTIFICATION_SOCKET_EVENT = 'APP_NOTIFICATION';

export const KEN_SOCKET_EVENTS = {
  updated: 'KEN_UPDATED',
  chestAvailable: 'KEN_CHEST_AVAILABLE',
  chestClosed: 'KEN_CHEST_CLOSED',
} as const;
