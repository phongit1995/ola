import { http } from '../api';
import { API_PATH } from '../config';
import type { TopupConfigResult, UserSettings, UpdateSettingsRequest } from '../types';

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
