export interface Conversation {
  name: string;
  last: string;
  time: string;
  color: string;
  unread: number;
}

export type DeviceType = 'phone' | 'pc' | 'apple' | 'android' | 'winphone';

export type ContactGroup = 'birthday' | 'new' | 'utility' | 'friend';

export interface Contact {
  id: string;
  name: string;
  fullName?: string;
  status?: string;
  color: string;
  avatar?: string;
  vip: boolean;
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
  | 'stranger';

export type ChatMessageStatus = 'sending' | 'sent' | 'seen' | 'failed';

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
  address?: string;
  youtubeTitle?: string;
  youtubeDuration?: string;
  kenAmount?: number;
  vipDirection?: 'sent' | 'received';
  stranger?: StrangerCard;
  senderName?: string;
  senderColor?: string;
  reactions?: Record<string, string[]>;
}
