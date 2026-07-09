import { randomUuid } from '../lib/randomUuid';
import { getKeyValueStorage } from './keyValueStorage';

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

const DEVICE_ID_KEY = 'ola.deviceId';

let current: DeviceInfoPort | null = null;
let cachedDeviceId: string | null = null;

export function configureDeviceInfo(port: DeviceInfoPort): void {
  current = port;
}

function persistedDeviceId(): string {
  if (cachedDeviceId != null) {
    return cachedDeviceId;
  }
  try {
    const storage = getKeyValueStorage();
    const existing = storage.getItem(DEVICE_ID_KEY);
    if (existing != null && existing !== '') {
      cachedDeviceId = existing;
      return existing;
    }
    const generated = randomUuid();
    storage.setItem(DEVICE_ID_KEY, generated);
    cachedDeviceId = generated;
    return generated;
  } catch {
    cachedDeviceId = randomUuid();
    return cachedDeviceId;
  }
}

export function getDeviceInfo(): DeviceInfoPayload {
  const port = current;
  const explicitId = port?.deviceId;
  const deviceId =
    explicitId != null && explicitId !== '' ? explicitId : persistedDeviceId();
  return {
    deviceName: port?.deviceName ?? '',
    platform: port?.platform ?? '',
    deviceId,
    appVersion: port?.appVersion ?? '',
  };
}
