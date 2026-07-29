import axios, { type AxiosInstance } from 'axios';
import { env } from '../config/env';
import { getApiInstance, setApiInstance } from './axios.state';
import { registerInterceptors } from './interceptors/registerInterceptors';

declare module 'axios' {
  export interface AxiosRequestConfig {
    skipAuth?: boolean;
    skipAuthRefresh?: boolean;
    retried?: boolean;
  }
}

export function getApi(): AxiosInstance {
  const existing = getApiInstance();
  if (existing != null) return existing;
  const instance = axios.create({
      baseURL: env.apiUrl,
      timeout: env.apiTimeout,
      headers: {
        'Content-Type': 'application/json',
      },
  });
  registerInterceptors(instance);
  setApiInstance(instance);
  return instance;
}
