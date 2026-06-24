export type MarriageStatus = 'single' | 'married';

export interface Spouse {
  nick: string;
  name: string;
  avatarColor: string;
  avatarUrl?: string;
}

export interface DiaryEntry {
  id: string;
  author: 'me' | 'spouse';
  content: string;
  createdAt: number;
}

export interface PendingProposal {
  id: string;
  fromNick: string;
  fromName: string;
  avatarColor: string;
  message: string;
}

export interface SentProposal {
  id: string;
  toNick: string;
  message: string;
  createdAt: number;
}
