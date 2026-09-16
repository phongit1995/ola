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
  deviceType?: string;
}

export interface RoomFilters {
  showAll: boolean;
  media: boolean;
  female: boolean;
  male: boolean;
  flexible: boolean;
}

export interface RoomReplySnapshot {
  messageId: string;
  senderId: string;
  senderName?: string;
  excerpt: string;
  type?: 'text' | 'image' | 'audio';
  imageUrl?: string;
}

export interface RoomReactor {
  userId: string;
  username: string;
}

export interface RoomReactionNotice {
  seq: number;
  username: string;
  type: string;
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
  type?: 'text' | 'image' | 'audio';
  imageUrl?: string;
  audioUrl?: string;
  audioDuration?: number;
  audioWaveform?: number[];
  audioMimeType?: string;
  audioSize?: number;
  createdAt: string;
  replyTo?: RoomReplySnapshot;
  reactions?: Record<string, RoomReactor[]>;
  clientMsgId?: string;
  status?: RoomMessageStatus;
}

export type RoomMessageStatus = 'uploading' | 'sent' | 'failed';

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

export interface RoomBlockedUser {
  userId: string;
  username: string;
  fullName?: string;
  avatar?: string;
}

export interface RoomBlockedUsersResult {
  userIds: string[];
  users: RoomBlockedUser[];
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

export interface SendRoomAudioOptions {
  clientMsgId?: string;
  replyToId?: string;
  waveform?: number[];
}

export interface RoomJoinTicket {
  ticket: string;
  expiresIn: number;
}
