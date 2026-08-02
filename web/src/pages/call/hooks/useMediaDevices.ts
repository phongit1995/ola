import { useEffect, useState } from 'react';
import { DEVICE_KIND } from '../constants';
import type { DeviceList } from '../interfaces';

const EMPTY_DEVICES: DeviceList = {
  audioinput: [],
  videoinput: [],
  audiooutput: [],
};

export function useMediaDevices(): DeviceList {
  const [devices, setDevices] = useState<DeviceList>(EMPTY_DEVICES);

  useEffect(() => {
    const media = navigator.mediaDevices;
    if (media?.enumerateDevices == null) return;

    const refresh = async () => {
      try {
        const list = await media.enumerateDevices();
        setDevices({
          audioinput: list.filter(
            (item) => item.kind === DEVICE_KIND.audioInput
          ),
          videoinput: list.filter(
            (item) => item.kind === DEVICE_KIND.videoInput
          ),
          audiooutput: list.filter(
            (item) => item.kind === DEVICE_KIND.audioOutput
          ),
        });
      } catch {
        setDevices(EMPTY_DEVICES);
      }
    };

    void refresh();
    media.addEventListener?.('devicechange', refresh);
    return () => {
      media.removeEventListener?.('devicechange', refresh);
    };
  }, []);

  return devices;
}
