import { activeVipTypeId } from '../lib';
import type { RoomMember, RoomMessage } from '../types';
import { useAuthStore } from './authStore';

export function toRecord(value: unknown): Record<string, unknown> | null {
  return typeof value === 'object' && value !== null ? (value as Record<string, unknown>) : null;
}

export function withVipTypeId(members: RoomMember[]): RoomMember[] {
  const resolved = members.map((member) => ({
    ...member,
    vipTypeId: activeVipTypeId(member.vipUsed, member.vipEndTime),
  }));
  const vip = resolved.filter((member) => member.vipTypeId != null);
  const rest = resolved.filter((member) => member.vipTypeId == null);
  return [...vip, ...rest];
}

export function withSenderVip(message: RoomMessage): RoomMessage {
  return { ...message, senderVipTypeId: activeVipTypeId(message.senderVip, message.senderVipEnd) };
}

export function buildOptimisticRoomImage(
  roomId: string,
  clientMsgId: string,
  previewUrl: string
): RoomMessage {
  const user = useAuthStore.getState().user;
  return withSenderVip({
    id: clientMsgId,
    clientMsgId,
    roomId,
    senderId: user?.id ?? '',
    senderName: user?.fullName ?? user?.username,
    senderAvatar: user?.avatar,
    senderGender: user?.gender,
    senderVip: user?.vipUsed,
    senderVipEnd: user?.vipEndTime,
    type: 'image',
    content: '',
    imageUrl: previewUrl,
    createdAt: new Date().toISOString(),
    status: 'uploading',
  });
}

export function markRoomMessageByClientMsgId(
  messages: RoomMessage[],
  clientMsgId: string,
  patch: Partial<RoomMessage>
): RoomMessage[] {
  return messages.map((item) => (item.clientMsgId === clientMsgId ? { ...item, ...patch } : item));
}

export function markRoomMessageById(
  messages: RoomMessage[],
  id: string,
  patch: Partial<RoomMessage>
): RoomMessage[] {
  return messages.map((item) => (item.id === id ? { ...item, ...patch } : item));
}

export function reconcileRoomServerMessage(
  messages: RoomMessage[],
  saved: RoomMessage
): RoomMessage[] {
  const final: RoomMessage = { ...saved, status: 'sent' };
  const matches = (item: RoomMessage) =>
    item.id === saved.id || (saved.clientMsgId != null && item.clientMsgId === saved.clientMsgId);
  let replaced = false;
  const next: RoomMessage[] = [];
  for (const item of messages) {
    if (!matches(item)) {
      next.push(item);
      continue;
    }
    if (!replaced) {
      next.push(final);
      replaced = true;
    }
  }
  if (!replaced) next.push(final);
  return next;
}

function contentMentionsName(content: string, name: string | undefined): boolean {
  if (name == null || name.trim() === '') return false;
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  return new RegExp(`@${escaped}(?![\\p{L}\\p{N}_])`, 'iu').test(content);
}

export function messageMentionsUser(
  content: string,
  user: { username: string; fullName?: string } | null | undefined
): boolean {
  if (user == null) return false;
  return contentMentionsName(content, user.username) || contentMentionsName(content, user.fullName);
}
