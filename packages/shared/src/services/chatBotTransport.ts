import type { ChatBotErrorCode } from '../types/client/chatBot.type';
import type { ChatBotRequest } from './chatBot.service';

export class ChatBotStreamError extends Error {
  readonly code: ChatBotErrorCode;

  constructor(code: ChatBotErrorCode, message?: string) {
    super(message ?? code);
    this.name = 'ChatBotStreamError';
    this.code = code;
  }
}

export interface ChatBotStreamResponse {
  status: number;
  readErrorMessage: () => Promise<string>;
  readStream: (onChunk: (text: string) => boolean) => Promise<void>;
}

export type ChatBotTransport = (
  request: ChatBotRequest,
  signal: AbortSignal
) => Promise<ChatBotStreamResponse | null>;
