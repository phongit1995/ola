import { create } from 'zustand';
import type { RoomChatState } from '../../types/client/roomChat.type';
import { capPinnedRoomMessages } from './roomHelpers';
import { initialRoomChatState } from './roomChatState';
import { createRoomLifecycleActions } from './roomLifecycleActions';
import { createRoomMessageActions } from './roomMessageActions';
import { registerRoomRealtime } from './roomRealtime';

export type {
  ActiveRoom,
  RoomAudioSendResult,
  RoomChatState,
  RoomChatStatus,
  RoomTab,
} from '../../types/client/roomChat.type';

export const useRoomChatStore = create<RoomChatState>((set, get) => {
  registerRoomRealtime(set, get);

  return {
    ...initialRoomChatState,
    ...createRoomLifecycleActions(set, get),
    ...createRoomMessageActions(set, get),

    reset: () => set({ ...initialRoomChatState }),
    setActiveTab: (tab) =>
      set(
        tab === 'messages'
          ? { activeTab: tab, messagesUnread: false }
          : { activeTab: tab }
      ),
    setRoomForeground: (foreground) =>
      set(
        foreground
          ? { roomForeground: true, hasUnread: false }
          : { roomForeground: false }
      ),
    setPinnedToBottom: (pinned) =>
      set((state) => {
        if (!pinned) {
          return state.pinnedToBottom ? { pinnedToBottom: false } : {};
        }
        return {
          pinnedToBottom: true,
          ...capPinnedRoomMessages(state.messages, true),
        };
      }),
    setReplyTarget: (message) => set({ replyTarget: message }),
    clearReplyTarget: () => set({ replyTarget: null }),
    clearReactionNotice: (seq) =>
      set((state) =>
        state.reactionNotice?.seq === seq ? { reactionNotice: null } : {}
      ),
  };
});
