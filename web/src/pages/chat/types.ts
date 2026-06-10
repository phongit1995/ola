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

export interface ChatMessage {
  id: string;
  text: string;
  direction: 'in' | 'out';
}
