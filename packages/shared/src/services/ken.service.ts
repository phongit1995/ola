import { http } from '../api';
import { API_PATH } from '../config';
import type {
  KenHistoryParams,
  KenHistoryResult,
  TransferKenRequest,
  TransferKenResult,
} from '../types';

export class KenService {
  static transfer(body: TransferKenRequest): Promise<TransferKenResult> {
    return http.post<TransferKenResult>(API_PATH.ken.transfer, body);
  }

  static history(params: KenHistoryParams = {}): Promise<KenHistoryResult> {
    return http.get<KenHistoryResult>(API_PATH.ken.transactions, { params });
  }
}
