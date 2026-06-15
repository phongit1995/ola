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

export interface AdminAccount {
  id: string
  username: string
  fullName?: string
  email?: string
  avatar?: string
  role: string
}

export interface AdminLoginRequest {
  username: string
  password: string
}

export interface AdminLoginResult {
  token: string
  refreshToken: string
  admin: AdminAccount
}

export interface AdminRefreshResult {
  token: string
  refreshToken: string
}

export interface MessageResult {
  message: string
}

export interface ListParams {
  q?: string
  limit?: number
  offset?: number
}

export interface ListResult<T> {
  items: T[]
  total: number
  limit: number
  offset: number
}

export interface AdminUserListItem {
  id: string
  username: string
  fullName?: string
  email?: string
  avatar?: string
  isActive: boolean
  createdAt: string
  lastLoginAt?: string | null
}

export interface AdminUserDetail extends AdminUserListItem {
  phone?: string
  bio?: string
  lastLoginIp?: string
  updatedAt?: string
}

export interface Room {
  id: string
  name: string
  description?: string
  imageUrl?: string
  maxMembers: number
  memberCount: number
  enabled: boolean
  createdBy: string
  createdAt: string
}

export interface CreateRoomRequest {
  name: string
  description?: string
  imageUrl?: string
  maxMembers?: number
}

export interface UpdateRoomRequest {
  name?: string
  description?: string
  imageUrl?: string
  maxMembers?: number
  enabled?: boolean
}
