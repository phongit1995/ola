import { ROOM_MESSAGE_GROUP_GAP_MS } from '../constants/room';
import type { RoomMessage, RoomReplySnapshot } from '../types/api/room.type';
import type {
  BubblePosition,
  PendingMessageGroup,
  RoomFeedItem,
} from '../types/client/roomFeed.type';

export type {
  BubblePosition,
  DateSeparator,
  GroupedMessage,
  MessageGroup,
  RoomFeedItem,
} from '../types/client/roomFeed.type';

function renderKey(message: RoomMessage): string {
  return message.clientMsgId ?? message.id;
}

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

function resolveReplySnapshot(
  reply: RoomReplySnapshot | undefined,
  byId: Map<string, RoomMessage>
): RoomReplySnapshot | undefined {
  if (reply == null || reply.type === 'image') return reply;
  const original = byId.get(reply.messageId);
  if (original?.type === 'image') {
    return { ...reply, type: 'image', imageUrl: reply.imageUrl ?? original.imageUrl };
  }
  return reply;
}

export function buildRoomFeed(messages: RoomMessage[], currentUserId: string): RoomFeedItem[] {
  const byId = new Map(messages.map((message) => [message.id, message]));
  const items: RoomFeedItem[] = [];
  let pending: PendingMessageGroup | null = null;
  let lastDay = '';
  let lastTime = 0;
  let lastShownMinute = -1;

  const minuteBucket = (iso: string): number => {
    const value = new Date(iso).getTime();
    return Number.isNaN(value) ? -1 : Math.floor(value / 60000);
  };

  const flush = () => {
    if (pending == null) return;
    const count = pending.raw.length;
    const bucket = minuteBucket(pending.raw[0]!.createdAt);
    const showTime = bucket !== lastShownMinute;
    if (showTime) lastShownMinute = bucket;
    items.push({
      kind: 'group',
      key: renderKey(pending.raw[0]!),
      isOwn: pending.isOwn,
      senderId: pending.senderId,
      senderName: pending.senderName,
      senderAvatar: pending.senderAvatar,
      senderVipTypeId: pending.senderVipTypeId,
      showTime,
      messages: pending.raw.map((message, index) => ({
        id: message.id,
        key: renderKey(message),
        content: message.content,
        type: message.type,
        imageUrl: message.imageUrl,
        audioUrl: message.audioUrl,
        audioDuration: message.audioDuration,
        audioWaveform: message.audioWaveform,
        audioMimeType: message.audioMimeType,
        createdAt: message.createdAt,
        position: bubblePosition(count, index),
        replyTo: resolveReplySnapshot(message.replyTo, byId),
        reactions: message.reactions,
        status: message.status,
      })),
    });
    pending = null;
  };

  for (const message of messages) {
    const day = dayKey(message.createdAt);
    const time = new Date(message.createdAt).getTime();

    if (day !== lastDay) {
      flush();
      items.push({ kind: 'date', key: `date-${day}`, createdAt: message.createdAt });
      lastDay = day;
      lastTime = 0;
      lastShownMinute = -1;
    }

    const gap = Number.isNaN(time) || lastTime === 0 ? 0 : time - lastTime;
    const sameGroup =
      pending != null &&
      pending.senderId === message.senderId &&
      gap <= ROOM_MESSAGE_GROUP_GAP_MS &&
      message.replyTo == null;

    if (sameGroup && pending != null) {
      pending.raw.push(message);
    } else {
      flush();
      pending = {
        isOwn: message.senderId === currentUserId,
        senderId: message.senderId,
        senderName: message.senderName ?? message.senderId,
        senderAvatar: message.senderAvatar,
        senderVipTypeId: message.senderVipTypeId,
        raw: [message],
      };
    }

    lastTime = Number.isNaN(time) ? lastTime : time;
  }

  flush();
  return items;
}
