import { useAuthStore } from '../authStore';
import type { Conversation, Message } from '../../types/api/chat.type';

export function currentUserId(): string {
  return useAuthStore.getState().user?.id ?? '';
}

export function previewOf(message: Message): string {
  if (message.content) return message.content;
  if (message.type === 'image') return '📷';
  if (message.type === 'file') return '📎';
  if (message.type === 'video') return '🎬';
  if (message.type === 'audio') return '🎙️';
  return '';
}

export function totalUnreadOf(conversations: Conversation[]): number {
  return conversations.reduce(
    (sum, item) => sum + (item.isMuted ? 0 : (item.unreadCount ?? 0)),
    0
  );
}

export function moveToTop(list: Conversation[], id: string): Conversation[] {
  const index = list.findIndex((item) => item.id === id);
  if (index <= 0) return list;
  const next = [...list];
  const [item] = next.splice(index, 1);
  if (item == null) return list;
  return [item, ...next];
}

export function applyOutgoingToConversations(list: Conversation[], message: Message): Conversation[] {
  if (!list.some((item) => item.id === message.conversationId)) return list;
  const patched = list.map((item) =>
    item.id === message.conversationId
      ? {
          ...item,
          lastMessageText: previewOf(message),
          lastMessageAt: message.createdAt,
          lastMessageSenderId: message.senderId,
          lastMessageSenderName: message.senderName,
          isLastMessageFromMe: true,
          seen: false,
        }
      : item
  );
  return moveToTop(patched, message.conversationId);
}

export function upsertConversation(list: Conversation[], conversation: Conversation): Conversation[] {
  const index = list.findIndex((item) => item.id === conversation.id);
  if (index < 0) return [conversation, ...list];
  const next = [...list];
  next[index] = { ...next[index], ...conversation } as Conversation;
  return next;
}
