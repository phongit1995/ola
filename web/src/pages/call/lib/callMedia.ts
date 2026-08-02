import { Track, type LocalParticipant } from 'livekit-client';
import { REQUEST_RESULT } from '../constants';
import type { MediaSource, RequestResult } from '../interfaces';

const NOT_ALLOWED_ERROR = 'NotAllowedError';

function constraintsFor(source: MediaSource): MediaStreamConstraints {
  return source === Track.Source.Microphone ? { audio: true } : { video: true };
}

async function enableFor(participant: LocalParticipant, source: MediaSource) {
  if (source === Track.Source.Microphone) {
    await participant.setMicrophoneEnabled(true);
    return;
  }
  await participant.setCameraEnabled(true);
}

export async function requestAndPublish(
  participant: LocalParticipant,
  source: MediaSource
): Promise<RequestResult> {
  try {
    const stream = await navigator.mediaDevices.getUserMedia(
      constraintsFor(source)
    );
    stream.getTracks().forEach((track) => track.stop());
    await enableFor(participant, source);
    return REQUEST_RESULT.granted;
  } catch (error) {
    if ((error as DOMException)?.name === NOT_ALLOWED_ERROR) {
      return REQUEST_RESULT.denied;
    }
    return REQUEST_RESULT.error;
  }
}
