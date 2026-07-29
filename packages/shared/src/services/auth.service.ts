import { getApi } from '../api/axios';
import { http } from '../api/http';
import { API_PATH } from '../config/api';
import { authTokens } from '../lib/tokenStorage';
import { getDeviceInfo } from '../platform/deviceInfo';
import type {
  AuthResult,
  ChangePasswordRequest,
  ConfirmVerifyEmailRequest,
  ConfirmVerifyEmailResult,
  LoginRequest,
  MessageResult,
  RefreshTokenResult,
  RegisterRequest,
  RegisterResult,
  SendVerifyEmailRequest,
  SendVerifyEmailResult,
} from '../types/api/auth.type';

export class AuthService {
  static async login(payload: LoginRequest): Promise<AuthResult> {
    const result = await http.post<AuthResult>(API_PATH.auth.login, {
      ...payload,
      device: getDeviceInfo(),
    });
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

  static sendVerifyEmail(payload: SendVerifyEmailRequest): Promise<SendVerifyEmailResult> {
    return http.post<SendVerifyEmailResult>(API_PATH.auth.sendVerifyEmail, payload);
  }

  static confirmVerifyEmail(payload: ConfirmVerifyEmailRequest): Promise<ConfirmVerifyEmailResult> {
    return http.post<ConfirmVerifyEmailResult>(API_PATH.auth.confirmVerifyEmail, payload);
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
