import { useSyncExternalStore } from 'react';
import { SocketService, type ConnectionStatus } from '@services';

export function useConnectionStatus(): ConnectionStatus {
  return useSyncExternalStore(SocketService.subscribeStatus, SocketService.getStatus);
}
