import { apiPathOf, signApiGuard } from '../api/apiGuardSigner';
import { env } from '../config/env';
import { authTokens } from '../lib/tokenStorage';
import type {
  ChatBotErrorCode,
  ChatBotFrame,
  ChatBotMessage,
  ChatBotPromptMessage,
  ChatBotType,
} from '../types/client/chatBot.type';

export const CHAT_BOT_PATH = '/chat-bot';
export const CHAT_BOT_HISTORY_TURNS = 40;
export const CHAT_BOT_HISTORY_LIMIT = CHAT_BOT_HISTORY_TURNS * 2;
export const CHAT_BOT_SSE_DONE = '[DONE]';

const SSE_DATA_PREFIX = 'data: ';
const SSE_FRAME_SEPARATOR = '\n\n';

export interface ChatBotRequest {
  url: string;
  init: RequestInit;
}

export function buildChatBotRequest(
  messages: ChatBotPromptMessage[],
  bot: ChatBotType,
  language?: string,
  accessToken?: string
): ChatBotRequest {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    Accept: 'text/event-stream',
  };

  const token = accessToken ?? authTokens.getAccessToken();
  if (token != null && token !== '') {
    headers.Authorization = `Bearer ${token}`;
  }

  if (language != null && language !== '') {
    headers['Accept-Language'] = language;
  }

  const signed = signApiGuard('POST', apiPathOf(CHAT_BOT_PATH));
  if (signed != null) {
    headers['X-Timestamp'] = signed.timestamp;
    headers['X-Nonce'] = signed.nonce;
    headers['X-Signature'] = signed.signature;
  }

  return {
    url: `${env.apiUrl.replace(/\/$/, '')}${CHAT_BOT_PATH}`,
    init: {
      method: 'POST',
      headers,
      body: JSON.stringify({ messages, type: bot, stream: true }),
    },
  };
}

export interface ParsedChatBotFrames {
  frames: ChatBotFrame[];
  done: boolean;
  rest: string;
}

export function parseChatBotFrames(buffer: string): ParsedChatBotFrames {
  const frames: ChatBotFrame[] = [];
  let done = false;
  let rest = buffer;

  for (;;) {
    const separatorAt = rest.indexOf(SSE_FRAME_SEPARATOR);
    if (separatorAt < 0) break;

    const raw = rest.slice(0, separatorAt).trim();
    rest = rest.slice(separatorAt + SSE_FRAME_SEPARATOR.length);
    if (!raw.startsWith(SSE_DATA_PREFIX)) continue;

    const payload = raw.slice(SSE_DATA_PREFIX.length).trim();
    if (payload === CHAT_BOT_SSE_DONE) {
      done = true;
      continue;
    }

    try {
      frames.push(JSON.parse(payload) as ChatBotFrame);
    } catch {
      continue;
    }
  }

  return { frames, done, rest };
}

export function chatBotErrorForStatus(status: number): ChatBotErrorCode {
  if (status === 401 || status === 403 || status === 423) return 'auth';
  if (status === 429) return 'rateLimited';
  return 'upstream';
}

export function chatBotHistory(
  messages: ChatBotMessage[]
): ChatBotPromptMessage[] {
  return messages
    .filter((message) => message.status !== 'failed' && message.content !== '')
    .slice(-CHAT_BOT_HISTORY_LIMIT)
    .map(({ role, content }) => ({ role, content }));
}
