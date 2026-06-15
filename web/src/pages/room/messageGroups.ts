import type { RoomMessage } from '@app-types';

export type BubblePosition = 'single' | 'first' | 'middle' | 'last';

export interface GroupedMessage {
  id: string;
  content: string;
  createdAt: string;
  position: BubblePosition;
}

export interface MessageGroup {
  kind: 'group';
  key: string;
  isOwn: boolean;
  senderId: string;
  senderName: string;
  senderAvatar?: string;
  messages: GroupedMessage[];
}

export interface DateSeparator {
  kind: 'date';
  key: string;
  createdAt: string;
}

export type RoomFeedItem = MessageGroup | DateSeparator;

const GROUP_GAP_MS = 5 * 60 * 1000;

function dayKey(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return iso;
  return `${date.getFullYear()}-${date.getMonth()}-${date.getDate()}`;
}

function bubblePosition(count: number, index: number): BubblePosition {
  if (count === 1) return 'single';
  if (index === 0) return 'first';
  if (index === count - 1) return 'last';
  return 'middle';
}

interface PendingGroup {
  isOwn: boolean;
  senderId: string;
  senderName: string;
  senderAvatar?: string;
  raw: RoomMessage[];
}

export function buildRoomFeed(messages: RoomMessage[], currentUserId: string): RoomFeedItem[] {
  const items: RoomFeedItem[] = [];
  let pending: PendingGroup | null = null;
  let lastDay = '';
  let lastTime = 0;

  const flush = () => {
    if (pending == null) return;
    const count = pending.raw.length;
    items.push({
      kind: 'group',
      key: pending.raw[0].id,
      isOwn: pending.isOwn,
      senderId: pending.senderId,
      senderName: pending.senderName,
      senderAvatar: pending.senderAvatar,
      messages: pending.raw.map((message, index) => ({
        id: message.id,
        content: message.content,
        createdAt: message.createdAt,
        position: bubblePosition(count, index),
      })),
    });
    pending = null;
  };

  for (const message of messages) {
    const day = dayKey(message.createdAt);
    const time = new Date(message.createdAt).getTime();

    if (day !== lastDay) {
      flush();
      items.push({ kind: 'date', key: `date-${day}-${message.id}`, createdAt: message.createdAt });
      lastDay = day;
      lastTime = 0;
    }

    const gap = Number.isNaN(time) || lastTime === 0 ? 0 : time - lastTime;
    const sameGroup =
      pending != null && pending.senderId === message.senderId && gap <= GROUP_GAP_MS;

    if (sameGroup && pending != null) {
      pending.raw.push(message);
    } else {
      flush();
      pending = {
        isOwn: message.senderId === currentUserId,
        senderId: message.senderId,
        senderName: message.senderName ?? message.senderId,
        senderAvatar: message.senderAvatar,
        raw: [message],
      };
    }

    lastTime = Number.isNaN(time) ? lastTime : time;
  }

  flush();
  return items;
}
