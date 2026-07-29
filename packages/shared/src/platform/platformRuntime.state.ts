import type {
  DeviceInfoPort,
  KeyValueStorage,
  SharedEnv,
  SoundPort,
} from '../types/platform.type';

let currentEnv: SharedEnv | null = null;
let currentSound: SoundPort | null = null;
let currentStorage: KeyValueStorage | null = null;
let currentDeviceInfo: DeviceInfoPort | null = null;
let cachedDeviceId: string | null = null;

export function setCurrentEnv(value: SharedEnv): void {
  currentEnv = value;
}

export function getCurrentEnv(): SharedEnv | null {
  return currentEnv;
}

export function setCurrentSound(value: SoundPort): void {
  currentSound = value;
}

export function getCurrentSound(): SoundPort | null {
  return currentSound;
}

export function setCurrentStorage(value: KeyValueStorage): void {
  currentStorage = value;
}

export function getCurrentStorage(): KeyValueStorage | null {
  return currentStorage;
}

export function setCurrentDeviceInfo(value: DeviceInfoPort): void {
  currentDeviceInfo = value;
}

export function getCurrentDeviceInfo(): DeviceInfoPort | null {
  return currentDeviceInfo;
}

export function setCachedDeviceId(value: string): void {
  cachedDeviceId = value;
}

export function getCachedDeviceId(): string | null {
  return cachedDeviceId;
}
