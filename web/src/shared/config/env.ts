const apiUrl = import.meta.env.VITE_API_URL ?? 'http://localhost:8080/api/v1';

export const env = {
  apiUrl,
  apiTimeout: Number(import.meta.env.VITE_API_TIMEOUT ?? 10000),
  apiGuardSecret: import.meta.env.VITE_API_GUARD_SECRET ?? '',
  socketUrl: import.meta.env.VITE_SOCKET_URL ?? apiUrl.replace(/\/api\/v\d+\/?$/, ''),
  geoapifyKey: import.meta.env.VITE_GEOAPIFY_KEY ?? '',
} as const;
