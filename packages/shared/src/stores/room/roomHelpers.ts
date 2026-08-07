import { activeVipTypeId } from '../../lib/vip';
import type { RoomMember, RoomMessage, RoomReplySnapshot } from '../../types/api/room.type';
import { useAuthStore } from '../auth/authStore';

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

export function roomReplySnapshotOf(message: RoomMessage): RoomReplySnapshot {
  return {
    messageId: message.id,
    senderId: message.senderId,
    senderName: message.senderName,
    excerpt: message.content,
    type: message.type,
    imageUrl: message.imageUrl,
  };
}

export function buildOptimisticRoomAudio(
  roomId: string,
  clientMsgId: string,
  previewUrl: string,
  duration: number,
  waveform: number[],
  mimeType: string,
  replyTo?: RoomReplySnapshot
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
    type: 'audio',
    content: '',
    audioUrl: previewUrl,
    audioDuration: duration,
    audioWaveform: waveform,
    audioMimeType: mimeType,
    createdAt: new Date().toISOString(),
    replyTo,
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

function sortRoomMessagesByTime(messages: RoomMessage[]): RoomMessage[] {
  return messages
    .map((message, index) => ({ message, index, createdAt: Date.parse(message.createdAt) }))
    .sort((left, right) => left.createdAt - right.createdAt || left.index - right.index)
    .map(({ message }) => message);
}

export function mergeRoomMessageSnapshot(
  messages: RoomMessage[],
  snapshot: RoomMessage[]
): RoomMessage[] {
  const isPending = (message: RoomMessage) =>
    message.status === 'uploading' || message.status === 'failed';
  const pending = messages.filter(isPending);
  const sent = snapshot.map((message) => ({ ...message, status: 'sent' as const }));

  const coveredIds = new Set(snapshot.map((message) => message.id));
  const coveredClientMsgIds = new Set(
    snapshot.map((message) => message.clientMsgId).filter((id) => id != null)
  );
  const isCovered = (message: RoomMessage) =>
    coveredIds.has(message.id) ||
    (message.clientMsgId != null && coveredClientMsgIds.has(message.clientMsgId));

  const overlapsHistory = messages.some((message) => !isPending(message) && isCovered(message));
  if (!overlapsHistory) return sortRoomMessagesByTime([...pending, ...sent]);

  const snapshotTimes = snapshot
    .map((message) => Date.parse(message.createdAt))
    .filter((time) => Number.isFinite(time));
  const oldestCovered = Math.min(...snapshotTimes);
  const newestCovered = Math.max(...snapshotTimes);

  const survivesSnapshot = (message: RoomMessage): boolean => {
    if (isCovered(message)) return false;
    if (isPending(message)) return true;
    const createdAt = Date.parse(message.createdAt);
    if (!Number.isFinite(createdAt)) return true;
    return createdAt < oldestCovered || createdAt > newestCovered;
  };

  return sortRoomMessagesByTime([...messages.filter(survivesSnapshot), ...sent]);
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
