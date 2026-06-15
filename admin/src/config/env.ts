const apiUrl = import.meta.env.VITE_API_URL ?? 'http://localhost:8080/api/v1'

export const env = {
  apiUrl,
  apiTimeout: Number(import.meta.env.VITE_API_TIMEOUT ?? 15000),
  apiGuardSecret: import.meta.env.VITE_API_GUARD_SECRET ?? '',
} as const
