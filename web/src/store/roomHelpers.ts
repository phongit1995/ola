import { activeVipTypeId } from '@lib';
import type { RoomMember, RoomMessage } from '@app-types';

export function toRecord(value: unknown): Record<string, unknown> | null {
  return typeof value === 'object' && value !== null ? (value as Record<string, unknown>) : null;
}

export function withVipTypeId(members: RoomMember[]): RoomMember[] {
  return members.map((member) => ({
    ...member,
    vipTypeId: activeVipTypeId(member.vipUsed, member.vipEndTime),
  }));
}

export function withSenderVip(message: RoomMessage): RoomMessage {
  return { ...message, senderVipTypeId: activeVipTypeId(message.senderVip, message.senderVipEnd) };
}
