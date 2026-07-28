import { create } from 'zustand';
import { RoomService, SocketService } from '../services';
import { randomUuid, releaseUploadPreviewUrl, uploadPreviewUrl } from '../lib';
import type { UploadFile } from '../lib/upload';
import {
  ROOM_SOCKET_EVENTS,
  type ReactionType,
  type RoomMember,
  type RoomMessage,
  type RoomReactionNotice,
} from '../types';
import {
  buildOptimisticRoomImage,
  markRoomMessageByClientMsgId,
  markRoomMessageById,
  mergeRoomMessageSnapshot,
  reconcileRoomServerMessage,
  withSenderVip,
  toRecord,
  withVipTypeId,
} from './roomHelpers';
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
  replyTarget: RoomMessage | null;
  reactionNotice: RoomReactionNotice | null;
  open: (room: ActiveRoom) => Promise<void>;
  close: () => void;
  reset: () => void;
  setActiveTab: (tab: RoomTab) => void;
  setRoomForeground: (foreground: boolean) => void;
  sendMessage: (content: string) => Promise<void>;
  sendImage: (file: UploadFile) => Promise<void>;
  resendRoomImage: (messageId: string) => Promise<void>;
  loadMoreMessages: () => Promise<void>;
  setReplyTarget: (message: RoomMessage) => void;
  clearReplyTarget: () => void;
  clearReactionNotice: (seq: number) => void;
  reactToRoomMessage: (messageId: string, type: ReactionType) => Promise<void>;
  deleteRoomMessage: (messageId: string) => Promise<void>;
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
  replyTarget: null as RoomMessage | null,
  reactionNotice: null as RoomReactionNotice | null,
};

export const useRoomChatStore = create<RoomChatState>((set, get) => {
  registerRoomRealtime(set, get);

  async function finalizeImageSend(
    roomId: string,
    clientMsgId: string,
    previewUrl: string,
    upload: () => Promise<RoomMessage>
  ) {
    try {
      const saved = withSenderVip(await upload());
      if (get().activeRoom?.id !== roomId) {
        releaseUploadPreviewUrl(previewUrl);
        return;
      }
      set((state) => ({ messages: reconcileRoomServerMessage(state.messages, saved) }));
      releaseUploadPreviewUrl(previewUrl);
    } catch {
      if (get().activeRoom?.id !== roomId) {
        releaseUploadPreviewUrl(previewUrl);
        return;
      }
      set((state) => ({
        messages: markRoomMessageByClientMsgId(state.messages, clientMsgId, { status: 'failed' }),
      }));
    }
  }

  async function joinRoom(roomId: string) {
    const socket = await SocketService.ready(JOIN_ACK_TIMEOUT_MS);
    if (get().activeRoom?.id !== roomId) return;

    const { ticket } = await RoomService.join(roomId);
    const ack = toRecord(
      await socket
        .timeout(JOIN_ACK_TIMEOUT_MS)
        .emitWithAck(ROOM_SOCKET_EVENTS.join, { roomId, ticket })
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
    const snapshot = [...msgs.items].reverse().map(withSenderVip);
    set((state) => ({
      status: 'joined',
      messages: mergeRoomMessageSnapshot(state.messages, snapshot),
      members: withVipTypeId(mem.items),
      memberCount: mem.total,
      hasMore: msgs.hasMore,
    }));
  }

  SocketService.onReconnect(() => {
    const room = get().activeRoom;
    if (!room) return;
    joinRoom(room.id).catch(() => {
      if (get().activeRoom?.id === room.id) set({ status: 'error' });
    });
  });

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

    reset: () => set({ ...initialState }),

    setActiveTab: (tab) =>
      set(tab === 'messages' ? { activeTab: tab, messagesUnread: false } : { activeTab: tab }),

    setRoomForeground: (foreground) =>
      set(foreground ? { roomForeground: true, hasUnread: false } : { roomForeground: false }),

    sendMessage: async (content) => {
      const room = get().activeRoom;
      if (!room) return;
      const trimmed = content.trim();
      if (trimmed === '') return;
      const reply = get().replyTarget;
      const message = withSenderVip(
        await RoomService.sendMessage(room.id, {
          content: trimmed,
          ...(reply != null ? { replyToId: reply.id } : {}),
        })
      );
      if (get().activeRoom?.id !== room.id) return;
      set((state) => ({
        replyTarget: state.replyTarget?.id === reply?.id ? null : state.replyTarget,
        ...(state.messages.some((item) => item.id === message.id)
          ? {}
          : { messages: [...state.messages, message] }),
      }));
    },

    sendImage: async (file) => {
      const room = get().activeRoom;
      if (!room) return;
      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(file);
      set((state) => ({
        messages: [...state.messages, buildOptimisticRoomImage(room.id, clientMsgId, previewUrl)],
      }));
      await finalizeImageSend(room.id, clientMsgId, previewUrl, () =>
        RoomService.sendImage(room.id, file, clientMsgId)
      );
    },

    resendRoomImage: async (messageId) => {
      const room = get().activeRoom;
      if (!room) return;
      const target = get().messages.find((item) => item.id === messageId);
      if (target == null || target.status !== 'failed' || target.imageUrl == null) return;
      const clientMsgId = target.clientMsgId ?? randomUuid();
      const previewUrl = target.imageUrl;
      set((state) => ({
        messages: markRoomMessageByClientMsgId(state.messages, clientMsgId, {
          clientMsgId,
          status: 'uploading',
        }),
      }));
      await finalizeImageSend(room.id, clientMsgId, previewUrl, async () => {
        const blob = await (await fetch(previewUrl)).blob();
        return RoomService.sendImage(room.id, blob, clientMsgId, 'image');
      });
    },

    setReplyTarget: (message) => set({ replyTarget: message }),

    clearReplyTarget: () => set({ replyTarget: null }),

    clearReactionNotice: (seq) =>
      set((state) => (state.reactionNotice?.seq === seq ? { reactionNotice: null } : {})),

    reactToRoomMessage: async (messageId, type) => {
      const room = get().activeRoom;
      if (!room) return;
      try {
        const updated = await RoomService.toggleMessageReaction(room.id, messageId, type);
        if (get().activeRoom?.id !== room.id) return;
        set((state) => ({
          messages: markRoomMessageById(state.messages, messageId, {
            reactions: updated.reactions,
          }),
        }));
      } catch {
        return;
      }
    },

    deleteRoomMessage: async (messageId) => {
      const room = get().activeRoom;
      if (!room) return;
      await RoomService.deleteMessage(room.id, messageId);
      if (get().activeRoom?.id !== room.id) return;
      set((state) => ({
        messages: state.messages.filter((item) => item.id !== messageId),
        replyTarget: state.replyTarget?.id === messageId ? null : state.replyTarget,
      }));
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
