export interface ConversationUserBrief {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface AdminConversationItem {
  id: string
  type: string
  name?: string
  avatar?: string
  otherUser?: ConversationUserBrief
  lastMessageAt?: string
  lastMessagePreview?: string
  hidden: boolean
  hiddenAt?: string
  missing?: boolean
}

export interface AdminConversationList {
  items: AdminConversationItem[]
  total: number
  hasMore: boolean
  snapshot?: string
}

export interface AdminConversationMember {
  user: ConversationUserBrief
  role?: string
  isActive: boolean
  joinedAt?: string
  leftAt?: string
}

export interface AdminConversationDetail {
  id: string
  type: string
  name?: string
  avatar?: string
  createdAt?: string
  members: AdminConversationMember[]
}

export interface AdminConversationMessage {
  id: string
  sender: ConversationUserBrief
  type: string
  content: string
  metadata?: string
  createdAt: string
  editedAt?: string
  deletedAt?: string
  replyTo?: {
    messageId: string
    senderId: string
    senderName?: string
    excerpt: string
    type?: string
    imageUrl?: string
  }
  reactions?: Record<string, string[]>
}

export interface AdminConversationMessages {
  messages: AdminConversationMessage[]
  hasMore: boolean
  nextBefore?: string
  hasNewer: boolean
}
