import type { ChatReplySnapshot } from '@app-types';
import type { MessageMetadata } from '@lib';
import type {
  ChatMessageKind,
  ChatMessageStatus,
  ContactGroup,
  DeviceType,
} from './types';

export interface Conversation {
  name: string;
  last: string;
  time: string;
  color: string;
  unread: number;
}

export interface Contact {
  id: string;
  name: string;
  fullName?: string;
  status?: string;
  color: string;
  avatar?: string;
  vip: boolean;
  vipTypeId?: number | null;
  online: boolean;
  deviceType: DeviceType;
  lastActive?: string;
  statusImage?: string;
  group: ContactGroup;
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
