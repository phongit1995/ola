import { useEffect, useState } from 'react';
import { ParticipantEvent, type Participant } from 'livekit-client';

const WATCHED_EVENTS = [
  ParticipantEvent.TrackPublished,
  ParticipantEvent.TrackUnpublished,
  ParticipantEvent.TrackSubscribed,
  ParticipantEvent.TrackUnsubscribed,
  ParticipantEvent.TrackMuted,
  ParticipantEvent.TrackUnmuted,
  ParticipantEvent.LocalTrackPublished,
  ParticipantEvent.LocalTrackUnpublished,
] as const;

export function useParticipantTrackVersion(
  participant: Participant | undefined
): number {
  const [version, setVersion] = useState(0);

  useEffect(() => {
    if (participant == null) return;
    const bump = () => setVersion((value) => value + 1);
    WATCHED_EVENTS.forEach((event) => participant.on(event, bump));
    return () => {
      WATCHED_EVENTS.forEach((event) => participant.off(event, bump));
    };
  }, [participant]);

  return version;
}
