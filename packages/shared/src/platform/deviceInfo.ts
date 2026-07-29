import { randomUuid } from '../lib/randomUuid';
import { DEVICE_ID_STORAGE_KEY } from '../constants/storage';
import type {
  DeviceInfoPayload,
  DeviceInfoPort,
} from '../types/platform.type';
import { getKeyValueStorage } from './keyValueStorage';
import {
  getCachedDeviceId,
  getCurrentDeviceInfo,
  setCachedDeviceId,
  setCurrentDeviceInfo,
} from './platformRuntime.state';

export type { DeviceInfoPayload, DeviceInfoPort } from '../types/platform.type';

export function configureDeviceInfo(port: DeviceInfoPort): void {
  setCurrentDeviceInfo(port);
}

function persistedDeviceId(): string {
  const cachedDeviceId = getCachedDeviceId();
  if (cachedDeviceId != null) {
    return cachedDeviceId;
  }
  try {
    const storage = getKeyValueStorage();
    const existing = storage.getItem(DEVICE_ID_STORAGE_KEY);
    if (existing != null && existing !== '') {
      setCachedDeviceId(existing);
      return existing;
    }
    const generated = randomUuid();
    storage.setItem(DEVICE_ID_STORAGE_KEY, generated);
    setCachedDeviceId(generated);
    return generated;
  } catch {
    const fallback = randomUuid();
    setCachedDeviceId(fallback);
    return fallback;
  }
}

export function getDeviceInfo(): DeviceInfoPayload {
  const port = getCurrentDeviceInfo();
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
