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

export interface ChatBotState {
  messages: ChatBotMessage[];
  activeTurnId: string | null;
  ownerId: string | null;
  error: ChatBotErrorCode | null;
  beginTurn: (prompt: string) => string;
  appendDelta: (turnId: string, delta: string) => void;
  finishTurn: (turnId: string) => void;
  failTurn: (turnId: string, code: ChatBotErrorCode) => void;
  dropLastTurn: () => string | null;
  syncOwner: (userId: string | null) => void;
  clear: () => void;
}
