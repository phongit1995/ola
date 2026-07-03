export interface SharedEnv {
  apiUrl: string;
  apiTimeout: number;
  apiGuardSecret: string;
  socketUrl: string;
  geoapifyKey: string;
  isDev: boolean;
}

let current: SharedEnv | null = null;

export function configureEnv(value: SharedEnv): void {
  current = value;
}

function requireEnv(): SharedEnv {
  if (current == null) {
    throw new Error('Shared env is not configured. Call configureEnv() at app bootstrap.');
  }
  return current;
}

export function deriveSocketUrl(apiUrl: string): string {
  return apiUrl.replace(/\/api\/v\d+\/?$/, '');
}

export const env = {
  get apiUrl(): string {
    return requireEnv().apiUrl;
  },
  get apiTimeout(): number {
    return requireEnv().apiTimeout;
  },
  get apiGuardSecret(): string {
    return requireEnv().apiGuardSecret;
  },
  get socketUrl(): string {
    return requireEnv().socketUrl;
  },
  get geoapifyKey(): string {
    return requireEnv().geoapifyKey;
  },
  get isDev(): boolean {
    return requireEnv().isDev;
  },
};
