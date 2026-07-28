import type { StoreApi } from 'zustand';
import { useAuthStore } from '../authStore';
import { parseMessageMetadata } from '../../lib';
import type { ChatReplySnapshot, Message, MessageType } from '../../types';
import type { ChatState } from './chatStore';
import { applyOutgoingToConversations } from './chatHelpers';

type ChatSet = StoreApi<ChatState>['setState'];

const REPLY_EXCERPT_MAX_RUNES = 120;

interface OptimisticMessageInput {
  clientMsgId: string;
  conversationId: string;
  type: MessageType;
  status: Message['status'];
  content?: string;
  metadata?: string;
  replyTo?: ChatReplySnapshot;
}

export function replySnapshotOf(message: Message): ChatReplySnapshot {
  return {
    messageId: message.id,
    senderId: message.senderId,
    senderName: message.senderName,
    excerpt: Array.from(message.content).slice(0, REPLY_EXCERPT_MAX_RUNES).join(''),
    type: message.type,
    imageUrl: message.type === 'image' ? parseMessageMetadata(message.metadata).url : undefined,
  };
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
    replyToId: input.replyTo?.messageId,
    replyTo: input.replyTo,
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
  onSuccess?: () => void,
  onFailure?: (error: unknown) => void
): Promise<boolean> {
  const clientMsgId = optimistic.clientMsgId ?? optimistic.id;
  set((state) => ({
    messages: [...state.messages, optimistic],
    conversations: applyOutgoingToConversations(state.conversations, optimistic),
  }));
  try {
    const saved = await send(clientMsgId);
    set((state) => ({
      messages: markByClientMsgId(state.messages, clientMsgId, {
        ...saved,
        status: 'sent',
      }),
    }));
    onSuccess?.();
    return true;
  } catch (error) {
    set((state) => ({
      messages: markByClientMsgId(state.messages, clientMsgId, {
        status: 'failed',
      }),
    }));
    onFailure?.(error);
    return false;
  }
}
