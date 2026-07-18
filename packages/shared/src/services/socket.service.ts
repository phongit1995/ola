import { io, type Socket } from 'socket.io-client';
import { env } from '../config';
import { ensureFreshToken, refreshAccessToken, signApiGuard } from '../api';
import { ApiError, authTokens } from '../lib';
import { getDeviceInfo } from '../platform';

const SOCKET_GUARD_PATH = '/socket.io/';

const ENVELOPE_EVENT = 'message';
const PING_EVENT = 'ping';
const PING_INTERVAL_MS = 60_000;
const STALE_SILENCE_MS = 30_000;
const SESSION_REPLACED_EVENT = 'SESSION_REPLACED';
const FORCE_LOGOUT_EVENT = 'FORCE_LOGOUT';
const AUTH_CONNECT_ERRORS = new Set([
  'Unauthorized',
  'session revoked',
  'access_token is required',
]);

type EnvelopeHandler = (data: unknown) => void;
type ReconnectHandler = () => void;

export type ConnectionStatus = 'offline' | 'connected' | 'reconnecting';
type ConnectionStatusListener = () => void;

export interface SessionReplacedData {
  reason?: string;
}

type SessionReplacedHandler = (data: SessionReplacedData) => void;

export interface ForceLogoutData {
  reason?: string;
}

type ForceLogoutHandler = (data: ForceLogoutData) => void;

export class SocketService {
  private static socket: Socket | null = null;
  private static listeners = new Map<string, Set<EnvelopeHandler>>();
  private static pingTimer: ReturnType<typeof setInterval> | null = null;
  private static sessionReplacedHandler: SessionReplacedHandler | null = null;
  private static forceLogoutHandler: ForceLogoutHandler | null = null;
  private static recoveringAuth = false;
  private static reconnectHandlers = new Set<ReconnectHandler>();
  private static hasConnected = false;
  private static status: ConnectionStatus = 'offline';
  private static statusListeners = new Set<ConnectionStatusListener>();
  private static lastServerPingAt = 0;

  static connect(): Socket {
    if (this.socket) return this.socket;
    const socket = io(env.socketUrl, {
      auth: (cb) => {
        void ensureFreshToken().then((token) => {
          const guard = signApiGuard('WS', SOCKET_GUARD_PATH);
          cb({
            token,
            platform: getDeviceInfo().platform,
            ...(guard && { ts: guard.timestamp, nonce: guard.nonce, sig: guard.signature }),
          });
        });
      },
      transports: env.socketTransports,
      autoConnect: false,
    });
    socket.on(ENVELOPE_EVENT, (envelope: { type?: string; data?: unknown }) => {
      if (envelope?.type == null) return;
      this.listeners.get(envelope.type)?.forEach((handler) => handler(envelope.data));
    });
    socket.on(SESSION_REPLACED_EVENT, (data: SessionReplacedData) => {
      this.sessionReplacedHandler?.(data ?? {});
    });
    socket.on(FORCE_LOGOUT_EVENT, (data: ForceLogoutData) => {
      this.handleForceLogout(data ?? {});
    });
    socket.on('connect', () => this.handleConnect());
    socket.on('disconnect', () => this.handleDisconnect());
    socket.on('connect_error', (error) => {
      if (AUTH_CONNECT_ERRORS.has(error.message)) {
        void this.recoverAuth();
        return;
      }
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

  static onForceLogout(handler: ForceLogoutHandler): () => void {
    this.forceLogoutHandler = handler;
    return () => {
      if (this.forceLogoutHandler === handler) this.forceLogoutHandler = null;
    };
  }

  private static handleForceLogout(data: ForceLogoutData): void {
    const handler = this.forceLogoutHandler;
    this.disconnect();
    handler?.(data);
  }

  private static async recoverAuth(): Promise<void> {
    if (this.recoveringAuth) return;
    this.recoveringAuth = true;
    try {
      await refreshAccessToken();
      if (this.hasConnected) this.setStatus('reconnecting');
    } catch (error) {
      const sessionDead =
        (error instanceof ApiError && error.status === 401) ||
        authTokens.getRefreshToken() == null;
      if (sessionDead) {
        authTokens.clear();
        this.handleForceLogout({ reason: 'session_expired' });
      } else if (this.hasConnected) {
        this.setStatus('reconnecting');
      }
    } finally {
      this.recoveringAuth = false;
    }
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
