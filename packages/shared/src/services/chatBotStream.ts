import { ensureFreshToken, refreshAccessToken } from '../api';
import type {
  ChatBotPromptMessage,
  ChatBotType,
} from '../types/client/chatBot.type';
import {
  buildChatBotRequest,
  chatBotErrorForStatus,
  parseChatBotFrames,
} from './chatBot.service';
import { ChatBotStreamError, type ChatBotStreamResponse, type ChatBotTransport } from './chatBotTransport';

export * from './chatBotTransport';

export interface StreamChatBotOptions {
  bot: ChatBotType;
  messages: ChatBotPromptMessage[];
  language?: string;
  signal: AbortSignal;
  onDelta: (delta: string) => void;
  transport: ChatBotTransport;
}

async function openStream(
  { bot, messages, language, signal, transport }: Omit<StreamChatBotOptions, 'onDelta'>,
  accessToken: string
): Promise<ChatBotStreamResponse | null> {
  const response = await transport(
    buildChatBotRequest(messages, bot, language, accessToken),
    signal
  );
  if (response == null || response.status !== 401) return response;

  let refreshed: string;
  try {
    refreshed = await refreshAccessToken();
  } catch {
    throw new ChatBotStreamError('auth', await response.readErrorMessage());
  }

  return transport(buildChatBotRequest(messages, bot, language, refreshed), signal);
}

export async function streamChatBot({
  bot,
  messages,
  language,
  signal,
  onDelta,
  transport,
}: StreamChatBotOptions): Promise<boolean> {
  const accessToken = await ensureFreshToken();
  if (accessToken === '') throw new ChatBotStreamError('auth');

  const response = await openStream(
    { bot, messages, language, signal, transport },
    accessToken
  );
  if (response == null) return false;

  if (response.status < 200 || response.status >= 300) {
    const message = await response.readErrorMessage();
    throw new ChatBotStreamError(
      chatBotErrorForStatus(response.status),
      message
    );
  }

  let buffer = '';
  let completed = false;
  let frameError: ChatBotStreamError | null = null;

  await response.readStream((text) => {
    buffer += text;
    const parsed = parseChatBotFrames(buffer);
    buffer = parsed.rest;

    for (const frame of parsed.frames) {
      if (frame.error != null && frame.error !== '') {
        frameError = new ChatBotStreamError('upstream', frame.error);
        return false;
      }
      if (frame.delta != null && frame.delta !== '') onDelta(frame.delta);
      if (frame.finishReason != null) completed = true;
    }
    if (parsed.done) completed = true;
    return !completed;
  });

  if (frameError != null) throw frameError;
  if (signal.aborted) return false;
  if (!completed) throw new ChatBotStreamError('upstream');
  return true;
}
