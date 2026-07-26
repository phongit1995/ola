import {
  ARCADE_ATTENTION_REASON,
  ARCADE_BRIDGE_EVENT,
  ARCADE_BRIDGE_SOURCE,
  type ArcadeAttentionData,
  type ArcadeBridgeEvent,
  type ArcadeBridgeMessage,
} from '@ola/shared/types';

interface RNWebView {
  postMessage(message: string): void;
}

declare global {
  interface Window {
    ReactNativeWebView?: RNWebView;
  }
}

function sendToHost(type: ArcadeBridgeEvent, data?: unknown): void {
  const message: ArcadeBridgeMessage = {
    source: ARCADE_BRIDGE_SOURCE.Game,
    type,
    data,
  };
  if (window.ReactNativeWebView) {
    window.ReactNativeWebView.postMessage(JSON.stringify(message));
    return;
  }
  if (window.parent !== window) {
    window.parent.postMessage(message, '*');
  }
}

type HostHandler = (data: unknown) => void;
const hostHandlers = new Map<string, Set<HostHandler>>();

const REQUIRED_TOKEN_TIMEOUT_MS = 8000;

export class GameAuthenticationRequiredError extends Error {
  constructor() {
    super('Authentication token is required');
    this.name = 'GameAuthenticationRequiredError';
  }
}

function tokenFrom(value: unknown): string | null {
  const token = String(value ?? '').trim();
  return token || null;
}

function hasTokenHost(): boolean {
  return window.ReactNativeWebView != null || window.parent !== window;
}

function handleIncoming(raw: unknown): void {
  if (raw == null || typeof raw !== 'object') return;
  const message = raw as ArcadeBridgeMessage;
  if (message.source !== ARCADE_BRIDGE_SOURCE.Host || typeof message.type !== 'string') return;
  hostHandlers.get(message.type)?.forEach((handler) => handler(message.data));
}

window.addEventListener('message', (event) => handleIncoming(event.data));
document.addEventListener('message', ((event: MessageEvent) => {
  if (typeof event.data === 'string') {
    try {
      handleIncoming(JSON.parse(event.data));
    } catch {
      /* not a bridge message */
    }
  }
}) as EventListener);

export const bridge = {
  onHost(type: string, handler: HostHandler): () => void {
    let handlers = hostHandlers.get(type);
    if (!handlers) {
      handlers = new Set();
      hostHandlers.set(type, handlers);
    }
    handlers.add(handler);
    return () => hostHandlers.get(type)?.delete(handler);
  },

  ready(): void {
    sendToHost(ARCADE_BRIDGE_EVENT.Ready);
  },

  gameOver(data: { matchId: string; winnerId?: string; reason: string; won: boolean }): void {
    sendToHost(ARCADE_BRIDGE_EVENT.GameOver, data);
    sendToHost(ARCADE_BRIDGE_EVENT.AttentionRequired, {
      reason: ARCADE_ATTENTION_REASON.GameOver,
      matchId: data.matchId,
    } satisfies ArcadeAttentionData);
  },

  turnChanged(data: { yourTurn: boolean; deadline: number }): void {
    sendToHost(ARCADE_BRIDGE_EVENT.TurnChanged, data);
    if (data.yourTurn) {
      sendToHost(ARCADE_BRIDGE_EVENT.AttentionRequired, {
        reason: ARCADE_ATTENTION_REASON.YourTurn,
      } satisfies ArcadeAttentionData);
    }
  },

  attention(data: ArcadeAttentionData): void {
    sendToHost(ARCADE_BRIDGE_EVENT.AttentionRequired, data);
  },

  exit(): void {
    sendToHost(ARCADE_BRIDGE_EVENT.Exit);
  },

  requestToken(): Promise<string> {
    const queryValue = new URLSearchParams(location.search).get('token');
    if (queryValue != null) {
      const token = tokenFrom(queryValue);
      if (token) return Promise.resolve(token);
    }

    if (!hasTokenHost()) {
      return Promise.reject(new GameAuthenticationRequiredError());
    }

    return new Promise((resolve, reject) => {
      let timer: number | undefined;
      const off = bridge.onHost(ARCADE_BRIDGE_EVENT.Token, (data) => {
        off();
        if (timer != null) clearTimeout(timer);
        const token = tokenFrom(data);
        if (token) resolve(token);
        else reject(new GameAuthenticationRequiredError());
      });
      timer = window.setTimeout(() => {
        off();
        reject(new GameAuthenticationRequiredError());
      }, REQUIRED_TOKEN_TIMEOUT_MS);
      sendToHost(ARCADE_BRIDGE_EVENT.GetToken);
    });
  },
};
