import axios, { type AxiosError, type AxiosInstance } from 'axios'
import { env } from '@/config/env'
import { adminTokens } from '@/lib/tokenStorage'
import { toApiError } from '@/lib/apiError'
import type { ApiResponse, ApiErrorBody, AdminRefreshResult } from '@/types'
import { registerApiGuardInterceptor } from './apiGuardInterceptor'

declare module 'axios' {
  export interface AxiosRequestConfig {
    skipAuth?: boolean
    skipAuthRefresh?: boolean
    retried?: boolean
  }
}

let onUnauthorized: (() => void) | null = null

export function setOnUnauthorized(handler: (() => void) | null): void {
  onUnauthorized = handler
}

const http: AxiosInstance = axios.create({
  baseURL: env.apiUrl,
  timeout: env.apiTimeout,
  withCredentials: true,
  headers: { 'Content-Type': 'application/json' },
})

http.interceptors.request.use((config) => {
  if (!config.skipAuth) {
    const accessToken = adminTokens.getAccessToken()
    if (accessToken) {
      config.headers.Authorization = `Bearer ${accessToken}`
    }
  }
  return config
})

registerApiGuardInterceptor(http)

let refreshPromise: Promise<string> | null = null

async function withRefreshLock<T>(callback: () => Promise<T>): Promise<T> {
  if (!('locks' in navigator)) {
    // The API's idempotent retry window returns the same token pair if two
    // tabs race in browsers/contexts where Web Locks is unavailable.
    return callback()
  }
  return navigator.locks.request('ola.admin.refresh-token', callback)
}

function bearerToken(authorization: unknown): string | null {
  if (typeof authorization !== 'string') return null
  const [scheme, token] = authorization.split(' ')
  return scheme === 'Bearer' && token ? token : null
}

async function requestNewAccessToken(failedAccessToken: string | null): Promise<string> {
  return withRefreshLock(async () => {
    const currentAccessToken = adminTokens.getAccessToken()

    // Another tab may have refreshed while this request was waiting for the
    // browser-wide lock. Reuse its new access token instead of rotating again.
    if (
      failedAccessToken &&
      currentAccessToken &&
      currentAccessToken !== failedAccessToken
    ) {
      return currentAccessToken
    }

    const { data } = await http.post<ApiResponse<AdminRefreshResult>>(
      '/admin/auth/refresh',
      undefined,
      { skipAuth: true, skipAuthRefresh: true },
    )
    adminTokens.setAccessToken(data.data.token)
    return data.data.token
  })
}

http.interceptors.response.use(
  (response) => response,
  async (error: AxiosError<ApiErrorBody>) => {
    const config = error.config
    const status = error.response?.status

    const canRefresh =
      status === 401 &&
      config != null &&
      !config.retried &&
      !config.skipAuth &&
      !config.skipAuthRefresh

    if (!canRefresh || config == null) {
      if (
        status === 401 &&
        config != null &&
        !config.skipAuth &&
        !config.skipAuthRefresh
      ) {
        adminTokens.clear()
        onUnauthorized?.()
      }
      return Promise.reject(toApiError(error))
    }

    config.retried = true

    try {
      if (!refreshPromise) {
        const failedAccessToken = bearerToken(config.headers.get('Authorization'))
        refreshPromise = requestNewAccessToken(failedAccessToken).finally(() => {
          refreshPromise = null
        })
      }
      const newAccessToken = await refreshPromise
      config.headers.Authorization = `Bearer ${newAccessToken}`
      return http(config)
    } catch (refreshError) {
      const apiError = toApiError(refreshError)
      if ([401, 403, 404].includes(apiError.status)) {
        adminTokens.clear()
        onUnauthorized?.()
      }
      return Promise.reject(apiError)
    }
  },
)

export default http
