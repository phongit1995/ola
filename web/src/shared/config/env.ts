export const env = {
  apiUrl: import.meta.env.VITE_API_URL ?? 'http://localhost:8080/api/v1',
  apiTimeout: Number(import.meta.env.VITE_API_TIMEOUT ?? 10000),
} as const;
