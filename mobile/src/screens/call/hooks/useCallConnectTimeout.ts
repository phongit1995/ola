import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { useRoomContext } from '@livekit/components-react';
import { ConnectionState } from 'livekit-client';
import { CALL_CONNECT_TIMEOUT_MS } from '@ola/shared/constants';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useCallStore } from '@store/callStore';

export function useCallConnectTimeout() {
  const { t } = useTranslation();
  const room = useRoomContext();
  const endActive = useCallStore((s) => s.endActive);

  useEffect(() => {
    if (room == null) return;
    const timer = setTimeout(() => {
      if (room.state === ConnectionState.Connected) return;
      useToastStore.getState().push('error', t('call.connectTimeout'));
      endActive();
    }, CALL_CONNECT_TIMEOUT_MS);

    return () => clearTimeout(timer);
  }, [room, endActive, t]);
}
