import { useCallback, useSyncExternalStore } from 'react';
import { useRoomContext } from '@livekit/components-react';
import { RoomEvent } from 'livekit-client';

export function useAudioPlayback() {
  const room = useRoomContext();

  const subscribe = useCallback(
    (onChange: () => void) => {
      if (room == null) return () => undefined;
      room.on(RoomEvent.AudioPlaybackStatusChanged, onChange);
      return () => {
        room.off(RoomEvent.AudioPlaybackStatusChanged, onChange);
      };
    },
    [room]
  );

  const getSnapshot = useCallback(() => room?.canPlaybackAudio ?? true, [room]);

  const canPlay = useSyncExternalStore(subscribe, getSnapshot, getSnapshot);

  const enable = useCallback(() => {
    void room?.startAudio().catch(() => {});
  }, [room]);

  return { blocked: !canPlay, enable };
}
