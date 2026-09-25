import type { CAMERA_MODES } from './CameraMode.enum';

export type CameraMode = (typeof CAMERA_MODES)[keyof typeof CAMERA_MODES];

export interface CameraState {
  mode: CameraMode;
  x: number;
  y: number;
  displayScale: number;
}
