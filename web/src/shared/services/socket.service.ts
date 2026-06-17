import { io, type Socket } from 'socket.io-client';
import { env } from '@config';
import { authTokens } from '@lib';

const ENVELOPE_EVENT = 'message';

type EnvelopeHandler = (data: unknown) => void;

export class SocketService {
  private static socket: Socket | null = null;
  private static listeners = new Map<string, Set<EnvelopeHandler>>();

  static connect(): Socket {
    if (this.socket) return this.socket;
    const socket = io(env.socketUrl, {
      auth: { token: authTokens.getAccessToken() ?? '' },
      transports: ['websocket'],
      autoConnect: true,
    });
    socket.on(ENVELOPE_EVENT, (envelope: { type?: string; data?: unknown }) => {
      if (envelope?.type == null) return;
      this.listeners.get(envelope.type)?.forEach((handler) => handler(envelope.data));
    });
    this.socket = socket;
    return socket;
  }

  static on<T = unknown>(type: string, handler: (data: T) => void): () => void {
    let handlers = this.listeners.get(type);
    if (!handlers) {
      handlers = new Set();
      this.listeners.set(type, handlers);
    }
    const wrapped = handler as EnvelopeHandler;
    handlers.add(wrapped);
    return () => {
      this.listeners.get(type)?.delete(wrapped);
    };
  }

  static disconnect(): void {
    if (!this.socket) return;
    this.socket.disconnect();
    this.socket = null;
  }

  static get connected(): boolean {
    return this.socket?.connected ?? false;
  }
}
