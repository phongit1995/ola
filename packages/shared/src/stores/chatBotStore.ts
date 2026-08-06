import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { CHAT_BOT_TYPE } from '../constants/chatBot';
import { randomUuid } from '../lib/randomUuid';
import { sharedPersistStorage } from '../platform/persistStorage';
import type {
  ChatBotConversation,
  ChatBotMessage,
  ChatBotState,
  ChatBotType,
} from '../types/client/chatBot.type';
import { registerOnLogout } from './authStore';

export const CHAT_BOT_STORAGE_KEY = 'ola.chatBot';

const emptyConversation: ChatBotConversation = {
  messages: [],
  activeTurnId: null,
  error: null,
};

function emptyConversations(): Record<ChatBotType, ChatBotConversation> {
  return {
    [CHAT_BOT_TYPE.olala]: { ...emptyConversation },
    [CHAT_BOT_TYPE.olavi]: { ...emptyConversation },
  };
}

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

function withConversation(
  conversations: Record<ChatBotType, ChatBotConversation>,
  bot: ChatBotType,
  patch: Partial<ChatBotConversation>
): Record<ChatBotType, ChatBotConversation> {
  return { ...conversations, [bot]: { ...conversations[bot], ...patch } };
}

function persistableConversations(
  conversations: Record<ChatBotType, ChatBotConversation>
): Record<ChatBotType, ChatBotConversation> {
  return Object.fromEntries(
    Object.entries(conversations).map(([bot, conversation]) => [
      bot,
      {
        ...emptyConversation,
        messages: conversation.messages.map((message) =>
          message.status === 'streaming'
            ? { ...message, status: 'failed' as const }
            : message
        ),
      },
    ])
  ) as Record<ChatBotType, ChatBotConversation>;
}

export const useChatBotStore = create<ChatBotState>()(
  persist(
    (set, get) => ({
      conversations: emptyConversations(),
      ownerId: null,

      beginTurn: (bot, prompt) => {
        const answer = newMessage('assistant', '', 'streaming');
        set((state) => ({
          conversations: withConversation(state.conversations, bot, {
            messages: [
              ...state.conversations[bot].messages,
              newMessage('user', prompt, 'done'),
              answer,
            ],
            activeTurnId: answer.id,
            error: null,
          }),
        }));
        return answer.id;
      },

      appendDelta: (bot, turnId, delta) =>
        set((state) => ({
          conversations: withConversation(state.conversations, bot, {
            messages: replaceMessage(
              state.conversations[bot].messages,
              turnId,
              (message) => ({ ...message, content: message.content + delta })
            ),
          }),
        })),

      finishTurn: (bot, turnId) =>
        set((state) => {
          const conversation = state.conversations[bot];
          if (conversation.activeTurnId !== turnId) return state;
          return {
            conversations: withConversation(state.conversations, bot, {
              messages: replaceMessage(
                conversation.messages,
                turnId,
                (message) => ({
                  ...message,
                  status: message.content === '' ? 'failed' : 'done',
                })
              ),
              activeTurnId: null,
            }),
          };
        }),

      failTurn: (bot, turnId, code) =>
        set((state) => {
          const conversation = state.conversations[bot];
          if (conversation.activeTurnId !== turnId) return state;
          return {
            conversations: withConversation(state.conversations, bot, {
              messages: replaceMessage(
                conversation.messages,
                turnId,
                (message) => ({ ...message, status: 'failed' })
              ),
              activeTurnId: null,
              error: code,
            }),
          };
        }),

      dropLastTurn: (bot) => {
        const { messages } = get().conversations[bot];
        const lastUserIndex = lastIndexOfUser(messages);
        if (lastUserIndex < 0) return null;
        const prompt = messages[lastUserIndex]!.content;
        set((state) => ({
          conversations: withConversation(state.conversations, bot, {
            messages: messages.slice(0, lastUserIndex),
            activeTurnId: null,
            error: null,
          }),
        }));
        return prompt;
      },

      syncOwner: (userId) =>
        set((state) =>
          state.ownerId === userId
            ? state
            : { conversations: emptyConversations(), ownerId: userId }
        ),

      clear: (bot) =>
        set((state) => ({
          conversations: withConversation(state.conversations, bot, {
            ...emptyConversation,
          }),
        })),
    }),
    {
      name: CHAT_BOT_STORAGE_KEY,
      version: 2,
      storage: sharedPersistStorage<ChatBotState>(),
      partialize: (state) =>
        ({
          ownerId: state.ownerId,
          conversations: persistableConversations(state.conversations),
        }) as ChatBotState,
      migrate: (persisted, version) => {
        if (version >= 2) return persisted as ChatBotState;
        const legacy = persisted as Partial<{
          ownerId: string | null;
          messages: ChatBotMessage[];
        }>;
        return {
          ownerId: legacy.ownerId ?? null,
          conversations: {
            ...emptyConversations(),
            [CHAT_BOT_TYPE.olala]: {
              ...emptyConversation,
              messages: legacy.messages ?? [],
            },
          },
        } as ChatBotState;
      },
      merge: (persisted, current) => {
        const stored = persisted as Partial<ChatBotState> | undefined;
        return {
          ...current,
          ...stored,
          conversations: {
            ...emptyConversations(),
            ...(stored?.conversations ?? {}),
          },
        };
      },
    }
  )
);

registerOnLogout(() =>
  useChatBotStore.setState({
    conversations: emptyConversations(),
    ownerId: null,
  })
);
