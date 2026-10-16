import type { Track } from 'livekit-client';
import type {
  DEVICE_KIND,
  PERM_NAME,
  PERM_STATE,
  REQUEST_RESULT,
} from './constants';

export type PermState = (typeof PERM_STATE)[keyof typeof PERM_STATE];
export type PermName = (typeof PERM_NAME)[keyof typeof PERM_NAME];
export type RequestResult = (typeof REQUEST_RESULT)[keyof typeof REQUEST_RESULT];

export type MediaSource = Track.Source.Microphone | Track.Source.Camera;

export type DeviceKind = (typeof DEVICE_KIND)[keyof typeof DEVICE_KIND];

export interface DeviceList {
  audioinput: MediaDeviceInfo[];
  videoinput: MediaDeviceInfo[];
  audiooutput: MediaDeviceInfo[];
}
