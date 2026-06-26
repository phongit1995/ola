import type { AxiosError, AxiosInstance } from 'axios';
import type { IApiResponse, ApiErrorBody, RefreshTokenResult } from '@app-types';
import { API_PATH } from '@config';
import { authTokens, toApiError } from '@lib';

const TOKEN_REFRESH_BUFFER_MS = 30_000;

let onUnauthorized: (() => void) | null = null;

export function setOnUnauthorized(handler: (() => void) | null): void {
  onUnauthorized = handler;
}

let httpInstance: AxiosInstance | null = null;
let refreshPromise: Promise<string> | null = null;

async function requestNewAccessToken(): Promise<string> {
  const refreshToken = authTokens.getRefreshToken();
  if (!refreshToken || httpInstance == null) {
    throw new Error('Missing refresh token');
  }

  const { data } = await httpInstance.post<IApiResponse<RefreshTokenResult>>(
    API_PATH.auth.refresh,
    { refreshToken },
    { skipAuth: true, skipAuthRefresh: true }
  );

  authTokens.setTokens(data.data.token, data.data.refreshToken);
  return data.data.token;
}

export function refreshAccessToken(): Promise<string> {
  if (!refreshPromise) {
    refreshPromise = requestNewAccessToken().finally(() => {
      refreshPromise = null;
    });
  }
  return refreshPromise;
}

function accessTokenExpMs(token: string): number | null {
  const parts = token.split('.');
  if (parts.length < 2) return null;
  try {
    const base64 = parts[1]!.replace(/-/g, '+').replace(/_/g, '/');
    const padded = base64.padEnd(base64.length + ((4 - (base64.length % 4)) % 4), '=');
    const payload = JSON.parse(atob(padded)) as { exp?: number };
    return typeof payload.exp === 'number' ? payload.exp * 1000 : null;
  } catch {
    return null;
  }
}

export async function ensureFreshToken(): Promise<string> {
  const token = authTokens.getAccessToken();
  if (token == null || token === '') return '';
  const expMs = accessTokenExpMs(token);
  if (expMs != null && expMs > Date.now() + TOKEN_REFRESH_BUFFER_MS) return token;
  if (authTokens.getRefreshToken() == null) return token;
  try {
    return await refreshAccessToken();
  } catch {
    return token;
  }
}

export function registerRefreshTokenInterceptor(http: AxiosInstance): void {
  httpInstance = http;

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
        const newAccessToken = await refreshAccessToken();
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
