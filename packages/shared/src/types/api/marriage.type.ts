export interface MarriageUserBrief {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
}

export interface MarriageStatusResult {
  spouse?: MarriageUserBrief;
  marriedAt?: string;
}

export interface ProposalItem {
  id: string;
  status: string;
  message?: string;
  proposer?: MarriageUserBrief;
  addressee?: MarriageUserBrief;
  createdAt: string;
  respondedAt?: string;
}

export interface ProposalListResult {
  total: number;
  limit: number;
  offset: number;
  items: ProposalItem[];
}

export interface DiaryEntryResult {
  id: string;
  content: string;
  author?: MarriageUserBrief;
  createdAt: string;
}

export interface DiaryListResult {
  total: number;
  limit: number;
  offset: number;
  items: DiaryEntryResult[];
}

export interface ProposeResult {
  proposalId: string;
  addresseeUsername: string;
  status: string;
}
