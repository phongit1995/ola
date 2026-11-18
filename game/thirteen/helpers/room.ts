export const ROOM_PASSWORD_MAX_LENGTH = 32;
export const ROOM_SEATS = 4;
export const MIN_ROOM_SEATS = 2;

export type RoomSeatSlot = { kind: 'member'; index: number } | { kind: 'open' } | { kind: 'closed' };

export function roomSeatSlots(memberCount: number, maxPlayers: number | undefined): RoomSeatSlot[] {
  const open = Math.min(ROOM_SEATS, Math.max(MIN_ROOM_SEATS, maxPlayers ?? ROOM_SEATS, memberCount));
  return Array.from({ length: ROOM_SEATS }, (_, index): RoomSeatSlot => {
    if (index < memberCount) return { kind: 'member', index };
    return index < open ? { kind: 'open' } : { kind: 'closed' };
  });
}

export function canCloseSeat(memberCount: number, maxPlayers: number | undefined): boolean {
  const open = maxPlayers ?? ROOM_SEATS;
  return open > MIN_ROOM_SEATS && open > memberCount;
}

export function formatKen(value: number): string {
  const safeValue = Number.isFinite(value) ? Math.max(0, Math.trunc(value)) : 0;
  return safeValue.toLocaleString('vi-VN');
}

export function formatBetInput(input: string): string {
  const digits = input.replace(/\D/g, '').slice(0, 15);
  if (!digits) return '0';
  const value = Number(digits);
  return Number.isSafeInteger(value) ? formatKen(value) : digits;
}

export function parseBetInput(input: string): number {
  const digits = input.replace(/\D/g, '');
  return digits ? Number(digits) : 0;
}

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
