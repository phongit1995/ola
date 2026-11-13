import { PermissionsAndroid, Platform, type Permission } from 'react-native';
import { mediaDevices } from '@livekit/react-native-webrtc';
import type { CallType } from '@ola/shared/types';
import { CALL_TYPE } from '@ola/shared/constants';

export type PrimeCallResult = 'ok' | 'denied' | 'insecure' | 'failed';

const ANDROID_BLUETOOTH_SDK = 31;
const ANDROID_NOTIFICATION_SDK = 33;

async function requestAndroidPermissions(callType: CallType): Promise<boolean> {
  const required: Permission[] = [PermissionsAndroid.PERMISSIONS.RECORD_AUDIO];
  if (callType === CALL_TYPE.video) required.push(PermissionsAndroid.PERMISSIONS.CAMERA);

  const wanted: Permission[] = [...required];
  if (Number(Platform.Version) >= ANDROID_BLUETOOTH_SDK) {
    wanted.push(PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT);
  }
  if (Number(Platform.Version) >= ANDROID_NOTIFICATION_SDK) {
    wanted.push(PermissionsAndroid.PERMISSIONS.POST_NOTIFICATIONS);
  }

  const result = await PermissionsAndroid.requestMultiple(wanted);
  return required.every(
    (permission) => result[permission] === PermissionsAndroid.RESULTS.GRANTED,
  );
}

export async function primeCallPermissions(
  callType: CallType,
): Promise<PrimeCallResult> {
  if (Platform.OS === 'android') {
    const granted = await requestAndroidPermissions(callType).catch(() => false);
    if (!granted) return 'denied';
  }

  try {
    const stream = await mediaDevices.getUserMedia({
      audio: true,
      video: callType === CALL_TYPE.video,
    });
    stream.getTracks().forEach((track) => track.stop());
    return 'ok';
  } catch (error) {
    const name = (error as { name?: string })?.name;
    if (name === 'NotAllowedError' || name === 'SecurityError') return 'denied';
    return 'failed';
  }
}
