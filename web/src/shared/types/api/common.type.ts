export interface IApiResponse<T> {
  success: boolean;
  status: number;
  traceId: string;
  timestamp: string;
  path: string;
  data: T;
  error?: string;
}

export interface ApiErrorBody {
  success: false;
  status: number;
  traceId?: string;
  timestamp?: string;
  path?: string;
  error: string;
}
