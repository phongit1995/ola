/**
 * Nối className có điều kiện (gọn, không cần thư viện ngoài).
 * Dùng: cn('p-2', isActive && 'bg-ola-primary', cls)
 */
export function cn(
  ...classes: Array<string | false | null | undefined>
): string {
  return classes.filter(Boolean).join(' ');
}
