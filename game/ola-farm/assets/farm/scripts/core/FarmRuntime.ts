import type { FarmCatalog } from './types/CatalogTypes';
import { ConfigReader } from './ConfigReader';
import type { FarmRuntimeConfig } from './types/RuntimeTypes';
import { LEGACY_RUNTIME } from './constants/RuntimeDefaults';

export const runtimeConfig = (catalog?: FarmCatalog): FarmRuntimeConfig => catalog?.runtime ?? LEGACY_RUNTIME;

export function withFarmRuntime(source: FarmCatalog, input: unknown): FarmCatalog {
  const v = new ConfigReader('runtime.json');
  if ('runtime' in source) v.fail('config', 'cấu hình runtime bị trùng.');
  const c = v.object(input, 'config', Object.keys(LEGACY_RUNTIME));
  if (c.version !== 1) v.fail('version', 'chỉ hỗ trợ phiên bản 1.');
  for (const group of ['session', 'audio', 'ui', 'input', 'camera', 'assets'] as const)
    v.object(c[group], group, Object.keys(LEGACY_RUNTIME[group]));
  const seconds = (n: unknown, path: string, min = 0.01) => v.number(n, path, min, 86400);
  seconds(c.session.autosaveSeconds, 'session.autosaveSeconds', 0.1);
  for (const key of ['offlineProgressEnabled', 'defaultSound', 'defaultMusic'])
    v.bool(c.session[key], 'session.' + key);
  if (c.session.maxOfflineSeconds !== null) v.number(c.session.maxOfflineSeconds, 'session.maxOfflineSeconds', 0);
  for (const key of Object.keys(c.audio)) v.number(c.audio[key], 'audio.' + key, 0, 1);
  seconds(c.ui.refreshSeconds, 'ui.refreshSeconds');
  seconds(c.ui.toastSeconds, 'ui.toastSeconds');
  v.bool(c.ui.motionEnabled, 'ui.motionEnabled');
  seconds(c.input.longPressSeconds, 'input.longPressSeconds', 0.1);
  seconds(c.input.resizeSettleSeconds, 'input.resizeSettleSeconds', 0);
  for (const key of ['mapDragSlop', 'seedDragSlop', 'buttonDragSlop']) v.number(c.input[key], 'input.' + key, 1, 100);
  v.number(c.input.wheelZoomStep, 'input.wheelZoomStep', 1.01, 2);
  for (const key of ['homePadding', 'cullMargin']) v.number(c.camera[key], 'camera.' + key, 0, 2000);
  v.number(c.camera.maxZoom, 'camera.maxZoom', 1, 32);
  for (const key of ['maxDisplayScale', 'buildingFocusScale', 'facilityFocusScale'])
    v.number(c.camera[key], 'camera.' + key, 0.1, 8);
  v.number(c.assets.loadConcurrency, 'assets.loadConcurrency', 1, 32, true);
  return { ...source, runtime: JSON.parse(JSON.stringify(c)) as FarmRuntimeConfig };
}
