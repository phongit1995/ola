const BRIDGE_SOURCE = 'ola-game';
const HOST_SOURCE = 'ola-host';

interface BridgeMessage {
  source: string;
  type: string;
  data?: unknown;
}

interface RNWebView {
  postMessage(message: string): void;
}

declare global {
  interface Window {
    ReactNativeWebView?: RNWebView;
  }
}

function sendToHost(type: string, data?: unknown): void {
  const message: BridgeMessage = { source: BRIDGE_SOURCE, type, data };
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
  const message = raw as BridgeMessage;
  if (message.source !== HOST_SOURCE || typeof message.type !== 'string') return;
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
    sendToHost('ready');
  },

  gameOver(data: { matchId: string; winnerId?: string; reason: string; won: boolean }): void {
    sendToHost('game_over', data);
  },

  turnChanged(data: { yourTurn: boolean; deadline: number }): void {
    sendToHost('turn_changed', data);
  },

  exit(): void {
    sendToHost('exit');
  },

  requestToken(): Promise<string> {
    return new Promise((resolve) => {
      const fromQuery = new URLSearchParams(location.search).get('token');
      if (fromQuery) {
        resolve(fromQuery);
        return;
      }
      const off = bridge.onHost('token', (data) => {
        off();
        clearTimeout(timer);
        resolve(String(data ?? ''));
      });
      sendToHost('get_token');
      const timer = setTimeout(() => {
        off();
        resolve(`guest:${crypto.randomUUID().slice(0, 8)}`);
      }, 1500);
    });
  },
};
