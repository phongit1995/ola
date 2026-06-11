import axios from 'axios';
import type { ApiErrorBody } from '@app-types';

interface ApiErrorMeta {
  traceId?: string;
  path?: string;
}

export class ApiError extends Error {
  readonly status: number;
  readonly traceId?: string;
  readonly path?: string;

  constructor(status: number, message: string, meta?: ApiErrorMeta) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.traceId = meta?.traceId;
    this.path = meta?.path;
  }
}

export function toApiError(error: unknown): ApiError {
  if (error instanceof ApiError) {
    return error;
  }

  if (axios.isAxiosError<ApiErrorBody>(error)) {
    const body = error.response?.data;
    const status = error.response?.status ?? 0;
    const message = body?.error || error.message || 'Network error';
    return new ApiError(status, message, {
      traceId: body?.traceId,
      path: body?.path,
    });
  }

  const message = error instanceof Error ? error.message : 'Unknown error';
  return new ApiError(0, message);
}
