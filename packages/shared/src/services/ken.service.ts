import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type {
  KenHistoryParams,
  KenHistoryResult,
  TransferKenRequest,
  TransferKenResult,
} from '../types/api/ken.type';

export class KenService {
  static transfer(body: TransferKenRequest): Promise<TransferKenResult> {
    return http.post<TransferKenResult>(API_PATH.ken.transfer, body);
  }

  static history(params: KenHistoryParams = {}): Promise<KenHistoryResult> {
    return http.get<KenHistoryResult>(API_PATH.ken.transactions, { params });
  }
}
