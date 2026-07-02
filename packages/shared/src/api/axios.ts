import axios, { type AxiosInstance } from 'axios';
import { env } from '../config';
import { registerInterceptors } from './interceptors';

declare module 'axios' {
  export interface AxiosRequestConfig {
    skipAuth?: boolean;
    skipAuthRefresh?: boolean;
    retried?: boolean;
  }
}

let instance: AxiosInstance | null = null;

export function getApi(): AxiosInstance {
  if (instance == null) {
    instance = axios.create({
      baseURL: env.apiUrl,
      timeout: env.apiTimeout,
      headers: {
        'Content-Type': 'application/json',
      },
    });
    registerInterceptors(instance);
  }
  return instance;
}
