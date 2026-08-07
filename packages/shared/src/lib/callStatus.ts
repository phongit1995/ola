import type { TFunction } from 'i18next';
import type { CallMode } from '../types/client/call.type';
import { formatCallDuration } from './callFormat';

export function computeCallStatusLabel(
  t: TFunction,
  mode: CallMode,
  connectionState: string,
  elapsedSeconds: number
): string {
  if (mode === 'outgoing') return t('call.ringing');
  if (connectionState === 'connecting') return t('call.connecting');
  if (connectionState === 'reconnecting') return t('call.reconnecting');
  if (mode === 'active') return formatCallDuration(elapsedSeconds);
  return t('call.connected');
}
