import type { AxiosInstance } from 'axios';
import i18n from '@/i18n';

export function registerLanguageInterceptor(http: AxiosInstance): void {
  http.interceptors.request.use((config) => {
    if (i18n.language) {
      config.headers['Accept-Language'] = i18n.language;
    }
    return config;
  });
}
