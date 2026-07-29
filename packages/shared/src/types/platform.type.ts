export type SocketTransport = 'websocket' | 'polling';

export interface SharedEnv {
  apiUrl: string;
  apiTimeout: number;
  apiGuardSecret: string;
  socketUrl: string;
  socketTransports?: SocketTransport[];
  geoapifyKey: string;
  isDev: boolean;
}

export interface DeviceInfoPayload {
  deviceName: string;
  platform: string;
  deviceId: string;
  appVersion: string;
}

export interface DeviceInfoPort {
  platform: string;
  appVersion: string;
  deviceName?: string;
  deviceId?: string;
}

export interface SoundPort {
  playMessage(): void;
  playRoomTag(): void;
  playKenChest(): void;
  playKenCredit(): void;
}

export interface KeyValueStorage {
  getItem(key: string): string | null;
  setItem(key: string, value: string): void;
  removeItem(key: string): void;
}
