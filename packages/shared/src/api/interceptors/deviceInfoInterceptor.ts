import type { AxiosInstance } from 'axios';
import { API_HEADER } from '../../config/api';
import { getCurrentDeviceInfo } from '../../platform/platformRuntime.state';

export function registerDeviceInfoInterceptor(http: AxiosInstance): void {
  http.interceptors.request.use((config) => {
    const device = getCurrentDeviceInfo();
    if (device?.platform) config.headers.set(API_HEADER.platform, device.platform);
    if (device?.appVersion) config.headers.set(API_HEADER.appVersion, device.appVersion);
    return config;
  });
}
