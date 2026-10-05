import type { AxiosInstance } from 'axios';
import { registerApiGuardInterceptor } from './apiGuardInterceptor';
import { registerAuthTokenInterceptor } from './authTokenInterceptor';
import { registerDeviceInfoInterceptor } from './deviceInfoInterceptor';
import { registerLanguageInterceptor } from './languageInterceptor';
import { registerLoggingInterceptor } from './loggingInterceptor';
import { registerRefreshTokenInterceptor } from './refreshTokenInterceptor';

export function registerInterceptors(http: AxiosInstance): void {
  registerAuthTokenInterceptor(http);
  registerLanguageInterceptor(http);
  registerDeviceInfoInterceptor(http);
  registerRefreshTokenInterceptor(http);
  registerApiGuardInterceptor(http);
  registerLoggingInterceptor(http);
}
