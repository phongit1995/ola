import { getKeyValueStorage } from '../platform/keyValueStorage';

const ACCESS_TOKEN_KEY = 'ola.accessToken';
const REFRESH_TOKEN_KEY = 'ola.refreshToken';

export const authTokens = {
  getAccessToken(): string | null {
    return getKeyValueStorage().getItem(ACCESS_TOKEN_KEY);
  },
  getRefreshToken(): string | null {
    return getKeyValueStorage().getItem(REFRESH_TOKEN_KEY);
  },
  setTokens(accessToken: string, refreshToken: string): void {
    getKeyValueStorage().setItem(ACCESS_TOKEN_KEY, accessToken);
    getKeyValueStorage().setItem(REFRESH_TOKEN_KEY, refreshToken);
  },
  clear(): void {
    getKeyValueStorage().removeItem(ACCESS_TOKEN_KEY);
    getKeyValueStorage().removeItem(REFRESH_TOKEN_KEY);
  },
};
