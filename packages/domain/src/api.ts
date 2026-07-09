export interface ApiResponse<T> {
  success: boolean
  status: number
  traceId: string
  timestamp: string
  path: string
  data: T
  error?: string
}

export interface ApiErrorBody {
  success: false
  status: number
  traceId?: string
  timestamp?: string
  path?: string
  error: string
}

export interface ListResult<T> {
  items: T[]
  total: number
  limit: number
  offset: number
}
