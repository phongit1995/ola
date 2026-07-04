import { activeVipTypeId } from '../lib';
import type { RoomMember, RoomMessage } from '../types';

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
