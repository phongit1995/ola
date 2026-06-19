import { http } from '@api';
import { API_PATH } from '@config';
import type { BuyVipIconResult, VipIconCatalogResult } from '@app-types';

export class VipService {
  static iconCatalog(): Promise<VipIconCatalogResult> {
    return http.get<VipIconCatalogResult>(API_PATH.vip.iconCatalog);
  }

  static buyIcon(typeId: number): Promise<BuyVipIconResult> {
    return http.post<BuyVipIconResult>(API_PATH.vip.buy, { typeId });
  }
}
