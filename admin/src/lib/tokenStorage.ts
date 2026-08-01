export const ADMIN_ACCESS_TOKEN_KEY = 'ola.admin.accessToken'
export const ADMIN_REFRESH_TOKEN_KEY = 'ola.admin.refreshToken'

export const adminTokens = {
  getAccessToken(): string | null {
    return localStorage.getItem(ADMIN_ACCESS_TOKEN_KEY)
  },
  getRefreshToken(): string | null {
    return localStorage.getItem(ADMIN_REFRESH_TOKEN_KEY)
  },
  setTokens(accessToken: string, refreshToken: string): void {
    localStorage.setItem(ADMIN_ACCESS_TOKEN_KEY, accessToken)
    localStorage.setItem(ADMIN_REFRESH_TOKEN_KEY, refreshToken)
  },
  clear(): void {
    localStorage.removeItem(ADMIN_ACCESS_TOKEN_KEY)
    localStorage.removeItem(ADMIN_REFRESH_TOKEN_KEY)
  },
}
