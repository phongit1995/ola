export type Gender = 'male' | 'female';

export interface SpouseInfo {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
}

export interface AuthUser {
  id: string;
  username: string;
  email: string;
  emailVerified: boolean;
  avatar?: string;
  coverPhoto?: string;
  phone?: string;
  fullName?: string;
  gender?: Gender;
  bio?: string;
  bioImage?: string | null;
  dateOfBirth?: string;
  customInfo?: Record<string, unknown>;
  ken?: number;
  vipUsed?: string | null;
  vipEndTime?: string | null;
  followerCount?: number;
  followingCount?: number;
  spouse?: SpouseInfo;
  createdAt?: string;
}

export interface UpdateProfileRequest {
  avatar?: string;
  coverPhoto?: string;
  phone?: string;
  fullName?: string;
  gender?: Gender;
  bio?: string;
  bioImage?: string | null;
  dateOfBirth?: string;
}

export interface UploadAvatarResult {
  url: string;
  secureUrl: string;
  publicId: string;
  format: string;
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

export interface ForgotPasswordConfirmRequest {
  username: string;
  code: string;
  newPassword: string;
}

export interface SendVerifyEmailRequest {
  email: string;
}

export interface SendVerifyEmailResult {
  verifyId: string;
  message: string;
}

export interface ConfirmVerifyEmailRequest {
  verifyId: string;
  code: string;
}

export interface ConfirmVerifyEmailResult {
  emailVerified: boolean;
  vipRewardDays?: number;
}
