import { deriveSocketUrl, type SharedEnv } from '@ola/shared/platform';

const apiUrl = import.meta.env.VITE_API_URL ?? 'http://localhost:8080/api/v1';

export const webEnv: SharedEnv = {
  apiUrl,
  apiTimeout: Number(import.meta.env.VITE_API_TIMEOUT ?? 10000),
  apiGuardSecret: import.meta.env.VITE_API_GUARD_SECRET ?? '',
  socketUrl: import.meta.env.VITE_SOCKET_URL ?? deriveSocketUrl(apiUrl),
  geoapifyKey: import.meta.env.VITE_GEOAPIFY_KEY ?? '',
  isDev: import.meta.env.DEV,
};
