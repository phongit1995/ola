import { ChatBotStreamError, type ChatBotTransport } from './chatBotTransport';

const HEADERS_RECEIVED = 2;

function parseErrorMessage(body: string, statusText: string): string {
  try {
    const parsed = JSON.parse(body) as { error?: string };
    return parsed.error ?? statusText;
  } catch {
    return statusText;
  }
}

export const xhrChatBotTransport: ChatBotTransport = (request, signal) =>
  new Promise((resolveResponse, rejectResponse) => {
    if (signal.aborted) {
      resolveResponse(null);
      return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open(request.init.method ?? 'POST', request.url);
    xhr.responseType = 'text';

    const headers = (request.init.headers ?? {}) as Record<string, string>;
    for (const [name, value] of Object.entries(headers)) {
      xhr.setRequestHeader(name, value);
    }

    let headersSettled = false;
    let finished = false;
    let networkFailed = false;
    let delivered = 0;
    let consume: ((text: string) => boolean) | null = null;
    let stopped = false;
    let settleStream: (() => void) | null = null;
    let failStream: ((error: Error) => void) | null = null;
    const finishWaiters: (() => void)[] = [];

    const currentText = (): string => {
      try {
        return xhr.responseText ?? '';
      } catch {
        return '';
      }
    };

    const pump = () => {
      if (consume == null || stopped) return;
      const text = currentText();
      if (text.length <= delivered) return;
      const chunk = text.slice(delivered);
      delivered = text.length;
      if (!consume(chunk)) {
        stopped = true;
        settleStream?.();
        if (!finished) xhr.abort();
      }
    };

    const endStream = () => {
      if (networkFailed && !stopped) {
        failStream?.(new ChatBotStreamError('network'));
        return;
      }
      settleStream?.();
    };

    const markFinished = () => {
      if (finished) return;
      finished = true;
      for (const waiter of finishWaiters) waiter();
      finishWaiters.length = 0;
    };

    xhr.onreadystatechange = () => {
      if (xhr.readyState >= HEADERS_RECEIVED && !headersSettled) {
        headersSettled = true;
        resolveResponse({
          status: xhr.status,
          readErrorMessage: async () => {
            if (!finished) {
              await new Promise<void>((resolve) => finishWaiters.push(resolve));
            }
            return parseErrorMessage(currentText(), xhr.statusText);
          },
          readStream: (onChunk) =>
            new Promise<void>((resolve, reject) => {
              consume = onChunk;
              settleStream = resolve;
              failStream = reject;
              pump();
              if (finished || stopped) endStream();
            }),
        });
      }
      if (xhr.readyState === XMLHttpRequest.LOADING) pump();
    };

    xhr.onprogress = pump;

    xhr.onload = () => {
      pump();
      markFinished();
      endStream();
    };

    xhr.onerror = () => {
      networkFailed = true;
      markFinished();
      if (!headersSettled) {
        headersSettled = true;
        rejectResponse(new ChatBotStreamError('network'));
        return;
      }
      endStream();
    };

    xhr.onabort = () => {
      markFinished();
      if (!headersSettled) {
        headersSettled = true;
        resolveResponse(null);
        return;
      }
      settleStream?.();
    };

    signal.addEventListener('abort', () => xhr.abort(), { once: true });

    xhr.send(request.init.body as string);
  });
