import { http } from '@api';
import { API_PATH } from '@config';
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
} from '@app-types';

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
}
