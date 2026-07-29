import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  CreateShotRequest,
  CreateShotResponse,
  CatchRequest,
  CatchResult,
  CancelResponse,
  PenShotListResult,
  PenOpenParams,
  PenPageParams,
  PenHistoryParams,
  PenLeaderboardPeriod,
  PenLeaderboardResult,
} from '../types/api/pen.type';

export class PenService {
  static createShot(payload: CreateShotRequest): Promise<CreateShotResponse> {
    return http.post<CreateShotResponse>(API_PATH.pen.shots, payload);
  }

  static listOpenShots(params: PenOpenParams = {}): Promise<PenShotListResult> {
    return http.get<PenShotListResult>(API_PATH.pen.shots, { params });
  }

  static listMyOpenShots(params: PenPageParams = {}): Promise<PenShotListResult> {
    return http.get<PenShotListResult>(API_PATH.pen.mine, { params });
  }

  static catchShot(id: string, payload: CatchRequest): Promise<CatchResult> {
    return http.post<CatchResult>(API_PATH.pen.catch(id), payload);
  }

  static cancelShot(id: string): Promise<CancelResponse> {
    return http.post<CancelResponse>(API_PATH.pen.cancel(id), {});
  }

  static history(params: PenHistoryParams = {}): Promise<PenShotListResult> {
    return http.get<PenShotListResult>(API_PATH.pen.history, { params });
  }

  static allHistory(params: PenPageParams = {}): Promise<PenShotListResult> {
    return http.get<PenShotListResult>(API_PATH.pen.historyAll, { params });
  }

  static leaderboard(period: PenLeaderboardPeriod = 'day'): Promise<PenLeaderboardResult> {
    return http.get<PenLeaderboardResult>(API_PATH.pen.leaderboard, { params: { period } });
  }
}
