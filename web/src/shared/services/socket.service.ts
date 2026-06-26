import { io, type Socket } from 'socket.io-client';
import { env } from '@config';
import { ensureFreshToken } from '@api';

const ENVELOPE_EVENT = 'message';
const PING_EVENT = 'ping';
const PING_INTERVAL_MS = 60_000;
const SESSION_REPLACED_EVENT = 'SESSION_REPLACED';

type EnvelopeHandler = (data: unknown) => void;

export interface SessionReplacedData {
  reason?: string;
}

type SessionReplacedHandler = (data: SessionReplacedData) => void;

export class SocketService {
  private static socket: Socket | null = null;
  private static listeners = new Map<string, Set<EnvelopeHandler>>();
  private static pingTimer: ReturnType<typeof setInterval> | null = null;
  private static sessionReplacedHandler: SessionReplacedHandler | null = null;

  static connect(): Socket {
    if (this.socket) return this.socket;
    const socket = io(env.socketUrl, {
      auth: (cb) => {
        void ensureFreshToken().then((token) => cb({ token }));
      },
      transports: ['websocket'],
      autoConnect: false,
    });
    socket.on(ENVELOPE_EVENT, (envelope: { type?: string; data?: unknown }) => {
      if (envelope?.type == null) return;
      this.listeners.get(envelope.type)?.forEach((handler) => handler(envelope.data));
    });
    socket.on(SESSION_REPLACED_EVENT, (data: SessionReplacedData) => {
      this.sessionReplacedHandler?.(data ?? {});
    });
    socket.on('connect', () => this.startHeartbeat());
    socket.on('disconnect', () => this.stopHeartbeat());
    this.socket = socket;
    socket.connect();
    return socket;
  }

  static ready(timeoutMs = 10_000): Promise<Socket> {
    const socket = this.connect();
    if (socket.connected) return Promise.resolve(socket);
    return new Promise<Socket>((resolve, reject) => {
      const onConnect = () => {
        clearTimeout(timer);
        resolve(socket);
      };
      const timer = setTimeout(() => {
        socket.off('connect', onConnect);
        reject(new Error('socket connect timeout'));
      }, timeoutMs);
      socket.once('connect', onConnect);
    });
  }

  static onSessionReplaced(handler: SessionReplacedHandler): () => void {
    this.sessionReplacedHandler = handler;
    return () => {
      if (this.sessionReplacedHandler === handler) this.sessionReplacedHandler = null;
    };
  }

  private static startHeartbeat(): void {
    this.stopHeartbeat();
    this.pingTimer = setInterval(() => {
      if (this.socket?.connected) this.socket.emit(PING_EVENT);
    }, PING_INTERVAL_MS);
  }

  private static stopHeartbeat(): void {
    if (this.pingTimer == null) return;
    clearInterval(this.pingTimer);
    this.pingTimer = null;
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
    this.stopHeartbeat();
    if (!this.socket) return;
    this.socket.disconnect();
    this.socket = null;
  }

  static get connected(): boolean {
    return this.socket?.connected ?? false;
  }
}
