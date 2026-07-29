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

export interface MarriageState {
  loading: boolean;
  loaded: boolean;
  status: MarriageStatus;
  spouse: Spouse | null;
  marriedSince: number | null;
  diary: DiaryEntry[];
  pendingProposals: PendingProposal[];
  sentProposals: SentProposal[];
  load: () => Promise<void>;
  propose: (addresseeId: string, message: string) => Promise<void>;
  cancelSent: (id: string) => Promise<void>;
  acceptProposal: (id: string) => Promise<void>;
  denyProposal: (id: string) => Promise<void>;
  divorce: () => Promise<void>;
  writeBox: (content: string) => Promise<void>;
}
