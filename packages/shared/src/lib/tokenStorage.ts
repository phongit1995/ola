import {
  ACCESS_TOKEN_STORAGE_KEY,
  REFRESH_TOKEN_STORAGE_KEY,
} from '../constants/storage';
import { getKeyValueStorage } from '../platform/keyValueStorage';

export const authTokens = {
  getAccessToken(): string | null {
    return getKeyValueStorage().getItem(ACCESS_TOKEN_STORAGE_KEY);
  },
  getRefreshToken(): string | null {
    return getKeyValueStorage().getItem(REFRESH_TOKEN_STORAGE_KEY);
  },
  setTokens(accessToken: string, refreshToken: string): void {
    getKeyValueStorage().setItem(ACCESS_TOKEN_STORAGE_KEY, accessToken);
    getKeyValueStorage().setItem(REFRESH_TOKEN_STORAGE_KEY, refreshToken);
  },
  clear(): void {
    getKeyValueStorage().removeItem(ACCESS_TOKEN_STORAGE_KEY);
    getKeyValueStorage().removeItem(REFRESH_TOKEN_STORAGE_KEY);
  },
};
