export type Gender = 'male' | 'female';

export interface AuthUser {
  id: string;
  username: string;
  email: string;
  avatar?: string;
  phone?: string;
  fullName?: string;
  gender?: Gender;
  bio?: string;
  dateOfBirth?: string;
  customInfo?: Record<string, unknown>;
  ken?: number;
  vipUsed?: string | null;
  vipEndTime?: string | null;
  followerCount?: number;
  followingCount?: number;
}

export interface LoginRequest {
  username: string;
  password: string;
}

export interface RegisterRequest {
  username: string;
  password: string;
}

export interface ChangePasswordRequest {
  currentPassword: string;
  newPassword: string;
}

export interface AuthResult {
  token: string;
  refreshToken: string;
  user: AuthUser;
}

export interface RegisterResult {
  user: AuthUser;
  message: string;
}

export interface RefreshTokenResult {
  token: string;
  refreshToken: string;
}

export interface MessageResult {
  message: string;
}
