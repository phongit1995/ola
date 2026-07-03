import type { StoreApi } from 'zustand';
import { useAuthStore } from '../authStore';
import type { Message, MessageType } from '../../types';
import type { ChatState } from './chatStore';

type ChatSet = StoreApi<ChatState>['setState'];

interface OptimisticMessageInput {
  clientMsgId: string;
  conversationId: string;
  type: MessageType;
  status: Message['status'];
  content?: string;
  metadata?: string;
}

export function buildOptimisticMessage(input: OptimisticMessageInput): Message {
  const user = useAuthStore.getState().user;
  const now = new Date().toISOString();
  return {
    id: input.clientMsgId,
    conversationId: input.conversationId,
    senderId: user?.id ?? '',
    senderName: user?.fullName ?? user?.username,
    senderAvatar: user?.avatar,
    type: input.type,
    content: input.content ?? '',
    metadata: input.metadata,
    status: input.status,
    createdAt: now,
    updatedAt: now,
    clientMsgId: input.clientMsgId,
  };
}

export function replaceMessage(
  messages: Message[],
  match: (item: Message) => boolean,
  patch: Partial<Message>
): Message[] {
  return messages.map((item) => (match(item) ? { ...item, ...patch } : item));
}

export function markByClientMsgId(
  messages: Message[],
  clientMsgId: string,
  patch: Partial<Message>
): Message[] {
  return replaceMessage(messages, (item) => item.clientMsgId === clientMsgId, patch);
}

export function markById(messages: Message[], id: string, patch: Partial<Message>): Message[] {
  return replaceMessage(messages, (item) => item.id === id, patch);
}

export async function runOptimisticSend(
  set: ChatSet,
  optimistic: Message,
  send: (clientMsgId: string) => Promise<Message>,
  onSuccess?: () => void
): Promise<void> {
  const clientMsgId = optimistic.clientMsgId ?? optimistic.id;
  set((state) => ({ messages: [...state.messages, optimistic] }));
  try {
    const saved = await send(clientMsgId);
    set((state) => ({
      messages: markByClientMsgId(state.messages, clientMsgId, { ...saved, status: 'sent' }),
    }));
    onSuccess?.();
  } catch {
    set((state) => ({
      messages: markByClientMsgId(state.messages, clientMsgId, { status: 'failed' }),
    }));
  }
}
