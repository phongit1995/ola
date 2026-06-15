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

async function requestNewAccessToken(): Promise<string> {
  const refreshToken = adminTokens.getRefreshToken()
  if (!refreshToken) {
    throw new Error('Missing refresh token')
  }
  const { data } = await http.post<ApiResponse<AdminRefreshResult>>(
    '/admin/auth/refresh',
    { refreshToken },
    { skipAuth: true, skipAuthRefresh: true },
  )
  adminTokens.setTokens(data.data.token, data.data.refreshToken)
  return data.data.token
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
      !config.skipAuthRefresh &&
      adminTokens.getRefreshToken() != null

    if (!canRefresh || config == null) {
      return Promise.reject(toApiError(error))
    }

    config.retried = true

    try {
      if (!refreshPromise) {
        refreshPromise = requestNewAccessToken().finally(() => {
          refreshPromise = null
        })
      }
      const newAccessToken = await refreshPromise
      config.headers.Authorization = `Bearer ${newAccessToken}`
      return http(config)
    } catch (refreshError) {
      adminTokens.clear()
      onUnauthorized?.()
      return Promise.reject(toApiError(refreshError))
    }
  },
)

export default http
