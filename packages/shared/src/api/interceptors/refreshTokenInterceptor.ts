import type { AxiosError, AxiosInstance } from 'axios';
import type { IApiResponse, ApiErrorBody, RefreshTokenResult } from '../../types';
import { API_PATH } from '../../config';
import { ApiError, authTokens, toApiError } from '../../lib';
import { base64DecodeToString } from '../../lib/base64';

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
    const payload = JSON.parse(base64DecodeToString(padded)) as { exp?: number };
    return typeof payload.exp === 'number' ? payload.exp * 1000 : null;
  } catch {
    return null;
  }
}

export function handleAuthExpired(): void {
  authTokens.clear();
  onUnauthorized?.();
}

function isAuthRejection(error: unknown): boolean {
  return error instanceof ApiError && error.status === 401;
}

export async function ensureFreshToken(): Promise<string> {
  const token = authTokens.getAccessToken();
  if (token == null || token === '') return '';
  const expMs = accessTokenExpMs(token);
  if (expMs != null && expMs > Date.now() + TOKEN_REFRESH_BUFFER_MS) return token;
  if (authTokens.getRefreshToken() == null) {
    handleAuthExpired();
    return '';
  }
  try {
    return await refreshAccessToken();
  } catch (error) {
    if (isAuthRejection(error)) {
      handleAuthExpired();
      return '';
    }
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
        const sessionDead =
          status === 401 &&
          config != null &&
          !config.skipAuth &&
          !config.skipAuthRefresh &&
          authTokens.getAccessToken() != null &&
          authTokens.getRefreshToken() == null;
        if (sessionDead) handleAuthExpired();
        return Promise.reject(toApiError(error));
      }

      config.retried = true;

      try {
        const newAccessToken = await refreshAccessToken();
        config.headers.Authorization = `Bearer ${newAccessToken}`;
        return http(config);
      } catch (refreshError) {
        if (isAuthRejection(refreshError) || !(refreshError instanceof ApiError)) {
          handleAuthExpired();
        }
        return Promise.reject(toApiError(refreshError));
      }
    }
  );
}
