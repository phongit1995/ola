import { useAuthStore } from '@/store/authStore';
import type { Conversation, Message } from '@app-types';

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

export function moveToTop(list: Conversation[], id: string): Conversation[] {
  const index = list.findIndex((item) => item.id === id);
  if (index <= 0) return list;
  const next = [...list];
  const [item] = next.splice(index, 1);
  if (item == null) return list;
  return [item, ...next];
}

export function upsertConversation(list: Conversation[], conversation: Conversation): Conversation[] {
  const index = list.findIndex((item) => item.id === conversation.id);
  if (index < 0) return [conversation, ...list];
  const next = [...list];
  next[index] = { ...next[index], ...conversation } as Conversation;
  return next;
}
