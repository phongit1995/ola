import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { MessageResult } from '../types/api/auth.type';
import type {
  DiaryEntryResult,
  DiaryListResult,
  MarriageStatusResult,
  ProposalListResult,
  ProposeResult,
} from '../types/api/marriage.type';

export type {
  DiaryEntryResult,
  DiaryListResult,
  MarriageStatusResult,
  MarriageUserBrief,
  ProposalItem,
  ProposalListResult,
  ProposeResult,
} from '../types/api/marriage.type';

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
