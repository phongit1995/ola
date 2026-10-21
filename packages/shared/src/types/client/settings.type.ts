import type {
  AppConfigs,
  TopupConfigResult,
  UpdateSettingsRequest,
  UserSettings,
} from '../api/settings.type';

export interface AppConfigState {
  configs: Partial<AppConfigs>;
  version: string | null;
  loadedAt: number;
  error: unknown;
  load: (options?: { force?: boolean }) => Promise<boolean>;
}

export interface SettingsState {
  settings: UserSettings;
  loaded: boolean;
  hydrate: () => Promise<void>;
  update: (patch: UpdateSettingsRequest) => Promise<boolean>;
  reset: () => void;
}

export interface TopupConfigState {
  config: TopupConfigResult | null;
  loading: boolean;
  load: () => Promise<void>;
}
