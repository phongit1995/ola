import { create } from 'zustand';
import type { ChatState } from '../../types/client/chat.type';
import { registerOnLogout } from '../authStore';
import { createChatConversationActions } from './chatConversationActions';
import {
  createChatMessageActions,
  resetChatMessageActionState,
} from './chatMessageActions';
import { createChatRelationshipActions } from './chatRelationshipActions';
import { clearMarkReadTimers, clearTypingTimers, registerChatRealtime } from './chatRealtime';
import { initialChatState } from './chatState';

export type {
  ChatState,
  DraftRecipient,
  FriendActionResult,
  TypingUser,
} from '../../types/client/chat.type';

export const useChatStore = create<ChatState>((set, get) => {
  registerChatRealtime(set, get);

  return {
    ...initialChatState,
    ...createChatConversationActions(set, get),
    ...createChatMessageActions(set, get),
    ...createChatRelationshipActions(set, get),

    setReplyTarget: (message) => set({ replyTarget: message }),
    clearReplyTarget: () => set({ replyTarget: null }),
    clearReactionNotice: (seq) =>
      set((state) =>
        state.reactionNotice?.seq === seq ? { reactionNotice: null } : {}
      ),

    reset: () => {
      clearTypingTimers();
      clearMarkReadTimers();
      resetChatMessageActionState();
      set({ ...initialChatState });
    },
  };
});

registerOnLogout(() => useChatStore.getState().reset());
