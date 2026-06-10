import { http } from './http';

export interface AuthPayload {
  username: string;
  password: string;
}

export interface AuthResult {
  token: string;
  username: string;
}

export async function login(payload: AuthPayload): Promise<AuthResult> {
  const { data } = await http.post<AuthResult>('/auth/login', payload);
  return data;
}

export async function register(payload: AuthPayload): Promise<AuthResult> {
  const { data } = await http.post<AuthResult>('/auth/register', payload);
  return data;
}
