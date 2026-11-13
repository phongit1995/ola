import { NativeModules, Platform } from 'react-native';

interface CallServiceModule {
  start: (withVideo: boolean) => Promise<void>;
  stop: () => Promise<void>;
}

const nativeCallService =
  (NativeModules as { OlaCallService?: CallServiceModule }).OlaCallService ?? null;

export async function startCallForegroundService(withVideo: boolean): Promise<void> {
  if (Platform.OS !== 'android') return;
  if (nativeCallService == null) {
    throw new Error('OlaCallService native module is unavailable');
  }
  await nativeCallService.start(withVideo);
}

export async function stopCallForegroundService(): Promise<void> {
  if (Platform.OS !== 'android') return;
  await nativeCallService?.stop();
}
