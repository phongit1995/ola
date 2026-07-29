import type {
  RoomMessage,
  RoomMessageStatus,
  RoomReactor,
  RoomReplySnapshot,
} from '../api/room.type';

export type BubblePosition = 'single' | 'first' | 'middle' | 'last';

export interface GroupedMessage {
  id: string;
  key: string;
  content: string;
  type?: 'text' | 'image' | 'audio';
  imageUrl?: string;
  audioUrl?: string;
  audioDuration?: number;
  audioWaveform?: number[];
  audioMimeType?: string;
  createdAt: string;
  position: BubblePosition;
  replyTo?: RoomReplySnapshot;
  reactions?: Record<string, RoomReactor[]>;
  status?: RoomMessageStatus;
}

export interface MessageGroup {
  kind: 'group';
  key: string;
  isOwn: boolean;
  senderId: string;
  senderName: string;
  senderAvatar?: string;
  senderVipTypeId?: number | null;
  showTime: boolean;
  messages: GroupedMessage[];
}

export interface DateSeparator {
  kind: 'date';
  key: string;
  createdAt: string;
}

export type RoomFeedItem = MessageGroup | DateSeparator;

export interface PendingMessageGroup {
  isOwn: boolean;
  senderId: string;
  senderName: string;
  senderAvatar?: string;
  senderVipTypeId?: number | null;
  raw: RoomMessage[];
}
