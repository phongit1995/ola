export const PERM_STATE = {
  granted: 'granted',
  denied: 'denied',
  prompt: 'prompt',
  unsupported: 'unsupported',
} as const;

export const PERM_NAME = {
  mic: 'microphone',
  cam: 'camera',
} as const;

export const REQUEST_RESULT = {
  granted: 'granted',
  denied: 'denied',
  error: 'error',
} as const;

export const PIP_MIN_WIDTH = 96;
export const PIP_MAX_WIDTH = 280;
export const PIP_DEFAULT_WIDTH = 132;
export const PIP_ASPECT = 3 / 4;

export const MINI_WIDGET_WIDTH = 176;
export const MINI_WIDGET_HEIGHT = 116;

export const SPEAKING_THRESHOLD = 0.02;
export const SPEAKING_RELEASE_MS = 500;

export const DEVICE_KIND = {
  audioInput: 'audioinput',
  videoInput: 'videoinput',
  audioOutput: 'audiooutput',
} as const;
