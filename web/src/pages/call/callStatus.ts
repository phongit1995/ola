import type { TFunction } from 'i18next';
import { ConnectionState } from 'livekit-client';
import { formatCallDuration } from '@lib';
import type { CallMode } from '@app-types';

export function computeStatusLabel(
  mode: CallMode,
  connectionState: ConnectionState,
  elapsedSeconds: number,
  t: TFunction
): string {
  if (mode === 'outgoing') return t('call.ringing');
  if (connectionState === ConnectionState.Connecting) return t('call.connecting');
  if (connectionState === ConnectionState.Reconnecting) {
    return t('call.reconnecting');
  }
  if (mode === 'active') return formatCallDuration(elapsedSeconds);
  return t('call.connected');
}
