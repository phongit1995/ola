import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { useRoomContext } from '@livekit/components-react';
import { toast } from '@lib';
import { useCallStore } from '@/store/callStore';
import { DEVICE_KIND } from '../constants';
import type { DeviceKind } from '../interfaces';
import { useMediaDevices } from './useMediaDevices';

export function useDeviceSync() {
  const { t } = useTranslation();
  const room = useRoomContext();
  const devices = useMediaDevices();
  const selectedMicId = useCallStore((s) => s.selectedMicId);
  const selectedCamId = useCallStore((s) => s.selectedCamId);
  const selectedSpeakerId = useCallStore((s) => s.selectedSpeakerId);
  const setSelectedMicId = useCallStore((s) => s.setSelectedMicId);
  const setSelectedCamId = useCallStore((s) => s.setSelectedCamId);
  const setSelectedSpeakerId = useCallStore((s) => s.setSelectedSpeakerId);

  useEffect(() => {
    if (room == null) return;

    const apply = (
      kind: DeviceKind,
      id: string | null,
      list: MediaDeviceInfo[],
      clear: (value: string | null) => void
    ) => {
      if (id == null) return;
      if (!list.some((item) => item.deviceId === id)) {
        clear(null);
        return;
      }
      room.switchActiveDevice(kind, id).catch(() => {
        toast.error(t('call.switchDeviceFailed'));
      });
    };

    apply(
      DEVICE_KIND.audioInput,
      selectedMicId,
      devices.audioinput,
      setSelectedMicId
    );
    apply(
      DEVICE_KIND.videoInput,
      selectedCamId,
      devices.videoinput,
      setSelectedCamId
    );
    apply(
      DEVICE_KIND.audioOutput,
      selectedSpeakerId,
      devices.audiooutput,
      setSelectedSpeakerId
    );
  }, [
    room,
    devices,
    selectedMicId,
    selectedCamId,
    selectedSpeakerId,
    setSelectedMicId,
    setSelectedCamId,
    setSelectedSpeakerId,
    t,
  ]);

  return {
    devices,
    selectedMicId,
    selectedCamId,
    selectedSpeakerId,
    setSelectedMicId,
    setSelectedCamId,
    setSelectedSpeakerId,
  };
}
