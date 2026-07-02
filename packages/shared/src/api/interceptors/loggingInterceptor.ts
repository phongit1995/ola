import type { AxiosError, AxiosInstance } from 'axios';
import { env } from '../../config';

export function registerLoggingInterceptor(http: AxiosInstance): void {
  if (!env.isDev) {
    return;
  }

  http.interceptors.request.use((config) => {
    console.debug(`[api] → ${config.method?.toUpperCase()} ${config.url}`);
    return config;
  });

  http.interceptors.response.use(
    (response) => {
      console.debug(`[api] ← ${response.status} ${response.config.url}`);
      return response;
    },
    (error: AxiosError) => {
      console.debug(`[api] ✗ ${error.response?.status ?? 'ERR'} ${error.config?.url}`);
      return Promise.reject(error);
    }
  );
}
