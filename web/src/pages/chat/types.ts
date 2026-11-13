import type { ChatReplySnapshot, GiftMessageMetadata } from '@app-types';
import type { MessageMetadata } from '@lib';

export type ChatMessageKind =
  | 'text'
  | 'sticker'
  | 'image'
  | 'voice'
  | 'location'
  | 'snap'
  | 'youtube'
  | 'ken'
  | 'vip'
  | 'stranger'
  | 'call'
  | 'gift';

export type ChatMessageStatus = 'sending' | 'sent' | 'seen' | 'failed';

export interface Conversation {
  name: string;
  last: string;
  time: string;
  color: string;
  unread: number;
}

export interface SuggestedFriend {
  name: string;
  color: string;
}

export interface StrangerCard {
  name: string;
  color: string;
  age: number;
  joinYear: number;
  fans: number;
  status: string;
  vip: boolean;
  verified: boolean;
}

export interface ChatMessage {
  id: string;
  key: string;
  direction: 'in' | 'out';
  kind: ChatMessageKind;
  time: string;
  createdAt?: string;
  status?: ChatMessageStatus;
  text?: string;
  sticker?: string;
  image?: string;
  voiceDuration?: string;
  audioUrl?: string;
  audioDuration?: number;
  audioWaveform?: number[];
  address?: string;
  youtubeTitle?: string;
  youtubeDuration?: string;
  kenAmount?: number;
  vipDirection?: 'sent' | 'received';
  call?: MessageMetadata;
  gift?: GiftMessageMetadata;
  stranger?: StrangerCard;
  senderName?: string;
  senderColor?: string;
  reactions?: Record<string, string[]>;
  replyTo?: ChatReplySnapshot;
}

export interface ConversationView {
  id: string;
  name: string;
  username: string;
  title: string;
  avatar?: string;
  avatarFrameId?: string | null;
  color: string;
  preview: string;
  previewIsSticker: boolean;
  fromMe: boolean;
  seen: boolean;
  senderName?: string;
  isGroup: boolean;
  time: string;
  unread: number;
  online: boolean;
}

export interface ChatMessageAbilities {
  canReply: boolean;
  canCopy: boolean;
  canEdit: boolean;
  canDelete: boolean;
  canReport: boolean;
}

export interface TransferReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
  color: string;
}
