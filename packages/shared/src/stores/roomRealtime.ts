import type { StoreApi } from 'zustand';
import { RoomService, SocketService } from '../services';
import { useAuthStore } from './authStore';
import { ROOM_SOCKET_EVENTS, type RoomMessage } from '../types';
import { playRoomTagSound } from '../platform/sound';
import { messageMentionsUser, toRecord, withSenderVip, withVipTypeId } from './roomHelpers';
import type { RoomChatState } from './roomChatStore';

type RoomSet = StoreApi<RoomChatState>['setState'];
type RoomGet = StoreApi<RoomChatState>['getState'];

let registered = false;

async function reloadMembers(get: RoomGet, set: RoomSet, roomId: string) {
  try {
    const result = await RoomService.members(roomId);
    if (get().activeRoom?.id !== roomId) return;
    set({ members: withVipTypeId(result.items), memberCount: result.total });
  } catch {
    return;
  }
}

function handleNewMessage(get: RoomGet, set: RoomSet, data: unknown) {
  const message = toRecord(toRecord(data)?.message);
  const roomId = get().activeRoom?.id;
  if (roomId == null || message?.roomId !== roomId || typeof message.id !== 'string') return;
  const incoming = withSenderVip(message as unknown as RoomMessage);
  const me = useAuthStore.getState().user;
  const isNew = !get().messages.some((item) => item.id === incoming.id);
  const fromMe = incoming.senderId === me?.id;
  set((state) => {
    if (state.messages.some((item) => item.id === incoming.id)) return state;
    const messages = [...state.messages, incoming];
    if (fromMe) return { messages };
    return {
      messages,
      ...(state.roomForeground ? {} : { hasUnread: true }),
      ...(state.activeTab === 'messages' ? {} : { messagesUnread: true }),
    };
  });
  if (isNew && !fromMe && messageMentionsUser(incoming.content, me)) {
    playRoomTagSound();
  }
}

function handleMessageDeleted(get: RoomGet, set: RoomSet, data: unknown) {
  const payload = toRecord(data);
  const roomId = get().activeRoom?.id;
  if (roomId == null || payload?.roomId !== roomId || typeof payload.messageId !== 'string') return;
  const messageId = payload.messageId;
  set((state) => ({ messages: state.messages.filter((item) => item.id !== messageId) }));
}

function handleMemberCountChange(get: RoomGet, set: RoomSet, data: unknown) {
  const payload = toRecord(data);
  const roomId = get().activeRoom?.id;
  if (roomId == null || payload?.roomId !== roomId || typeof payload.memberCount !== 'number') return;
  set({ memberCount: payload.memberCount });
  void reloadMembers(get, set, roomId);
}

export function registerRoomRealtime(set: RoomSet, get: RoomGet) {
  if (registered) return;
  registered = true;

  SocketService.on(ROOM_SOCKET_EVENTS.newMessage, (data) => handleNewMessage(get, set, data));
  SocketService.on(ROOM_SOCKET_EVENTS.messageDeleted, (data) => handleMessageDeleted(get, set, data));
  SocketService.on(ROOM_SOCKET_EVENTS.memberJoined, (data) => handleMemberCountChange(get, set, data));
  SocketService.on(ROOM_SOCKET_EVENTS.memberLeft, (data) => handleMemberCountChange(get, set, data));
}
