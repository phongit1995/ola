export const PASSWORD_MIN = 6;
export const PASSWORD_MAX = 20;

export const EMAIL_VERIFY_ALLOWED_DOMAINS = ['gmail.com', 'yahoo.com', 'yahoo.com.vn', 'icloud.com'];

export function isAllowedVerifyEmailDomain(email: string): boolean {
  const domain = email.slice(email.lastIndexOf('@') + 1);
  return EMAIL_VERIFY_ALLOWED_DOMAINS.includes(domain);
}
