import { useEffect } from 'react';
import { useRoomContext } from '@livekit/components-react';
import { ConnectionState, RoomEvent } from 'livekit-client';
import { CALL_PEER_LEFT_GRACE_MS } from '@ola/shared/constants';
import { useCallStore } from '@/store/callStore';

export function usePeerPresenceWatcher() {
  const room = useRoomContext();
  const endActive = useCallStore((s) => s.endActive);
  const markRemoteJoined = useCallStore((s) => s.markRemoteJoined);

  useEffect(() => {
    if (room == null) return;
    let leaveTimer: ReturnType<typeof setTimeout> | null = null;

    const cancelLeaveTimer = () => {
      if (leaveTimer == null) return;
      clearTimeout(leaveTimer);
      leaveTimer = null;
    };

    const handleJoined = () => {
      cancelLeaveTimer();
      markRemoteJoined();
    };

    const handleLeft = () => {
      cancelLeaveTimer();
      leaveTimer = setTimeout(() => {
        leaveTimer = null;
        if (room.state === ConnectionState.Reconnecting) return;
        if (room.remoteParticipants.size > 0) return;
        endActive();
      }, CALL_PEER_LEFT_GRACE_MS);
    };

    if (room.remoteParticipants.size > 0) markRemoteJoined();

    room.on(RoomEvent.ParticipantConnected, handleJoined);
    room.on(RoomEvent.ParticipantDisconnected, handleLeft);

    return () => {
      cancelLeaveTimer();
      room.off(RoomEvent.ParticipantConnected, handleJoined);
      room.off(RoomEvent.ParticipantDisconnected, handleLeft);
    };
  }, [room, endActive, markRemoteJoined]);
}
