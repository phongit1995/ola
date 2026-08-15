import { bridge, joinGame, type UserInfoData } from '../src/sdk';
import type { ServerMove, ServerState } from './logic/server-types';
import { pvp, type PvpGameSession } from './pvp';
import { hasActiveRoom, initRooms, openWaitingRoom } from './rooms';

export interface SessionControllerUi {
  setConnecting(): void;
  setReady(user: UserInfoData): void;
  setError(): void;
  updateUser(user: UserInfoData): void;
  toast(message: string): void;
}

export interface SessionController {
  initRooms(): void;
  connect(): Promise<void>;
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
        // Server đẩy USER_INFO ngay sau khi tất toán cược: báo app chủ
        // refetch số dư KEN, không thì header app giữ số cũ tới khi F5.
        bridge.refreshUser();
        ui.updateUser(data);
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

  return {
    initRooms: () => initRooms(roomsDeps),
    connect,
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
