import type { StoreApi } from 'zustand';
import type { UploadFile } from './upload.type';
import type { ReactionType } from '../api/chat.type';
import type {
  RoomMember,
  RoomMessage,
  RoomReactionNotice,
} from '../api/room.type';

export type RoomChatStatus = 'connecting' | 'joined' | 'error';
export type RoomTab = 'members' | 'messages';
export type RoomAudioSendResult = 'sent' | 'failed' | 'aborted';

export interface ActiveRoom {
  id: string;
  name: string;
}

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
  sendAudio: (
    file: UploadFile,
    duration: number,
    waveform: number[]
  ) => Promise<RoomAudioSendResult>;
  resendRoomImage: (messageId: string) => Promise<void>;
  resendRoomAudio: (messageId: string) => Promise<void>;
  loadMoreMessages: () => Promise<void>;
  setReplyTarget: (message: RoomMessage) => void;
  clearReplyTarget: () => void;
  clearReactionNotice: (seq: number) => void;
  reactToRoomMessage: (messageId: string, type: ReactionType) => Promise<void>;
  deleteRoomMessage: (messageId: string) => Promise<void>;
}

export type RoomChatSet = StoreApi<RoomChatState>['setState'];
export type RoomChatGet = StoreApi<RoomChatState>['getState'];

export type RoomChatStateData = Pick<
  RoomChatState,
  | 'activeRoom'
  | 'status'
  | 'activeTab'
  | 'messages'
  | 'members'
  | 'memberCount'
  | 'hasUnread'
  | 'messagesUnread'
  | 'roomForeground'
  | 'hasMore'
  | 'loadingMore'
  | 'replyTarget'
  | 'reactionNotice'
>;

export type RoomLifecycleActions = Pick<
  RoomChatState,
  'open' | 'close' | 'loadMoreMessages'
>;

export type RoomMessageActions = Pick<
  RoomChatState,
  | 'sendMessage'
  | 'sendImage'
  | 'sendAudio'
  | 'resendRoomImage'
  | 'resendRoomAudio'
  | 'reactToRoomMessage'
  | 'deleteRoomMessage'
>;
