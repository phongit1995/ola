import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { randomUuid } from '../lib/randomUuid';
import { sharedPersistStorage } from '../platform/persistStorage';
import type {
  ChatBotMessage,
  ChatBotState,
} from '../types/client/chatBot.type';
import { registerOnLogout } from './authStore';

export const CHAT_BOT_STORAGE_KEY = 'ola.chatBot';

const emptyConversation = {
  messages: [] as ChatBotMessage[],
  activeTurnId: null,
  error: null,
};

function newMessage(
  role: ChatBotMessage['role'],
  content: string,
  status: ChatBotMessage['status']
): ChatBotMessage {
  return { id: randomUuid(), role, content, createdAt: Date.now(), status };
}

function lastIndexOfUser(messages: ChatBotMessage[]): number {
  for (let index = messages.length - 1; index >= 0; index -= 1) {
    if (messages[index]!.role === 'user') return index;
  }
  return -1;
}

function replaceMessage(
  messages: ChatBotMessage[],
  id: string,
  update: (message: ChatBotMessage) => ChatBotMessage
): ChatBotMessage[] {
  return messages.map((message) =>
    message.id === id ? update(message) : message
  );
}

export const useChatBotStore = create<ChatBotState>()(
  persist(
    (set, get) => ({
      ...emptyConversation,
      ownerId: null,

      beginTurn: (prompt) => {
        const answer = newMessage('assistant', '', 'streaming');
        set((state) => ({
          messages: [
            ...state.messages,
            newMessage('user', prompt, 'done'),
            answer,
          ],
          activeTurnId: answer.id,
          error: null,
        }));
        return answer.id;
      },

      appendDelta: (turnId, delta) =>
        set((state) => ({
          messages: replaceMessage(state.messages, turnId, (message) => ({
            ...message,
            content: message.content + delta,
          })),
        })),

      finishTurn: (turnId) =>
        set((state) => {
          if (state.activeTurnId !== turnId) return state;
          return {
            messages: replaceMessage(state.messages, turnId, (message) => ({
              ...message,
              status: message.content === '' ? 'failed' : 'done',
            })),
            activeTurnId: null,
          };
        }),

      failTurn: (turnId, code) =>
        set((state) => {
          if (state.activeTurnId !== turnId) return state;
          return {
            messages: replaceMessage(state.messages, turnId, (message) => ({
              ...message,
              status: 'failed',
            })),
            activeTurnId: null,
            error: code,
          };
        }),

      dropLastTurn: () => {
        const { messages } = get();
        const lastUserIndex = lastIndexOfUser(messages);
        if (lastUserIndex < 0) return null;
        const prompt = messages[lastUserIndex]!.content;
        set({
          messages: messages.slice(0, lastUserIndex),
          activeTurnId: null,
          error: null,
        });
        return prompt;
      },

      syncOwner: (userId) =>
        set((state) =>
          state.ownerId === userId
            ? state
            : { ...emptyConversation, ownerId: userId }
        ),

      clear: () => set({ ...emptyConversation }),
    }),
    {
      name: CHAT_BOT_STORAGE_KEY,
      version: 1,
      storage: sharedPersistStorage<ChatBotState>(),
      partialize: (state) =>
        ({
          ownerId: state.ownerId,
          messages: state.messages.map((message) =>
            message.status === 'streaming'
              ? { ...message, status: 'failed' }
              : message
          ),
        }) as ChatBotState,
    }
  )
);

registerOnLogout(() =>
  useChatBotStore.setState({ ...emptyConversation, ownerId: null })
);
