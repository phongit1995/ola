import type { AxiosError, AxiosInstance } from 'axios';
import type { IApiResponse, ApiErrorBody, RefreshTokenResult } from '@app-types';
import { API_PATH } from '@config';
import { authTokens, toApiError } from '@lib';

let onUnauthorized: (() => void) | null = null;

export function setOnUnauthorized(handler: (() => void) | null): void {
  onUnauthorized = handler;
}

let refreshPromise: Promise<string> | null = null;

export function registerRefreshTokenInterceptor(http: AxiosInstance): void {
  async function requestNewAccessToken(): Promise<string> {
    const refreshToken = authTokens.getRefreshToken();
    if (!refreshToken) {
      throw new Error('Missing refresh token');
    }

    const { data } = await http.post<IApiResponse<RefreshTokenResult>>(
      API_PATH.auth.refresh,
      { refreshToken },
      { skipAuth: true, skipAuthRefresh: true }
    );

    authTokens.setTokens(data.data.token, data.data.refreshToken);
    return data.data.token;
  }

  http.interceptors.response.use(
    (response) => response,
    async (error: AxiosError<ApiErrorBody>) => {
      const config = error.config;
      const status = error.response?.status;

      const canRefresh =
        status === 401 &&
        config != null &&
        !config.retried &&
        !config.skipAuthRefresh &&
        authTokens.getRefreshToken() != null;

      if (!canRefresh || config == null) {
        return Promise.reject(toApiError(error));
      }

      config.retried = true;

      try {
        if (!refreshPromise) {
          refreshPromise = requestNewAccessToken().finally(() => {
            refreshPromise = null;
          });
        }
        const newAccessToken = await refreshPromise;
        config.headers.Authorization = `Bearer ${newAccessToken}`;
        return http(config);
      } catch (refreshError) {
        authTokens.clear();
        onUnauthorized?.();
        return Promise.reject(toApiError(refreshError));
      }
    }
  );
}
