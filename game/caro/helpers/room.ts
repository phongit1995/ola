export const ROOM_PASSWORD_MAX_LENGTH = 64;

export function roomCreationError(
  bet: number,
  password: string,
  availableKen: number | null,
  maxBet: number | null,
): string | null {
  if (!Number.isSafeInteger(bet) || bet < 0 || (maxBet != null && bet > maxBet)) {
    return 'Số Ken cược không hợp lệ';
  }
  if (availableKen != null && bet > availableKen) {
    return 'Bạn không đủ Ken để tạo bàn';
  }
  if (password.length > ROOM_PASSWORD_MAX_LENGTH) {
    return `Mật khẩu tối đa ${ROOM_PASSWORD_MAX_LENGTH} ký tự`;
  }
  return null;
}
