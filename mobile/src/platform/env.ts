import Config from 'react-native-config';
import { deriveSocketUrl, type SharedEnv } from '@ola/shared/platform';

const apiUrl = Config.API_URL ?? 'https://api-dev.olachat.net/api/v1';

export const mobileEnv: SharedEnv = {
  apiUrl,
  apiTimeout: Number(Config.API_TIMEOUT ?? 10000),
  apiGuardSecret: Config.API_GUARD_SECRET ?? '',
  socketUrl: Config.SOCKET_URL ?? deriveSocketUrl(apiUrl),
  geoapifyKey: Config.GEOAPIFY_KEY ?? '',
  isDev: __DEV__,
};
