import type { RoomMember, RoomMessage, RoomReactionNotice } from '../../types/api/room.type';
import type {
  ActiveRoom,
  RoomChatStateData,
  RoomChatStatus,
  RoomTab,
} from '../../types/client/roomChat.type';

export type { RoomChatGet, RoomChatSet } from '../../types/client/roomChat.type';

export const initialRoomChatState: RoomChatStateData = {
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
  replyTarget: null,
  reactionNotice: null as RoomReactionNotice | null,
};
