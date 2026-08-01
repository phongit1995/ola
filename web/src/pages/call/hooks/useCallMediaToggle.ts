import { useTranslation } from 'react-i18next';
import { useLocalParticipant } from '@livekit/components-react';
import { Track } from 'livekit-client';
import { toast } from '@lib';
import { useCallStore } from '@/store/callStore';
import { PERM_NAME, PERM_STATE, REQUEST_RESULT } from '../constants';
import type { MediaSource, PermState } from '../interfaces';
import { requestAndPublish } from '../lib/callMedia';
import { usePermissionStatus } from './usePermissionStatus';

export function useCallMediaToggle() {
  const { t } = useTranslation();
  const { localParticipant } = useLocalParticipant();
  const micMuted = useCallStore((s) => s.micMuted);
  const camOff = useCallStore((s) => s.camOff);
  const setMicMuted = useCallStore((s) => s.setMicMuted);
  const setCamOff = useCallStore((s) => s.setCamOff);
  const micPerm = usePermissionStatus(PERM_NAME.mic);
  const camPerm = usePermissionStatus(PERM_NAME.cam);

  const blockedHint = (source: MediaSource) =>
    t('call.permBlockedHint', {
      label:
        source === Track.Source.Microphone
          ? t('call.microphone')
          : t('call.camera'),
    });

  const toggleSource = async (
    source: MediaSource,
    perm: PermState,
    muted: boolean,
    setMuted: (value: boolean) => void
  ) => {
    if (perm === PERM_STATE.denied) {
      toast.error(blockedHint(source));
      return;
    }

    const publication = localParticipant.getTrackPublication(source);
    if (publication?.track == null) {
      const result = await requestAndPublish(localParticipant, source);
      if (result === REQUEST_RESULT.denied) toast.error(blockedHint(source));
      else if (result === REQUEST_RESULT.granted) setMuted(false);
      return;
    }

    const next = !muted;
    setMuted(next);
    if (next) await publication.track.mute();
    else await publication.track.unmute();
  };

  return {
    localParticipant,
    micMuted,
    camOff,
    micPerm,
    camPerm,
    toggleMic: () =>
      void toggleSource(
        Track.Source.Microphone,
        micPerm,
        micMuted,
        setMicMuted
      ),
    toggleCam: () =>
      void toggleSource(Track.Source.Camera, camPerm, camOff, setCamOff),
  };
}
