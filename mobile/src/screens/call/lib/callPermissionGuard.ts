import type { TFunction } from 'i18next';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { CallType } from '@ola/shared/types';
import { primeCallPermissions } from './primeCallPermissions';
import { CALL_TYPE } from '@ola/shared/constants';

export async function ensureCallPermissions(
  callType: CallType,
  t: TFunction,
): Promise<boolean> {
  const result = await primeCallPermissions(callType);
  if (result === 'ok') return true;

  const push = useToastStore.getState().push;
  if (result === 'denied') {
    push('error', t(callType === CALL_TYPE.video ? 'call.cameraDenied' : 'call.micDenied'));
    return false;
  }
  push('error', t('call.startFailed'));
  return false;
}
