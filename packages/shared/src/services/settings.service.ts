import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  StoryConfigResult,
  TopupConfigResult,
  UpdateSettingsRequest,
  UserSettings,
  UsernameChangeConfigResult,
  WordChainConfigResult,
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

  static usernameChangeConfig(): Promise<UsernameChangeConfigResult> {
    return http.get<UsernameChangeConfigResult>(API_PATH.appSettings.usernameChange);
  }

  static wordChainConfig(): Promise<WordChainConfigResult> {
    return http.get<WordChainConfigResult>(API_PATH.appSettings.wordChain);
  }

  static storyConfig(): Promise<StoryConfigResult> {
    return http.get<StoryConfigResult>(API_PATH.appSettings.story);
  }
}
