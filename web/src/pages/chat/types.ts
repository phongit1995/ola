export interface Conversation {
  name: string;
  last: string;
  time: string;
  color: string;
  unread: number;
}

export interface Contact {
  name: string;
  status: string;
  color: string;
  gender: 'male' | 'female';
  vip: boolean;
  online: boolean;
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
