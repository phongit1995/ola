import type { TFunction } from 'i18next';
import type { CallMode } from '../types/client/call.type';
import { formatCallDuration } from './callFormat';
import { CALL_MODE } from '../constants/call';

export function computeCallStatusLabel(
  t: TFunction,
  mode: CallMode,
  connectionState: string,
  elapsedSeconds: number
): string {
  if (mode === CALL_MODE.outgoing) return t('call.ringing');
  if (connectionState === 'connecting') return t('call.connecting');
  if (connectionState === 'reconnecting') return t('call.reconnecting');
  if (mode === CALL_MODE.active) return formatCallDuration(elapsedSeconds);
  return t('call.connected');
}
