import { useEffect, useState } from 'react';
import { Track, type Participant } from 'livekit-client';
import { SPEAKING_RELEASE_MS, SPEAKING_THRESHOLD } from '../constants';
import { createAnalyser } from '../lib/audioAnalyser';
import { useParticipantTrackVersion } from './useParticipantTrackVersion';

function micTrackOf(participant: Participant | undefined) {
  const publication = participant?.getTrackPublication(
    Track.Source.Microphone
  );
  const track = publication?.track;
  if (track == null || publication?.isMuted === true) return null;
  return (track as { mediaStreamTrack?: MediaStreamTrack }).mediaStreamTrack;
}

export function useSpeaking(participant: Participant | undefined): boolean {
  const [speaking, setSpeaking] = useState(false);
  const trackVersion = useParticipantTrackVersion(participant);

  useEffect(() => {
    const mediaTrack = micTrackOf(participant);
    if (mediaTrack == null) {
      return;
    }

    const handle = createAnalyser(mediaTrack, 512);
    if (handle == null) return;

    const buffer = new Uint8Array(handle.analyser.fftSize);
    let frame: number | null = null;
    let silenceSince = 0;
    let current = false;

    const tick = () => {
      handle.analyser.getByteTimeDomainData(buffer);
      let sum = 0;
      for (let index = 0; index < buffer.length; index += 1) {
        const value = ((buffer[index] ?? 128) - 128) / 128;
        sum += value * value;
      }
      const rms = Math.sqrt(sum / buffer.length);
      const now = Date.now();

      if (rms > SPEAKING_THRESHOLD) {
        silenceSince = 0;
        if (!current) {
          current = true;
          setSpeaking(true);
        }
      } else if (current) {
        if (silenceSince === 0) silenceSince = now;
        else if (now - silenceSince > SPEAKING_RELEASE_MS) {
          current = false;
          setSpeaking(false);
        }
      }

      frame = requestAnimationFrame(tick);
    };

    frame = requestAnimationFrame(tick);

    return () => {
      if (frame != null) cancelAnimationFrame(frame);
      handle.release();
      setSpeaking(false);
    };
  }, [participant, trackVersion]);

  return speaking;
}
