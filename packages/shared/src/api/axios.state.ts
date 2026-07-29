import type { AxiosInstance } from 'axios';

let apiInstance: AxiosInstance | null = null;

export function getApiInstance(): AxiosInstance | null {
  return apiInstance;
}

export function setApiInstance(instance: AxiosInstance): void {
  apiInstance = instance;
}
