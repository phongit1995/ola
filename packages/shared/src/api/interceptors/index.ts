import type { AxiosInstance } from 'axios';
import { registerAuthTokenInterceptor } from './authTokenInterceptor';
import { registerLanguageInterceptor } from './languageInterceptor';
import { registerRefreshTokenInterceptor } from './refreshTokenInterceptor';
import { registerApiGuardInterceptor } from './apiGuardInterceptor';
import { registerLoggingInterceptor } from './loggingInterceptor';

export { setOnUnauthorized, ensureFreshToken, refreshAccessToken } from './refreshTokenInterceptor';

export function registerInterceptors(http: AxiosInstance): void {
  registerAuthTokenInterceptor(http);
  registerLanguageInterceptor(http);
  registerRefreshTokenInterceptor(http);
  registerApiGuardInterceptor(http);
  registerLoggingInterceptor(http);
}
