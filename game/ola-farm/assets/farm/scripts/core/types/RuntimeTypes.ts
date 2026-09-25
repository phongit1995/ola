export interface FarmRuntimeConfig {
  version: 1;
  session: {
    autosaveSeconds: number;
    offlineProgressEnabled: boolean;
    maxOfflineSeconds: number | null;
    defaultSound: boolean;
    defaultMusic: boolean;
  };
  audio: { musicVolume: number; effectVolume: number };
  ui: { refreshSeconds: number; toastSeconds: number; motionEnabled: boolean };
  input: {
    longPressSeconds: number;
    mapDragSlop: number;
    seedDragSlop: number;
    buttonDragSlop: number;
    wheelZoomStep: number;
    resizeSettleSeconds: number;
  };
  camera: {
    homePadding: number;
    cullMargin: number;
    maxZoom: number;
    maxDisplayScale: number;
    buildingFocusScale: number;
    facilityFocusScale: number;
  };
  assets: { loadConcurrency: number };
}
