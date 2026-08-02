import { NativeModules, Platform } from 'react-native';

interface CallServiceModule {
  start: (withVideo: boolean) => void;
  stop: () => void;
}

const nativeCallService =
  (NativeModules as { OlaCallService?: CallServiceModule }).OlaCallService ?? null;

// Android 14+ cắt mic/camera khi app xuống nền nếu không có foreground service
// đúng type. iOS lo phần này bằng UIBackgroundModes audio nên không cần gì thêm.
export function startCallForegroundService(withVideo: boolean): void {
  if (Platform.OS !== 'android') return;
  nativeCallService?.start(withVideo);
}

export function stopCallForegroundService(): void {
  if (Platform.OS !== 'android') return;
  nativeCallService?.stop();
}
