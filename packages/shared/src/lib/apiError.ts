import axios from 'axios';
import type { TFunction } from 'i18next';
import type { ApiErrorBody } from '../types';

interface ApiErrorMeta {
  traceId?: string;
  path?: string;
  code?: string;
}

export class ApiError extends Error {
  readonly status: number;
  readonly traceId?: string;
  readonly path?: string;
  readonly code?: string;

  constructor(status: number, message: string, meta?: ApiErrorMeta) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.traceId = meta?.traceId;
    this.path = meta?.path;
    this.code = meta?.code;
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
      code: body?.code,
    });
  }

  const message = error instanceof Error ? error.message : 'Unknown error';
  return new ApiError(0, message);
}

export function resolveAuthError(error: unknown, t: TFunction): string {
  if (error instanceof ApiError) {
    return error.status === 0 ? t('auth.errNetwork') : error.message;
  }
  return t('auth.errGeneric');
}
