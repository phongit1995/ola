import type {
  TopupConfigResult,
  UpdateSettingsRequest,
  UserSettings,
} from '../api/settings.type';

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
