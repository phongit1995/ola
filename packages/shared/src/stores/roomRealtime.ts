import type { StoreApi } from 'zustand';
import { RoomService, SocketService } from '../services';
import { useAuthStore } from './authStore';
import { useRoomFilterStore } from './roomFilterStore';
import { ROOM_SOCKET_EVENTS, type RoomMessage, type RoomReactor } from '../types';
import { playRoomTagSound } from '../platform/sound';
import {
  markRoomMessageById,
  messageMentionsUser,
  reconcileRoomServerMessage,
  toRecord,
  withSenderVip,
  withVipTypeId,
} from './roomHelpers';
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
  if (
    incoming.senderId !== me?.id &&
    useRoomFilterStore.getState().isBlocked(incoming.senderId)
  ) {
    return;
  }
  const matchesIncoming = (item: RoomMessage) =>
    item.id === incoming.id ||
    (incoming.clientMsgId != null && item.clientMsgId === incoming.clientMsgId);
  const isNew = !get().messages.some(matchesIncoming);
  const fromMe = incoming.senderId === me?.id;
  set((state) => {
    const messages = reconcileRoomServerMessage(state.messages, incoming);
    if (fromMe || !isNew) return { messages };
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

function handleReactionUpdated(get: RoomGet, set: RoomSet, data: unknown) {
  const payload = toRecord(data);
  const roomId = get().activeRoom?.id;
  if (roomId == null || payload?.roomId !== roomId || typeof payload.messageId !== 'string') return;
  const messageId = payload.messageId;
  const reactions = (toRecord(payload.reactions) ?? {}) as Record<string, RoomReactor[]>;
  const me = useAuthStore.getState().user;
  const target = get().messages.find((item) => item.id === messageId);
  const actorUserId = typeof payload.actorUserId === 'string' ? payload.actorUserId : '';
  const actorUsername = typeof payload.actorUsername === 'string' ? payload.actorUsername : '';
  const reactionType = typeof payload.type === 'string' ? payload.type : '';
  const notifyOwnMessageReaction =
    payload.action === 'added' &&
    target?.senderId === me?.id &&
    actorUserId !== me?.id &&
    actorUsername !== '';
  set((state) => ({
    messages: markRoomMessageById(state.messages, messageId, { reactions }),
    ...(notifyOwnMessageReaction
      ? {
          reactionNotice: {
            seq: (state.reactionNotice?.seq ?? 0) + 1,
            username: actorUsername,
            type: reactionType,
          },
        }
      : {}),
  }));
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
  SocketService.on(ROOM_SOCKET_EVENTS.reactionUpdated, (data) => handleReactionUpdated(get, set, data));
  SocketService.on(ROOM_SOCKET_EVENTS.memberJoined, (data) => handleMemberCountChange(get, set, data));
  SocketService.on(ROOM_SOCKET_EVENTS.memberLeft, (data) => handleMemberCountChange(get, set, data));
}
