export interface Room {
  id: string;
  name: string;
  description?: string;
  imageUrl?: string;
  maxMembers: number;
  memberCount: number;
  enabled: boolean;
  createdBy: string;
  createdAt: string;
}

export interface RoomBrief {
  id: string;
  name: string;
  imageUrl?: string;
}

export interface RoomMember {
  userId: string;
  username: string;
  fullName?: string;
  avatar?: string;
  gender?: 'male' | 'female';
  bio?: string;
  bioImage?: string | null;
  vipUsed?: string | null;
  vipEndTime?: string | null;
  vipTypeId?: number | null;
}

export interface RoomReplySnapshot {
  messageId: string;
  senderId: string;
  senderName?: string;
  excerpt: string;
}

export interface RoomReactor {
  userId: string;
  username: string;
}

export interface RoomMessage {
  id: string;
  roomId: string;
  senderId: string;
  senderName?: string;
  senderAvatar?: string;
  senderGender?: 'male' | 'female';
  senderVip?: string | null;
  senderVipEnd?: string | null;
  senderVipTypeId?: number | null;
  content: string;
  createdAt: string;
  replyTo?: RoomReplySnapshot;
  reactions?: Record<string, RoomReactor[]>;
}

export interface RoomListResult {
  items: Room[];
  total: number;
  limit: number;
  offset: number;
}

export interface RoomMembersResult {
  items: RoomMember[];
  total: number;
}

export interface RoomMessagesResult {
  items: RoomMessage[];
  hasMore: boolean;
  nextBefore?: string;
}

export interface BrowseRoomsParams {
  q?: string;
  limit?: number;
  offset?: number;
}

export interface RoomMessagesParams {
  limit?: number;
  before?: string;
}

export interface CreateRoomRequest {
  name: string;
  description?: string;
  imageUrl?: string;
  maxMembers?: number;
}

export interface UpdateRoomRequest {
  name?: string;
  description?: string;
  imageUrl?: string;
  maxMembers?: number;
  enabled?: boolean;
}

export interface SendRoomMessageRequest {
  content: string;
  replyToId?: string;
}

export const ROOM_SOCKET_EVENTS = {
  message: 'message',
  join: 'ROOM:JOIN',
  leave: 'ROOM:LEAVE',
  newMessage: 'NEW_ROOM_MESSAGE',
  messageDeleted: 'ROOM_MESSAGE_DELETED',
  reactionUpdated: 'ROOM_MESSAGE_REACTION_UPDATED',
  memberJoined: 'ROOM_MEMBER_JOINED',
  memberLeft: 'ROOM_MEMBER_LEFT',
} as const;

export interface RoomJoinTicket {
  ticket: string;
  expiresIn: number;
}

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
}

export interface RoomMemberPresenceEvent {
  roomId: string;
  userId: string;
  memberCount: number;
}
