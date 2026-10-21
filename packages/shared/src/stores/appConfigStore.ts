import { create } from 'zustand';
import { SettingsService } from '../services/settings.service';
import type { AppConfigs } from '../types/api/settings.type';
import type { AppConfigState } from '../types/client/settings.type';

const APP_CONFIG_FRESH_MS = 5_000;

let inflight: Promise<boolean> | null = null;

// Every screen reloads on entry; screens opened within a few seconds of each other share one request,
// and an unchanged config only costs a notModified round trip.
export const useAppConfigStore = create<AppConfigState>((set, get) => ({
  configs: {},
  version: null,
  loadedAt: 0,
  error: null,

  load: (options) => {
    if (inflight != null) return inflight;
    const { version, loadedAt } = get();
    if (!options?.force && version != null && Date.now() - loadedAt < APP_CONFIG_FRESH_MS) {
      return Promise.resolve(true);
    }
    inflight = SettingsService.appConfig(version ?? undefined)
      .then((result) => {
        if (result.notModified) {
          set({ loadedAt: Date.now(), error: null });
        } else {
          set({ configs: result.configs ?? {}, version: result.version, loadedAt: Date.now(), error: null });
        }
        return true;
      })
      .catch((error: unknown) => {
        set({ error });
        return false;
      })
      .finally(() => {
        inflight = null;
      });
    return inflight;
  },
}));

export async function loadAppConfig<K extends keyof AppConfigs>(key: K): Promise<AppConfigs[K] | null> {
  await useAppConfigStore.getState().load();
  return useAppConfigStore.getState().configs[key] ?? null;
}

export async function requireAppConfig<K extends keyof AppConfigs>(key: K): Promise<AppConfigs[K]> {
  const value = await loadAppConfig(key);
  if (value == null) throw useAppConfigStore.getState().error ?? new Error(`app config "${key}" is unavailable`);
  return value;
}
