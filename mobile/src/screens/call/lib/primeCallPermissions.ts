import { PermissionsAndroid, Platform } from 'react-native';
import { mediaDevices } from '@livekit/react-native-webrtc';
import type { CallType } from '@ola/shared/types';

export type PrimeCallResult = 'ok' | 'denied' | 'insecure' | 'failed';

const ANDROID_BLUETOOTH_SDK = 31;
const ANDROID_NOTIFICATION_SDK = 33;

// BLUETOOTH_CONNECT là quyền runtime từ Android 12: không xin thì tai nghe
// bluetooth không xuất hiện trong danh sách audio output. Thiếu nó vẫn gọi được
// bằng loa/tai nghe trong nên không đưa vào điều kiện bắt buộc.
async function requestAndroidPermissions(callType: CallType): Promise<boolean> {
  const required = [PermissionsAndroid.PERMISSIONS.RECORD_AUDIO];
  if (callType === 'video') required.push(PermissionsAndroid.PERMISSIONS.CAMERA);

  const wanted = [...required];
  if (Number(Platform.Version) >= ANDROID_BLUETOOTH_SDK) {
    wanted.push(PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT);
  }
  // Notification không phải điều kiện để FGS chạy, nhưng Android 13+ sẽ ẩn
  // thông báo cuộc gọi khỏi notification drawer nếu người dùng chưa cấp quyền.
  if (Number(Platform.Version) >= ANDROID_NOTIFICATION_SDK) {
    wanted.push(PermissionsAndroid.PERMISSIONS.POST_NOTIFICATIONS);
  }

  const result = await PermissionsAndroid.requestMultiple(wanted);
  return required.every(
    (permission) => result[permission] === PermissionsAndroid.RESULTS.GRANTED,
  );
}

// iOS không có API xin quyền rời như Android: prompt hệ thống chỉ bật khi thực sự
// mở thiết bị, nên phải getUserMedia rồi tắt ngay track vừa mở.
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
      video: callType === 'video',
    });
    stream.getTracks().forEach((track) => track.stop());
    return 'ok';
  } catch (error) {
    const name = (error as { name?: string })?.name;
    if (name === 'NotAllowedError' || name === 'SecurityError') return 'denied';
    return 'failed';
  }
}
