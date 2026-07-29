import { useSyncExternalStore } from 'react';
import type { ConnectionStatus } from '@ola/shared/types';
import { SocketService } from '@services';

export function useConnectionStatus(): ConnectionStatus {
  return useSyncExternalStore(
    SocketService.subscribeStatus,
    SocketService.getStatus
  );
}
