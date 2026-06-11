import axios from 'axios';
import { env } from '@config';
import { registerInterceptors } from './interceptors';

declare module 'axios' {
  export interface AxiosRequestConfig {
    skipAuth?: boolean;
    skipAuthRefresh?: boolean;
    retried?: boolean;
  }
}

const api = axios.create({
  baseURL: env.apiUrl,
  timeout: env.apiTimeout,
  headers: {
    'Content-Type': 'application/json',
  },
});

registerInterceptors(api);

export default api;
