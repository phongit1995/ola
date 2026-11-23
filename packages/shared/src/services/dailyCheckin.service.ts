import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { DailyCheckinActionResult, DailyCheckinStatus } from '../types/api/dailyCheckin.type';

export class DailyCheckinService {
  static status(): Promise<DailyCheckinStatus> {
    return http.get<DailyCheckinStatus>(API_PATH.dailyCheckin.base);
  }

  static checkIn(clientRequestId: string): Promise<DailyCheckinActionResult> {
    return http.post<DailyCheckinActionResult>(API_PATH.dailyCheckin.base, { clientRequestId });
  }

  static open(): Promise<DailyCheckinActionResult> {
    return http.post<DailyCheckinActionResult>(API_PATH.dailyCheckin.open);
  }
}
