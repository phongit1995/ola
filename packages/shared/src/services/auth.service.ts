import { getApi, http } from '../api';
import { API_PATH } from '../config';
import { authTokens } from '../lib';
import type {
  AuthResult,
  ChangePasswordRequest,
  LoginRequest,
  MessageResult,
  RefreshTokenResult,
  RegisterRequest,
  RegisterResult,
} from '../types';

export class AuthService {
  static async login(payload: LoginRequest): Promise<AuthResult> {
    const result = await http.post<AuthResult>(API_PATH.auth.login, payload);
    authTokens.setTokens(result.token, result.refreshToken);
    return result;
  }

  static register(payload: RegisterRequest): Promise<RegisterResult> {
    return http.post<RegisterResult>(API_PATH.auth.register, payload);
  }

  static async refresh(): Promise<RefreshTokenResult> {
    const current = authTokens.getRefreshToken();
    if (!current) {
      throw new Error('Missing refresh token');
    }
    const result = await http.post<RefreshTokenResult>(
      API_PATH.auth.refresh,
      { refreshToken: current },
      { skipAuth: true, skipAuthRefresh: true }
    );
    authTokens.setTokens(result.token, result.refreshToken);
    return result;
  }

  static changePassword(payload: ChangePasswordRequest): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.auth.changePassword, payload);
  }

  static async logout(): Promise<void> {
    try {
      await getApi().post(API_PATH.auth.logout);
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
