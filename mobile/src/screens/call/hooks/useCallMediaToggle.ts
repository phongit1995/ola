import { useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { useLocalParticipant } from '@livekit/components-react';
import { LocalVideoTrack, Track } from 'livekit-client';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useCallStore } from '@store/callStore';

type FacingMode = 'user' | 'environment';
type CallMediaSource = Track.Source.Microphone | Track.Source.Camera;

export function useCallMediaToggle() {
  const { t } = useTranslation();
  const { localParticipant } = useLocalParticipant();
  const micMuted = useCallStore((s) => s.micMuted);
  const camOff = useCallStore((s) => s.camOff);
  const setMicMuted = useCallStore((s) => s.setMicMuted);
  const setCamOff = useCallStore((s) => s.setCamOff);
  const facing = useRef<FacingMode>('user');
  const pendingSources = useRef(new Set<CallMediaSource>());

  const toggleSource = async (source: CallMediaSource) => {
    if (pendingSources.current.has(source)) return;

    const state = useCallStore.getState();
    const callId = state.active?.callId;
    if (callId == null) return;

    pendingSources.current.add(source);

    const muted =
      source === Track.Source.Microphone ? state.micMuted : state.camOff;
    const next = !muted;
    try {
      if (source === Track.Source.Microphone) {
        await localParticipant.setMicrophoneEnabled(!next);
      } else {
        await localParticipant.setCameraEnabled(!next);
      }

      if (useCallStore.getState().active?.callId !== callId) return;
      if (source === Track.Source.Microphone) setMicMuted(next);
      else setCamOff(next);
    } catch {
      if (useCallStore.getState().active?.callId !== callId) return;
      useToastStore
        .getState()
        .push(
          'error',
          t(
            source === Track.Source.Camera
              ? 'call.cameraToggleFailed'
              : 'call.micToggleFailed',
          ),
        );
    } finally {
      pendingSources.current.delete(source);
    }
  };

  const switchCamera = async () => {
    const track = localParticipant.getTrackPublication(Track.Source.Camera)
      ?.track;
    if (!(track instanceof LocalVideoTrack)) return;
    const next: FacingMode = facing.current === 'user' ? 'environment' : 'user';
    try {
      await track.restartTrack({ facingMode: next });
      facing.current = next;
    } catch {
      return;
    }
  };

  return {
    micMuted,
    camOff,
    toggleMic: () => void toggleSource(Track.Source.Microphone),
    toggleCam: () => void toggleSource(Track.Source.Camera),
    switchCamera: () => void switchCamera(),
  };
}
