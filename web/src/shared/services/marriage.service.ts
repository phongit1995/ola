import { http } from '@api';
import { API_PATH } from '@config';
import type { MessageResult } from '@app-types';

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

export class MarriageService {
  static status(): Promise<MarriageStatusResult> {
    return http.get<MarriageStatusResult>(API_PATH.marriage.status);
  }

  static proposals(direction: 'incoming' | 'outgoing'): Promise<ProposalListResult> {
    return http.get<ProposalListResult>(API_PATH.marriage.proposals, {
      params: { direction, limit: 50 },
    });
  }

  static propose(addresseeId: string, message: string): Promise<ProposeResult> {
    return http.post<ProposeResult>(API_PATH.marriage.proposals, { addresseeId, message });
  }

  static accept(id: string): Promise<MarriageStatusResult> {
    return http.post<MarriageStatusResult>(API_PATH.marriage.proposalAccept(id));
  }

  static reject(id: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.marriage.proposalReject(id));
  }

  static cancel(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.marriage.proposal(id));
  }

  static divorce(): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.marriage.divorce);
  }

  static diary(): Promise<DiaryListResult> {
    return http.get<DiaryListResult>(API_PATH.marriage.diary, { params: { limit: 50 } });
  }

  static writeDiary(content: string): Promise<DiaryEntryResult> {
    return http.post<DiaryEntryResult>(API_PATH.marriage.diary, { content });
  }

  static deleteDiary(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.marriage.diaryDetail(id));
  }
}
