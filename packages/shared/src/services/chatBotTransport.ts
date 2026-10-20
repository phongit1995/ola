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

export interface ChatBotErrorBody {
  message: string;
  code?: string;
}

export function parseChatBotErrorBody(body: string, fallback: string): ChatBotErrorBody {
  try {
    const parsed = JSON.parse(body) as { error?: string; code?: string };
    return { message: parsed.error ?? fallback, code: parsed.code };
  } catch {
    return { message: fallback };
  }
}

export interface ChatBotStreamResponse {
  status: number;
  readError: () => Promise<ChatBotErrorBody>;
  readStream: (onChunk: (text: string) => boolean) => Promise<void>;
}

export type ChatBotTransport = (
  request: ChatBotRequest,
  signal: AbortSignal
) => Promise<ChatBotStreamResponse | null>;
