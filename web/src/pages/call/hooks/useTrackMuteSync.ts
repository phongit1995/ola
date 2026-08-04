import { useEffect } from 'react';
import { useLocalParticipant } from '@livekit/components-react';
import { ParticipantEvent } from 'livekit-client';
import type { MediaSource } from '../interfaces';

export function useTrackMuteSync(source: MediaSource, muted: boolean) {
  const { localParticipant } = useLocalParticipant();

  useEffect(() => {
    const apply = () => {
      const publication = localParticipant.getTrackPublication(source);
      const track = publication?.track;
      if (track == null) return;
      if (muted && !track.isMuted) void track.mute();
      else if (!muted && track.isMuted) void track.unmute();
    };

    apply();
    localParticipant.on(ParticipantEvent.LocalTrackPublished, apply);
    localParticipant.on(ParticipantEvent.TrackMuted, apply);
    localParticipant.on(ParticipantEvent.TrackUnmuted, apply);
    localParticipant.on(ParticipantEvent.LocalTrackSubscribed, apply);

    return () => {
      localParticipant.off(ParticipantEvent.LocalTrackPublished, apply);
      localParticipant.off(ParticipantEvent.TrackMuted, apply);
      localParticipant.off(ParticipantEvent.TrackUnmuted, apply);
      localParticipant.off(ParticipantEvent.LocalTrackSubscribed, apply);
    };
  }, [localParticipant, source, muted]);
}
