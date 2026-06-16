import { create } from 'zustand';
import type { Socket } from 'socket.io-client';
import { RoomService, SocketService } from '@services';
import {
  ROOM_SOCKET_EVENTS,
  type RoomMember,
  type RoomMessage,
  type RoomSocketEnvelope,
} from '@app-types';

export type RoomChatStatus = 'connecting' | 'joined' | 'error';
export type RoomTab = 'members' | 'messages';

export interface ActiveRoom {
  id: string;
  name: string;
}

const MESSAGE_PAGE_SIZE = 50;

interface RoomChatState {
  activeRoom: ActiveRoom | null;
  status: RoomChatStatus;
  activeTab: RoomTab;
  messages: RoomMessage[];
  members: RoomMember[];
  memberCount: number;
  open: (room: ActiveRoom) => Promise<void>;
  close: () => void;
  setActiveTab: (tab: RoomTab) => void;
  sendMessage: (content: string) => Promise<void>;
}

function toRecord(value: unknown): Record<string, unknown> | null {
  return typeof value === 'object' && value !== null ? (value as Record<string, unknown>) : null;
}

let envelopeHandler: ((envelope: RoomSocketEnvelope) => void) | null = null;
let connectHandler: (() => void) | null = null;

function detach(socket: Socket) {
  if (envelopeHandler) {
    socket.off(ROOM_SOCKET_EVENTS.message, envelopeHandler);
    envelopeHandler = null;
  }
  if (connectHandler) {
    socket.off('connect', connectHandler);
    connectHandler = null;
  }
}

const initialState = {
  activeRoom: null as ActiveRoom | null,
  status: 'connecting' as RoomChatStatus,
  activeTab: 'members' as RoomTab,
  messages: [] as RoomMessage[],
  members: [] as RoomMember[],
  memberCount: 0,
};

export const useRoomChatStore = create<RoomChatState>((set, get) => ({
  ...initialState,

  open: async (room) => {
    const roomId = room.id;
    const socket = SocketService.connect();
    detach(socket);
    set({ ...initialState, activeRoom: room });

    async function refreshMembers() {
      try {
        const result = await RoomService.members(roomId);
        if (get().activeRoom?.id !== roomId) return;
        set({ members: result.items, memberCount: result.total });
      } catch {
        return;
      }
    }

    envelopeHandler = (envelope) => {
      if (get().activeRoom?.id !== roomId || envelope?.type == null) return;
      switch (envelope.type) {
        case ROOM_SOCKET_EVENTS.newMessage: {
          const message = toRecord(toRecord(envelope.data)?.message);
          if (message?.roomId !== roomId || typeof message.id !== 'string') return;
          const newMessage = message as unknown as RoomMessage;
          set((state) =>
            state.messages.some((item) => item.id === newMessage.id)
              ? state
              : { messages: [...state.messages, newMessage] }
          );
          return;
        }
        case ROOM_SOCKET_EVENTS.messageDeleted: {
          const payload = toRecord(envelope.data);
          if (payload?.roomId !== roomId || typeof payload.messageId !== 'string') return;
          const messageId = payload.messageId;
          set((state) => ({
            messages: state.messages.filter((item) => item.id !== messageId),
          }));
          return;
        }
        case ROOM_SOCKET_EVENTS.memberJoined:
        case ROOM_SOCKET_EVENTS.memberLeft: {
          const payload = toRecord(envelope.data);
          if (payload?.roomId !== roomId || typeof payload.memberCount !== 'number') return;
          set({ memberCount: payload.memberCount });
          refreshMembers();
          return;
        }
        default:
          return;
      }
    };
    socket.on(ROOM_SOCKET_EVENTS.message, envelopeHandler);

    async function joinAndLoad() {
      try {
        const { ticket } = await RoomService.join(roomId);
        const ack = toRecord(
          await socket.emitWithAck(ROOM_SOCKET_EVENTS.join, { roomId, ticket })
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
          messages: [...msgs.items].reverse(),
          members: mem.items,
          memberCount: mem.total,
        });
      } catch {
        if (get().activeRoom?.id === roomId) set({ status: 'error' });
      }
    }

    if (socket.connected) {
      joinAndLoad();
    } else {
      connectHandler = joinAndLoad;
      socket.once('connect', joinAndLoad);
    }
  },

  close: () => {
    const room = get().activeRoom;
    const socket = SocketService.connect();
    detach(socket);
    if (room) socket.emit(ROOM_SOCKET_EVENTS.leave, { roomId: room.id });
    set({ ...initialState });
  },

  setActiveTab: (tab) => set({ activeTab: tab }),

  sendMessage: async (content) => {
    const room = get().activeRoom;
    if (!room) return;
    const trimmed = content.trim();
    if (trimmed === '') return;
    const message = await RoomService.sendMessage(room.id, { content: trimmed });
    if (get().activeRoom?.id !== room.id) return;
    set((state) =>
      state.messages.some((item) => item.id === message.id)
        ? state
        : { messages: [...state.messages, message] }
    );
  },
}));
