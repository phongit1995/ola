import {
  ROOM_JOIN_ACK_TIMEOUT_MS,
  ROOM_MESSAGE_CACHE_LIMIT,
  ROOM_MESSAGE_PAGE_SIZE,
} from '../../constants/room';
import { ROOM_SOCKET_EVENTS } from '../../constants/socket';
import { RoomService } from '../../services/room.service';
import { SocketService } from '../../services/socket.service';
import type { RoomLifecycleActions } from '../../types/client/roomChat.type';
import {
  capPinnedRoomMessages,
  mergeRoomMessageSnapshot,
  toRecord,
  withSenderVip,
  withVipTypeId,
} from './roomHelpers';
import {
  initialRoomChatState,
  type RoomChatGet,
  type RoomChatSet,
} from './roomChatState';

export function createRoomLifecycleActions(
  set: RoomChatSet,
  get: RoomChatGet
): RoomLifecycleActions {
  async function joinRoom(roomId: string): Promise<void> {
    const socket = await SocketService.ready(ROOM_JOIN_ACK_TIMEOUT_MS);
    if (get().activeRoom?.id !== roomId) return;

    const { ticket } = await RoomService.join(roomId);
    const ack = toRecord(
      await socket
        .timeout(ROOM_JOIN_ACK_TIMEOUT_MS)
        .emitWithAck(ROOM_SOCKET_EVENTS.join, { roomId, ticket })
    );
    if (get().activeRoom?.id !== roomId) return;
    if (!ack?.ok) {
      set({ status: 'error' });
      return;
    }

    const [messagesResult, membersResult] = await Promise.all([
      RoomService.messages(roomId, { limit: ROOM_MESSAGE_PAGE_SIZE }),
      RoomService.members(roomId),
    ]);
    if (get().activeRoom?.id !== roomId) return;
    const snapshot = [...messagesResult.items].reverse().map(withSenderVip);
    set((state) => {
      const patch = capPinnedRoomMessages(
        mergeRoomMessageSnapshot(state.messages, snapshot),
        state.pinnedToBottom
      );
      return {
        status: 'joined',
        ...patch,
        members: withVipTypeId(membersResult.items),
        memberCount: membersResult.total,
        hasMore: messagesResult.hasMore || patch.hasMore === true,
      };
    });
  }

  SocketService.onReconnect(() => {
    const room = get().activeRoom;
    if (!room) return;
    joinRoom(room.id).catch(() => {
      if (get().activeRoom?.id === room.id) set({ status: 'error' });
    });
  });

  return {
    open: async (room) => {
      SocketService.connect();
      set({ ...initialRoomChatState, activeRoom: room });
      try {
        await joinRoom(room.id);
      } catch {
        if (get().activeRoom?.id === room.id) set({ status: 'error' });
      }
    },

    close: () => {
      const room = get().activeRoom;
      if (room) {
        SocketService.connect().emit(ROOM_SOCKET_EVENTS.leave, {
          roomId: room.id,
        });
      }
      set({ ...initialRoomChatState });
    },

    loadMoreMessages: async () => {
      const { activeRoom, messages, hasMore, loadingMore, pinnedToBottom } =
        get();
      if (!activeRoom || !hasMore || loadingMore) return;
      if (pinnedToBottom && messages.length >= ROOM_MESSAGE_CACHE_LIMIT) return;
      const oldest = messages[0];
      if (oldest == null) return;
      set({ loadingMore: true });
      try {
        const result = await RoomService.messages(activeRoom.id, {
          limit: ROOM_MESSAGE_PAGE_SIZE,
          before: oldest.id,
        });
        if (get().activeRoom?.id !== activeRoom.id) return;
        const older = [...result.items].reverse().map(withSenderVip);
        set((state) => {
          if (state.messages[0]?.id !== oldest.id) {
            return { loadingMore: false };
          }
          const existingIds = new Set(state.messages.map((item) => item.id));
          const deduped = older.filter((item) => !existingIds.has(item.id));
          const patch = capPinnedRoomMessages(
            [...deduped, ...state.messages],
            state.pinnedToBottom
          );
          return {
            ...patch,
            hasMore: result.hasMore || patch.hasMore === true,
            loadingMore: false,
          };
        });
      } catch {
        if (get().activeRoom?.id === activeRoom.id) {
          set({ loadingMore: false });
        }
      }
    },
  };
}
