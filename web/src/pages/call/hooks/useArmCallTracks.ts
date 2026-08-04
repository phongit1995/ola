import { useEffect } from 'react';
import { useRoomContext } from '@livekit/components-react';
import { ConnectionState, RoomEvent, Track } from 'livekit-client';

export function useArmCallTracks(
  enableAudioOnJoin: boolean,
  enableVideoOnJoin: boolean
) {
  const room = useRoomContext();

  useEffect(() => {
    if (room == null) return;
    let cancelled = false;
    let waiter: ((state: ConnectionState) => void) | null = null;

    const waitConnected = () =>
      new Promise<void>((resolve) => {
        if (room.state === ConnectionState.Connected) {
          resolve();
          return;
        }
        waiter = (state: ConnectionState) => {
          if (state !== ConnectionState.Connected) return;
          resolve();
        };
        room.on(RoomEvent.ConnectionStateChanged, waiter);
      });

    const enable = async (source: Track.Source) => {
      const existing = room.localParticipant.getTrackPublication(source);
      if (existing?.track != null) return;
      try {
        if (source === Track.Source.Microphone) {
          await room.localParticipant.setMicrophoneEnabled(true);
          return;
        }
        await room.localParticipant.setCameraEnabled(true);
      } catch {
        return;
      }
    };

    const arm = async () => {
      await waitConnected();
      if (cancelled) return;
      if (enableAudioOnJoin) await enable(Track.Source.Microphone);
      if (cancelled) return;
      if (enableVideoOnJoin) await enable(Track.Source.Camera);
    };

    void arm();

    return () => {
      cancelled = true;
      if (waiter != null) room.off(RoomEvent.ConnectionStateChanged, waiter);
    };
  }, [room, enableAudioOnJoin, enableVideoOnJoin]);
}
