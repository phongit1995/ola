import { CALL_TYPE } from '@constants';
import type { CallType } from '@app-types';

export type PrimeCallResult = 'ok' | 'denied' | 'insecure' | 'failed';

export async function primeCallPermissions(
  callType: CallType
): Promise<PrimeCallResult> {
  if (navigator.mediaDevices?.getUserMedia == null) return 'insecure';
  try {
    const stream = await navigator.mediaDevices.getUserMedia({
      audio: {
        echoCancellation: true,
        noiseSuppression: true,
        autoGainControl: true,
      },
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
