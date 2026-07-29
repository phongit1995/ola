import type { RoomBrief, RoomMessage, RoomReactor } from '../api/room.type';

export interface RoomJoinAck {
  ok: boolean;
  error?: string;
  data?: { roomId: string; memberCount: number };
}

export interface RoomSocketEnvelope<T = unknown> {
  type: string;
  data: T;
}

export interface RoomJoinPayload {
  roomId: string;
  ticket: string;
}

export interface RoomPresenceAck {
  roomId: string;
  memberCount: number;
}

export interface NewRoomMessageEvent {
  room: RoomBrief;
  message: RoomMessage;
}

export interface RoomMessageDeletedEvent {
  roomId: string;
  messageId: string;
}

export interface RoomMessageReactionUpdatedEvent {
  roomId: string;
  messageId: string;
  reactions: Record<string, RoomReactor[]>;
  actorUserId: string;
  actorUsername: string;
  type: string;
  action: string;
}

export interface RoomMemberPresenceEvent {
  roomId: string;
  userId: string;
  memberCount: number;
}
