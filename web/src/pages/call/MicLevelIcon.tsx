import { useEffect, useRef } from 'react';
import { Track, type Participant } from 'livekit-client';
import { createAnalyser } from './lib/audioAnalyser';
import { useParticipantTrackVersion } from './hooks/useParticipantTrackVersion';
import { MicIcon } from './icons';

interface MicLevelIconProps {
  participant: Participant | undefined;
  muted: boolean;
  className?: string;
}

const ATTACK = 0.55;
const RELEASE = 0.12;

export function MicLevelIcon({
  participant,
  muted,
  className,
}: MicLevelIconProps) {
  const barRef = useRef<HTMLSpanElement | null>(null);
  const trackVersion = useParticipantTrackVersion(participant);

  useEffect(() => {
    const bar = barRef.current;
    if (bar == null || muted) return;

    const publication = participant?.getTrackPublication(
      Track.Source.Microphone
    );
    const mediaTrack = (
      publication?.track as { mediaStreamTrack?: MediaStreamTrack } | undefined
    )?.mediaStreamTrack;
    if (mediaTrack == null) return;

    const handle = createAnalyser(mediaTrack, 256);
    if (handle == null) return;

    const buffer = new Uint8Array(handle.analyser.frequencyBinCount);
    let frame: number | null = null;
    let smoothed = 0;

    const tick = () => {
      handle.analyser.getByteFrequencyData(buffer);
      let sum = 0;
      for (let index = 0; index < buffer.length; index += 1) {
        sum += buffer[index] ?? 0;
      }
      const level = Math.min(1, sum / buffer.length / 96);
      const factor = level > smoothed ? ATTACK : RELEASE;
      smoothed += (level - smoothed) * factor;
      bar.style.transform = `scaleY(${0.15 + smoothed * 0.85})`;
      frame = requestAnimationFrame(tick);
    };

    frame = requestAnimationFrame(tick);

    return () => {
      if (frame != null) cancelAnimationFrame(frame);
      handle.release();
      bar.style.transform = 'scaleY(0.15)';
    };
  }, [participant, muted, trackVersion]);

  return (
    <span className="relative flex items-center justify-center">
      <MicIcon className={className ?? 'h-6 w-6'} />
      <span
        ref={barRef}
        style={{ transform: 'scaleY(0.15)' }}
        className="pointer-events-none absolute -bottom-1.5 h-1 w-6 origin-bottom rounded-full bg-ola-button"
      />
    </span>
  );
}
