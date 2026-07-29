import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  TopupConfigResult,
  UpdateSettingsRequest,
  UserSettings,
} from '../types/api/settings.type';

export class SettingsService {
  static get(): Promise<UserSettings> {
    return http.get<UserSettings>(API_PATH.userSettings);
  }

  static update(patch: UpdateSettingsRequest): Promise<UserSettings> {
    return http.put<UserSettings>(API_PATH.userSettings, patch);
  }

  static topupConfig(): Promise<TopupConfigResult> {
    return http.get<TopupConfigResult>(API_PATH.appSettings.topup);
  }
}
