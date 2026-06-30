import { http } from '@api';
import { API_PATH } from '@config';
import type { TransferKenRequest, TransferKenResult } from '@app-types';

export class KenService {
  static transfer(body: TransferKenRequest): Promise<TransferKenResult> {
    return http.post<TransferKenResult>(API_PATH.ken.transfer, body);
  }
}
