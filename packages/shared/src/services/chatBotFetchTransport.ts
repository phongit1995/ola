import {
  ChatBotStreamError,
  parseChatBotErrorBody,
  type ChatBotErrorBody,
  type ChatBotTransport,
} from './chatBotTransport';

function isAbort(error: unknown): boolean {
  return error instanceof DOMException && error.name === 'AbortError';
}

async function errorOf(response: Response): Promise<ChatBotErrorBody> {
  try {
    return parseChatBotErrorBody(await response.text(), response.statusText);
  } catch {
    return { message: response.statusText };
  }
}

export const fetchChatBotTransport: ChatBotTransport = async (
  request,
  signal
) => {
  let response: Response;
  try {
    response = await fetch(request.url, { ...request.init, signal });
  } catch (error) {
    if (isAbort(error)) return null;
    throw new ChatBotStreamError('network');
  }

  return {
    status: response.status,
    readError: () => errorOf(response),
    readStream: async (onChunk) => {
      if (response.body == null) throw new ChatBotStreamError('upstream');

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      try {
        for (;;) {
          const { value, done } = await reader.read();
          if (value != null && !onChunk(decoder.decode(value, { stream: true }))) {
            return;
          }
          if (done) return;
        }
      } catch (error) {
        if (isAbort(error)) return;
        throw error;
      } finally {
        void reader.cancel().catch(() => undefined);
      }
    },
  };
};
