import type { AxiosInstance } from 'axios';
import { authTokens } from '@lib';

export function registerAuthTokenInterceptor(http: AxiosInstance): void {
  http.interceptors.request.use((config) => {
    if (!config.skipAuth) {
      const accessToken = authTokens.getAccessToken();
      if (accessToken) {
        config.headers.Authorization = `Bearer ${accessToken}`;
      }
    }
    return config;
  });
}
