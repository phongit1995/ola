import { api } from '@api';
import { API_PATH } from '@config';
import { authTokens } from '@lib';
import type {
  IApiResponse,
  AuthResult,
  ChangePasswordRequest,
  LoginRequest,
  MessageResult,
  RefreshTokenResult,
  RegisterRequest,
  RegisterResult,
} from '@app-types';

export class AuthService {
  static async login(payload: LoginRequest): Promise<AuthResult> {
    const { data } = await api.post<IApiResponse<AuthResult>>(API_PATH.auth.login, payload);
    const result = data.data;
    authTokens.setTokens(result.token, result.refreshToken);
    return result;
  }

  static async register(payload: RegisterRequest): Promise<RegisterResult> {
    const { data } = await api.post<IApiResponse<RegisterResult>>(API_PATH.auth.register, payload);
    return data.data;
  }

  static async refresh(): Promise<RefreshTokenResult> {
    const current = authTokens.getRefreshToken();
    if (!current) {
      throw new Error('Missing refresh token');
    }
    const { data } = await api.post<IApiResponse<RefreshTokenResult>>(
      API_PATH.auth.refresh,
      { refreshToken: current },
      { skipAuth: true, skipAuthRefresh: true }
    );
    const result = data.data;
    authTokens.setTokens(result.token, result.refreshToken);
    return result;
  }

  static async changePassword(payload: ChangePasswordRequest): Promise<MessageResult> {
    const { data } = await api.post<IApiResponse<MessageResult>>(
      API_PATH.auth.changePassword,
      payload
    );
    return data.data;
  }

  static async logout(): Promise<void> {
    try {
      await api.post(API_PATH.auth.logout);
    } finally {
      authTokens.clear();
    }
  }

  static isAuthenticated(): boolean {
    return authTokens.getAccessToken() != null;
  }

  static getAccessToken(): string | null {
    return authTokens.getAccessToken();
  }
}
