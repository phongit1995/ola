import { ensureFreshToken, refreshAccessToken } from '@api';
import {
  buildChatBotRequest,
  chatBotErrorForStatus,
  parseChatBotFrames,
} from '@services';
import type { ChatBotErrorCode, ChatBotPromptMessage } from '@app-types';

export class ChatBotStreamError extends Error {
  readonly code: ChatBotErrorCode;

  constructor(code: ChatBotErrorCode, message?: string) {
    super(message ?? code);
    this.name = 'ChatBotStreamError';
    this.code = code;
  }
}

interface StreamChatBotOptions {
  messages: ChatBotPromptMessage[];
  language?: string;
  signal: AbortSignal;
  onDelta: (delta: string) => void;
}

function isAbort(error: unknown): boolean {
  return error instanceof DOMException && error.name === 'AbortError';
}

async function readErrorMessage(response: Response): Promise<string> {
  try {
    const body = (await response.json()) as { error?: string };
    return body.error ?? response.statusText;
  } catch {
    return response.statusText;
  }
}

async function postChatBot(
  messages: ChatBotPromptMessage[],
  language: string | undefined,
  accessToken: string,
  signal: AbortSignal
): Promise<Response | null> {
  const { url, init } = buildChatBotRequest(messages, language, accessToken);
  try {
    return await fetch(url, { ...init, signal });
  } catch (error) {
    if (isAbort(error)) return null;
    throw new ChatBotStreamError('network');
  }
}

async function openChatBotStream(
  { messages, language, signal }: Omit<StreamChatBotOptions, 'onDelta'>,
  accessToken: string
): Promise<Response | null> {
  const response = await postChatBot(messages, language, accessToken, signal);
  if (response == null || response.status !== 401) return response;

  let refreshed: string;
  try {
    refreshed = await refreshAccessToken();
  } catch {
    throw new ChatBotStreamError('auth', await readErrorMessage(response));
  }

  return postChatBot(messages, language, refreshed, signal);
}

export async function streamChatBot({
  messages,
  language,
  signal,
  onDelta,
}: StreamChatBotOptions): Promise<boolean> {
  const accessToken = await ensureFreshToken();
  if (accessToken === '') throw new ChatBotStreamError('auth');

  const response = await openChatBotStream(
    { messages, language, signal },
    accessToken
  );
  if (response == null) return false;

  if (!response.ok) {
    const message = await readErrorMessage(response);
    throw new ChatBotStreamError(
      chatBotErrorForStatus(response.status),
      message
    );
  }

  if (response.body == null) throw new ChatBotStreamError('upstream');

  const reader = response.body.getReader();
  const decoder = new TextDecoder();
  let buffer = '';
  let completed = false;

  try {
    for (;;) {
      const { value, done } = await reader.read();
      if (value != null) {
        buffer += decoder.decode(value, { stream: true });
        const parsed = parseChatBotFrames(buffer);
        buffer = parsed.rest;
        for (const frame of parsed.frames) {
          if (frame.error != null && frame.error !== '') {
            throw new ChatBotStreamError('upstream', frame.error);
          }
          if (frame.delta != null && frame.delta !== '') onDelta(frame.delta);
          if (frame.finishReason != null) completed = true;
        }
        if (parsed.done) completed = true;
        if (completed) return true;
      }
      if (done) {
        if (!completed) throw new ChatBotStreamError('upstream');
        return true;
      }
    }
  } catch (error) {
    if (isAbort(error)) return false;
    throw error;
  } finally {
    void reader.cancel().catch(() => undefined);
  }
}
