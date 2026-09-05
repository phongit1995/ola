import type { RoomMessage } from '../types/api/room.type';

export function filterVisibleRoomMessages(
  messages: RoomMessage[],
  blockedUserIds: string[]
): RoomMessage[] {
  if (blockedUserIds.length === 0) return messages;
  const blocked = new Set(blockedUserIds);
  return messages.filter((message) => !blocked.has(message.senderId));
}
