import {
  GAME_ERROR_CODE,
  joinGame,
  type UserInfoData,
} from '../src/sdk';
import type { ServerMove, ServerState } from './logic/server-types';
import { pvp, type PvpGameSession } from './pvp';
import { hasActiveRoom, initRooms, openWaitingRoom } from './rooms';

export interface SessionControllerUi {
  setConnecting(): void;
  setReady(user: UserInfoData): void;
  setError(): void;
  updateUser(user: UserInfoData): void;
  toast(message: string): void;
  openSearch(): void;
  hideSearch(): void;
  isSearchOpen(): boolean;
}

export interface SessionController {
  initRooms(): void;
  connect(): Promise<void>;
  startQueue(): void;
  cancelQueue(): void;
  openActiveRoom(): void;
  getSession(): PvpGameSession | null;
  getUserInfo(): UserInfoData | null;
  dispose(): void;
}

export function createSessionController(ui: SessionControllerUi): SessionController {
  let session: PvpGameSession | null = null;
  let userInfo: UserInfoData | null = null;
  let wiredSession: PvpGameSession | null = null;
  let eventDisposers: Array<() => void> = [];
  let connecting: Promise<void> | null = null;

  const roomsDeps = {
    getSession: () => session,
    getUserInfo: () => userInfo,
    toast: ui.toast,
  };

  const waitUserInfo = (
    gameSession: PvpGameSession,
    timeoutMs: number,
  ): Promise<UserInfoData> =>
    new Promise((resolve, reject) => {
      let timer: ReturnType<typeof setTimeout> | undefined;
      let offInfo: () => void = () => {};
      const cleanup = (): void => {
        offInfo();
        if (timer !== undefined) clearTimeout(timer);
      };
      offInfo = gameSession.onUserInfo((data) => {
        cleanup();
        resolve(data);
      });
      timer = setTimeout(() => {
        cleanup();
        reject(new Error('connect timeout'));
      }, timeoutMs);
    });

  const wireSessionEvents = (next: PvpGameSession): void => {
    if (wiredSession === next) return;
    eventDisposers.forEach((dispose) => dispose());
    eventDisposers = [];
    wiredSession = next;
    eventDisposers.push(
      next.onUserInfo((data) => {
        userInfo = data;
        ui.updateUser(data);
      }),
      next.onError((error) => {
        if (
          (error.code === GAME_ERROR_CODE.InRoom ||
            error.code === GAME_ERROR_CODE.AlreadyInRoom) &&
          ui.isSearchOpen()
        ) {
          ui.hideSearch();
          openWaitingRoom();
        }
      }),
    );
  };

  const connectOnce = async (): Promise<void> => {
    ui.setConnecting();
    try {
      session ??= await joinGame<ServerState, ServerMove>('war-god');
      pvp.init(session);
      initRooms(roomsDeps);
      wireSessionEvents(session);
      userInfo = await waitUserInfo(session, 8000);
      ui.setReady(userInfo);
    } catch {
      eventDisposers.forEach((dispose) => dispose());
      eventDisposers = [];
      wiredSession = null;
      session?.disconnect();
      session = null;
      userInfo = null;
      ui.setError();
    }
  };

  const connect = (): Promise<void> => {
    if (!connecting) {
      connecting = connectOnce().finally(() => {
        connecting = null;
      });
    }
    return connecting;
  };

  const beginQueue = (): void => {
    if (hasActiveRoom()) {
      openWaitingRoom();
      return;
    }
    if (session && userInfo) {
      ui.openSearch();
      pvp.startQueue();
      return;
    }
    void connect().then(() => {
      if (!session || !userInfo) return;
      if (hasActiveRoom()) {
        openWaitingRoom();
        return;
      }
      ui.openSearch();
      pvp.startQueue();
    });
  };

  return {
    initRooms: () => initRooms(roomsDeps),
    connect,
    startQueue: beginQueue,
    cancelQueue: () => pvp.cancelQueue(),
    openActiveRoom(): void {
      if (hasActiveRoom()) openWaitingRoom();
    },
    getSession: () => session,
    getUserInfo: () => userInfo,
    dispose(): void {
      eventDisposers.forEach((dispose) => dispose());
      eventDisposers = [];
      wiredSession = null;
      session?.disconnect();
      session = null;
      userInfo = null;
    },
  };
}
