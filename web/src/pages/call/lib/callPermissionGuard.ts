import type { TFunction } from 'i18next';
import { CALL_TYPE } from '@constants';
import { toast } from '@lib';
import type { CallType } from '@app-types';
import { primeCallPermissions } from './primeCallPermissions';

export async function ensureCallPermissions(
  callType: CallType,
  t: TFunction
): Promise<boolean> {
  const result = await primeCallPermissions(callType);
  if (result === 'ok' || result === 'failed') return true;
  if (result === 'insecure') {
    toast.error(t('call.needSecureContext'));
    return false;
  }
  toast.error(
    t(callType === CALL_TYPE.video ? 'call.cameraDenied' : 'call.micDenied')
  );
  return false;
}
