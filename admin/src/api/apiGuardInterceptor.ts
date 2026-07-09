import type { AxiosInstance, InternalAxiosRequestConfig } from 'axios'
import { guardCanonical, signGuard } from '@ola/api-guard'
import { env } from '@/config/env'

function resolveRequestPath(config: InternalAxiosRequestConfig): string {
  const base = config.baseURL ?? env.apiUrl
  const normalizedBase = base.endsWith('/') ? base : `${base}/`
  const url = config.url ?? ''
  const relativeUrl = url.startsWith('/') ? url.slice(1) : url
  return new URL(relativeUrl, normalizedBase).pathname
}

export function registerApiGuardInterceptor(http: AxiosInstance): void {
  if (!env.apiGuardSecret) return

  http.interceptors.request.use((config) => {
    const timestamp = Date.now().toString()
    const nonce = crypto.randomUUID()
    const method = (config.method ?? 'get').toUpperCase()
    const path = resolveRequestPath(config)

    const signature = signGuard(env.apiGuardSecret, guardCanonical(timestamp, nonce, method, path))

    config.headers.set('X-Timestamp', timestamp)
    config.headers.set('X-Nonce', nonce)
    config.headers.set('X-Signature', signature)
    return config
  })
}
