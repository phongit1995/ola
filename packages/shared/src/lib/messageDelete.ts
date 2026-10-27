import { CHAT_MESSAGE_DELETE_WINDOW_MS } from '../constants/chat';

export function isWithinMessageDeleteWindow(
  createdAt: string | null | undefined,
  now: number = Date.now()
): boolean {
  if (createdAt == null || createdAt === '') return true;
  const sentAt = Date.parse(createdAt);
  if (Number.isNaN(sentAt)) return true;
  return now - sentAt <= CHAT_MESSAGE_DELETE_WINDOW_MS;
}
