import { useCallback, useEffect, useState, useSyncExternalStore } from 'react';
import { ConnectionState, RoomEvent, type Room } from 'livekit-client';

export function useConnectionState(room: Room | undefined): ConnectionState {
  const subscribe = useCallback(
    (onChange: () => void) => {
      if (room == null) return () => undefined;
      room.on(RoomEvent.ConnectionStateChanged, onChange);
      return () => {
        room.off(RoomEvent.ConnectionStateChanged, onChange);
      };
    },
    [room],
  );

  const getSnapshot = useCallback(
    () => room?.state ?? ConnectionState.Connecting,
    [room],
  );

  return useSyncExternalStore(subscribe, getSnapshot, getSnapshot);
}

export function useElapsedSeconds(running: boolean): number {
  const [elapsed, setElapsed] = useState(0);

  useEffect(() => {
    if (!running) return;
    const timer = setInterval(() => setElapsed(value => value + 1), 1000);
    return () => clearInterval(timer);
  }, [running]);

  return elapsed;
}
