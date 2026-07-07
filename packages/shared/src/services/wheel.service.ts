import { http } from '../api';
import { API_PATH } from '../config';
import type {
  WheelConfig,
  WheelSpinHistoryFilter,
  WheelSpinHistoryResult,
  WheelSpinResult,
} from '../types';

export class WheelService {
  static getConfig(): Promise<WheelConfig> {
    return http.get<WheelConfig>(API_PATH.wheel.config);
  }

  static spin(idempotencyKey: string): Promise<WheelSpinResult> {
    return http.post<WheelSpinResult>(API_PATH.wheel.spins, { idempotencyKey });
  }

  static listSpins(
    limit: number,
    offset: number,
    outcome: WheelSpinHistoryFilter
  ): Promise<WheelSpinHistoryResult> {
    return http.get<WheelSpinHistoryResult>(API_PATH.wheel.spins, {
      params: { limit, offset, ...(outcome === 'all' ? {} : { outcome }) },
    });
  }
}
