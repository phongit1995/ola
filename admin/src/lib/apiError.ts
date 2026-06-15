import axios from 'axios'
import type { ApiErrorBody } from '@/types'

export class ApiError extends Error {
  readonly status: number
  readonly traceId?: string

  constructor(status: number, message: string, traceId?: string) {
    super(message)
    this.name = 'ApiError'
    this.status = status
    this.traceId = traceId
  }
}

export function toApiError(error: unknown): ApiError {
  if (error instanceof ApiError) {
    return error
  }
  if (axios.isAxiosError<ApiErrorBody>(error)) {
    const body = error.response?.data
    const status = error.response?.status ?? 0
    const message = body?.error || error.message || 'Network error'
    return new ApiError(status, message, body?.traceId)
  }
  const message = error instanceof Error ? error.message : 'Unknown error'
  return new ApiError(0, message)
}
