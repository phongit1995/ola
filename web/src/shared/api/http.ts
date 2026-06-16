import type { AxiosRequestConfig } from 'axios';
import type { IApiResponse } from '@app-types';
import api from './axios';

export const http = {
  get: <T>(url: string, config?: AxiosRequestConfig) =>
    api.get<IApiResponse<T>>(url, config).then((res) => res.data.data),
  post: <T>(url: string, body?: unknown, config?: AxiosRequestConfig) =>
    api.post<IApiResponse<T>>(url, body, config).then((res) => res.data.data),
  put: <T>(url: string, body?: unknown, config?: AxiosRequestConfig) =>
    api.put<IApiResponse<T>>(url, body, config).then((res) => res.data.data),
  patch: <T>(url: string, body?: unknown, config?: AxiosRequestConfig) =>
    api.patch<IApiResponse<T>>(url, body, config).then((res) => res.data.data),
  del: <T>(url: string, config?: AxiosRequestConfig) =>
    api.delete<IApiResponse<T>>(url, config).then((res) => res.data.data),
  postForm: <T>(url: string, body: FormData, config?: AxiosRequestConfig) =>
    api
      .post<IApiResponse<T>>(url, body, {
        ...config,
        headers: { 'Content-Type': 'multipart/form-data', ...config?.headers },
      })
      .then((res) => res.data.data),
};
