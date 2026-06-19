import { http } from '@api';
import { API_PATH } from '@config';
import type {
  BuyVipIconResult,
  BuyVipPackageResult,
  VipIconCatalogResult,
  VipPackageListResult,
  VipStoreResult,
} from '@app-types';

export class VipService {
  static iconCatalog(): Promise<VipIconCatalogResult> {
    return http.get<VipIconCatalogResult>(API_PATH.vip.iconCatalog);
  }

  static buyIcon(shopItemId: string): Promise<BuyVipIconResult> {
    return http.post<BuyVipIconResult>(API_PATH.vip.buy, { shopItemId });
  }

  static listPackages(): Promise<VipPackageListResult> {
    return http.get<VipPackageListResult>(API_PATH.vip.packages);
  }

  static buyPackage(packageId: string): Promise<BuyVipPackageResult> {
    return http.post<BuyVipPackageResult>(API_PATH.vip.buyPackage(packageId));
  }

  static store(): Promise<VipStoreResult> {
    return http.get<VipStoreResult>(API_PATH.vip.store);
  }

  static setPrivacy(privacy: number): Promise<unknown> {
    return http.put<unknown>(API_PATH.vip.storePrivacy, { privacy });
  }

  static activateIcon(instanceId: string): Promise<unknown> {
    return http.post<unknown>(API_PATH.vip.iconUse(instanceId));
  }

  static lockIcon(instanceId: string): Promise<unknown> {
    return http.post<unknown>(API_PATH.vip.iconLock(instanceId));
  }

  static unlockIcon(instanceId: string): Promise<unknown> {
    return http.post<unknown>(API_PATH.vip.iconUnlock(instanceId));
  }

  static deleteIcon(instanceId: string): Promise<unknown> {
    return http.del<unknown>(API_PATH.vip.iconDelete(instanceId));
  }
}
