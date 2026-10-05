import type { AxiosInstance } from 'axios';
import { API_HEADER } from '../../config/api';
import { getDeviceInfo } from '../../platform/deviceInfo';

export function registerDeviceInfoInterceptor(http: AxiosInstance): void {
  http.interceptors.request.use((config) => {
    const { platform, appVersion } = getDeviceInfo();
    if (platform) config.headers.set(API_HEADER.platform, platform);
    if (appVersion) config.headers.set(API_HEADER.appVersion, appVersion);
    return config;
  });
}
