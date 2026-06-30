import { create } from 'zustand';
import { RoomService, SocketService } from '@services';
import { ROOM_SOCKET_EVENTS, type RoomMember, type RoomMessage } from '@app-types';
import { toRecord, withSenderVip, withVipTypeId } from './roomHelpers';
import { registerRoomRealtime } from './roomRealtime';

export type RoomChatStatus = 'connecting' | 'joined' | 'error';
export type RoomTab = 'members' | 'messages';

export interface ActiveRoom {
  id: string;
  name: string;
}

const MESSAGE_PAGE_SIZE = 50;
const JOIN_ACK_TIMEOUT_MS = 10_000;

export interface RoomChatState {
  activeRoom: ActiveRoom | null;
  status: RoomChatStatus;
  activeTab: RoomTab;
  messages: RoomMessage[];
  members: RoomMember[];
  memberCount: number;
  hasUnread: boolean;
  messagesUnread: boolean;
  roomForeground: boolean;
  hasMore: boolean;
  loadingMore: boolean;
  open: (room: ActiveRoom) => Promise<void>;
  close: () => void;
  setActiveTab: (tab: RoomTab) => void;
  setRoomForeground: (foreground: boolean) => void;
  sendMessage: (content: string) => Promise<void>;
  loadMoreMessages: () => Promise<void>;
}

const initialState = {
  activeRoom: null as ActiveRoom | null,
  status: 'connecting' as RoomChatStatus,
  activeTab: 'members' as RoomTab,
  messages: [] as RoomMessage[],
  members: [] as RoomMember[],
  memberCount: 0,
  hasUnread: false,
  messagesUnread: false,
  roomForeground: false,
  hasMore: false,
  loadingMore: false,
};

export const useRoomChatStore = create<RoomChatState>((set, get) => {
  registerRoomRealtime(set, get);

  async function joinRoom(roomId: string) {
    const socket = await SocketService.ready(JOIN_ACK_TIMEOUT_MS);
    if (get().activeRoom?.id !== roomId) return;

    const { ticket } = await RoomService.join(roomId);
    const ack = toRecord(
      await socket.timeout(JOIN_ACK_TIMEOUT_MS).emitWithAck(ROOM_SOCKET_EVENTS.join, { roomId, ticket })
    );
    if (get().activeRoom?.id !== roomId) return;
    if (!ack?.ok) {
      set({ status: 'error' });
      return;
    }

    const [msgs, mem] = await Promise.all([
      RoomService.messages(roomId, { limit: MESSAGE_PAGE_SIZE }),
      RoomService.members(roomId),
    ]);
    if (get().activeRoom?.id !== roomId) return;
    set({
      status: 'joined',
      messages: [...msgs.items].reverse().map(withSenderVip),
      members: withVipTypeId(mem.items),
      memberCount: mem.total,
      hasMore: msgs.hasMore,
    });
  }

  return {
    ...initialState,

    open: async (room) => {
      SocketService.connect();
      set({ ...initialState, activeRoom: room });
      try {
        await joinRoom(room.id);
      } catch {
        if (get().activeRoom?.id === room.id) set({ status: 'error' });
      }
    },

    close: () => {
      const room = get().activeRoom;
      if (room) SocketService.connect().emit(ROOM_SOCKET_EVENTS.leave, { roomId: room.id });
      set({ ...initialState });
    },

    setActiveTab: (tab) =>
      set(tab === 'messages' ? { activeTab: tab, messagesUnread: false } : { activeTab: tab }),

    setRoomForeground: (foreground) =>
      set(foreground ? { roomForeground: true, hasUnread: false } : { roomForeground: false }),

    sendMessage: async (content) => {
      const room = get().activeRoom;
      if (!room) return;
      const trimmed = content.trim();
      if (trimmed === '') return;
      const message = withSenderVip(await RoomService.sendMessage(room.id, { content: trimmed }));
      if (get().activeRoom?.id !== room.id) return;
      set((state) =>
        state.messages.some((item) => item.id === message.id)
          ? state
          : { messages: [...state.messages, message] }
      );
    },

    loadMoreMessages: async () => {
      const { activeRoom, messages, hasMore, loadingMore } = get();
      if (!activeRoom || !hasMore || loadingMore) return;
      const oldest = messages[0];
      if (oldest == null) return;
      set({ loadingMore: true });
      try {
        const result = await RoomService.messages(activeRoom.id, {
          limit: MESSAGE_PAGE_SIZE,
          before: oldest.id,
        });
        if (get().activeRoom?.id !== activeRoom.id) return;
        const older = [...result.items].reverse().map(withSenderVip);
        const existingIds = new Set(get().messages.map((item) => item.id));
        const deduped = older.filter((item) => !existingIds.has(item.id));
        set({
          messages: [...deduped, ...get().messages],
          hasMore: result.hasMore,
          loadingMore: false,
        });
      } catch {
        if (get().activeRoom?.id === activeRoom.id) set({ loadingMore: false });
      }
    },
  };
});
