export type ChatBotType = 'OLALA' | 'OLAVI';

export type ChatBotRole = 'user' | 'assistant' | 'system';

export type ChatBotMessageStatus = 'streaming' | 'done' | 'failed';

export interface ChatBotMessage {
  id: string;
  role: ChatBotRole;
  content: string;
  createdAt: number;
  status: ChatBotMessageStatus;
}

export interface ChatBotPromptMessage {
  role: ChatBotRole;
  content: string;
}

export interface ChatBotFrame {
  id?: string;
  delta?: string;
  finishReason?: string;
  error?: string;
}

export type ChatBotErrorCode =
  | 'auth'
  | 'rateLimited'
  | 'upstream'
  | 'network'
  | 'emptyPrompt';

export type ChatBotSurfaceKind = 'out' | 'in' | 'failed';

export interface ChatBotViewer {
  name: string;
  color: string;
  avatar?: string;
}

export interface ChatBotGrouping {
  isOut: boolean;
  firstInGroup: boolean;
  lastInGroup: boolean;
  spaced: boolean;
  showTime: boolean;
  time: string;
  corners: string;
  surfaceKind: ChatBotSurfaceKind;
}

export interface ChatBotConversation {
  messages: ChatBotMessage[];
  activeTurnId: string | null;
  error: ChatBotErrorCode | null;
}

export interface ChatBotState {
  conversations: Record<ChatBotType, ChatBotConversation>;
  ownerId: string | null;
  beginTurn: (bot: ChatBotType, prompt: string) => string;
  appendDelta: (bot: ChatBotType, turnId: string, delta: string) => void;
  finishTurn: (bot: ChatBotType, turnId: string) => void;
  failTurn: (bot: ChatBotType, turnId: string, code: ChatBotErrorCode) => void;
  dropLastTurn: (bot: ChatBotType) => string | null;
  syncOwner: (userId: string | null) => void;
  clear: (bot: ChatBotType) => void;
}
