import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  AppConfigResult,
  AppUpdateResult,
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

  static appConfig(version?: string): Promise<AppConfigResult> {
    return http.get<AppConfigResult>(API_PATH.appSettings, {
      params: version ? { version } : undefined,
    });
  }

  static appUpdate(): Promise<AppUpdateResult> {
    return http.get<AppUpdateResult>(API_PATH.appUpdate);
  }
}
