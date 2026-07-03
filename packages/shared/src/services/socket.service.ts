import { io, type Socket } from 'socket.io-client';
import { env } from '../config';
import { ensureFreshToken } from '../api';

const ENVELOPE_EVENT = 'message';
const PING_EVENT = 'ping';
const PING_INTERVAL_MS = 60_000;
const STALE_SILENCE_MS = 30_000;
const SESSION_REPLACED_EVENT = 'SESSION_REPLACED';

type EnvelopeHandler = (data: unknown) => void;
type ReconnectHandler = () => void;

export type ConnectionStatus = 'offline' | 'connected' | 'reconnecting';
type ConnectionStatusListener = () => void;

export interface SessionReplacedData {
  reason?: string;
}

type SessionReplacedHandler = (data: SessionReplacedData) => void;

export class SocketService {
  private static socket: Socket | null = null;
  private static listeners = new Map<string, Set<EnvelopeHandler>>();
  private static pingTimer: ReturnType<typeof setInterval> | null = null;
  private static sessionReplacedHandler: SessionReplacedHandler | null = null;
  private static reconnectHandlers = new Set<ReconnectHandler>();
  private static hasConnected = false;
  private static status: ConnectionStatus = 'offline';
  private static statusListeners = new Set<ConnectionStatusListener>();
  private static lastServerPingAt = 0;

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
    socket.on('connect', () => this.handleConnect());
    socket.on('disconnect', () => this.handleDisconnect());
    socket.on('connect_error', () => {
      if (this.hasConnected) this.setStatus('reconnecting');
    });
    socket.io.on('ping', () => {
      this.lastServerPingAt = Date.now();
    });
    this.socket = socket;
    socket.connect();
    return socket;
  }

  static ensureAlive(): void {
    const socket = this.socket;
    if (!socket) return;
    if (!socket.connected) {
      socket.connect();
      return;
    }
    if (Date.now() - this.lastServerPingAt > STALE_SILENCE_MS) this.forceReconnect();
  }

  static forceReconnect(): void {
    const socket = this.socket;
    if (!socket) return;
    socket.disconnect();
    socket.connect();
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

  static onReconnect(handler: ReconnectHandler): () => void {
    this.reconnectHandlers.add(handler);
    return () => {
      this.reconnectHandlers.delete(handler);
    };
  }

  private static handleConnect(): void {
    this.lastServerPingAt = Date.now();
    this.startHeartbeat();
    if (this.hasConnected) this.reconnectHandlers.forEach((handler) => handler());
    this.hasConnected = true;
    this.setStatus('connected');
  }

  private static handleDisconnect(): void {
    this.stopHeartbeat();
    if (this.hasConnected) this.setStatus('reconnecting');
  }

  private static setStatus(next: ConnectionStatus): void {
    if (this.status === next) return;
    this.status = next;
    this.statusListeners.forEach((listener) => listener());
  }

  static subscribeStatus = (listener: ConnectionStatusListener): (() => void) => {
    SocketService.statusListeners.add(listener);
    return () => {
      SocketService.statusListeners.delete(listener);
    };
  };

  static getStatus = (): ConnectionStatus => SocketService.status;

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
    this.hasConnected = false;
    this.setStatus('offline');
    if (!this.socket) return;
    this.socket.disconnect();
    this.socket = null;
  }

  static get connected(): boolean {
    return this.socket?.connected ?? false;
  }
}
