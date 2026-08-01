export const ADMIN_ACCESS_TOKEN_KEY = 'ola.admin.accessToken'
const LEGACY_ADMIN_REFRESH_TOKEN_KEY = 'ola.admin.refreshToken'

export const adminTokens = {
  getAccessToken(): string | null {
    return localStorage.getItem(ADMIN_ACCESS_TOKEN_KEY)
  },
  setAccessToken(accessToken: string): void {
    localStorage.setItem(ADMIN_ACCESS_TOKEN_KEY, accessToken)
    localStorage.removeItem(LEGACY_ADMIN_REFRESH_TOKEN_KEY)
  },
  clearLegacyRefreshToken(): void {
    localStorage.removeItem(LEGACY_ADMIN_REFRESH_TOKEN_KEY)
  },
  clear(): void {
    localStorage.removeItem(ADMIN_ACCESS_TOKEN_KEY)
    localStorage.removeItem(LEGACY_ADMIN_REFRESH_TOKEN_KEY)
  },
}
