export function shouldResetRoomFromSync(
  currentRoomId: string,
  inMatch: boolean,
  syncedRoomId?: string,
): boolean {
  return !inMatch && currentRoomId !== '' && syncedRoomId !== currentRoomId;
}
