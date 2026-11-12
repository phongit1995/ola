import type { ChatMessageData } from '../../src/sdk';

export const CHAT_MAX_LENGTH = 120;

export function chatAuthor(msg: ChatMessageData, selfId: string | undefined): string {
  return msg.userId === selfId ? 'Bạn' : `@${msg.name}`;
}

export function chatKeys(messages: readonly ChatMessageData[]): string[] {
  const seen = new Map<string, number>();
  return messages.map((msg) => {
    const base = `${msg.userId}-${msg.sentAt}`;
    const count = seen.get(base) ?? 0;
    seen.set(base, count + 1);
    return count === 0 ? base : `${base}-${count}`;
  });
}
