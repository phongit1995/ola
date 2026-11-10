export interface Room {
  id: string
  name: string
  description?: string
  imageUrl?: string
  maxMembers: number
  index: number
  memberCount: number
  enabled: boolean
  vipRequired: boolean
  vipMinMembers: number
  createdBy: string
  createdAt: string
}

export interface CreateRoomRequest {
  name: string
  description?: string
  imageUrl?: string
  maxMembers?: number
  index?: number
  vipRequired?: boolean
  vipMinMembers?: number
}

export interface UpdateRoomRequest {
  name?: string
  description?: string
  imageUrl?: string
  maxMembers?: number
  index?: number
  enabled?: boolean
  vipRequired?: boolean
  vipMinMembers?: number
}

export interface RoomReplySnapshot {
  messageId: string
  senderId: string
  senderName?: string
  excerpt: string
  type?: string
  imageUrl?: string
}

export interface RoomReactor {
  userId: string
  username: string
}

export interface RoomMessage {
  id: string
  roomId: string
  senderId: string
  senderName?: string
  senderAvatar?: string
  senderGender?: string
  senderVip?: string
  senderVipEnd?: string
  type?: string
  content: string
  imageUrl?: string
  createdAt: string
  replyTo?: RoomReplySnapshot
  reactions?: Record<string, RoomReactor[]>
}

export interface RoomMessagesList {
  items: RoomMessage[]
  hasMore: boolean
  nextBefore?: string
}

export interface RoomImagePurgePreview {
  olderThanDays: number
  before: string
  files: number
  bytes: number
  kept: number
}

export interface RoomImagePurgeResult {
  before: string
  files: number
  bytes: number
  failed: number
  kept: number
}
