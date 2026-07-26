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
    return new Promise((resolve) => {
      const fromQuery = new URLSearchParams(location.search).get('token');
      if (fromQuery) {
        resolve(fromQuery);
        return;
      }
      const off = bridge.onHost(ARCADE_BRIDGE_EVENT.Token, (data) => {
        off();
        clearTimeout(timer);
        resolve(String(data ?? ''));
      });
      sendToHost(ARCADE_BRIDGE_EVENT.GetToken);
      const timer = setTimeout(() => {
        off();
        resolve(`guest:${crypto.randomUUID().slice(0, 8)}`);
      }, 1500);
    });
  },
};
