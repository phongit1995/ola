import { io, type Socket } from 'socket.io-client';
import { env } from '@config';
import { authTokens } from '@lib';

export class SocketService {
  private static socket: Socket | null = null;

  static connect(): Socket {
    if (this.socket) return this.socket;
    this.socket = io(env.socketUrl, {
      auth: { token: authTokens.getAccessToken() ?? '' },
      transports: ['polling', 'websocket'],
      autoConnect: true,
    });
    return this.socket;
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
