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
