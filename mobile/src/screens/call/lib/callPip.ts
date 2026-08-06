import { DeviceEventEmitter, NativeModules, Platform } from 'react-native';

interface PipModule {
  setPipSupported: (enabled: boolean, aspectW: number, aspectH: number) => void;
  exitPip: () => void;
}

const PIP_MODE_CHANGED_EVENT = 'OlaCallPipModeChanged';
const PIP_CLOSED_EVENT = 'OlaCallPipClosed';

const nativePip =
  Platform.OS === 'android'
    ? ((NativeModules as { OlaCallPip?: PipModule }).OlaCallPip ?? null)
    : null;

export function setPipSupported(enabled: boolean, isVideo: boolean): void {
  if (isVideo) nativePip?.setPipSupported(enabled, 9, 16);
  else nativePip?.setPipSupported(enabled, 1, 1);
}

export function exitPip(): void {
  nativePip?.exitPip();
}

export function subscribePipModeChanged(
  listener: (isInPip: boolean) => void,
): () => void {
  if (nativePip == null) return () => undefined;
  const subscription = DeviceEventEmitter.addListener(
    PIP_MODE_CHANGED_EVENT,
    (isInPip: boolean) => listener(isInPip === true),
  );
  return () => subscription.remove();
}

export function subscribePipClosed(listener: () => void): () => void {
  if (nativePip == null) return () => undefined;
  const subscription = DeviceEventEmitter.addListener(PIP_CLOSED_EVENT, () =>
    listener(),
  );
  return () => subscription.remove();
}
