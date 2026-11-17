export interface PostQuota {
  used: number;
  limit: number;
  upgradable: boolean;
}

export interface PostQuotaResult {
  isVip: boolean;
  me: PostQuota;
  moment: PostQuota;
}
