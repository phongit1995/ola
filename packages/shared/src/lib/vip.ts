import { parseVipTypeId } from './vipIcon';

export function isVipActive(vipEndTime?: string | null): boolean {
  if (vipEndTime == null || vipEndTime === '') return false;
  const end = new Date(vipEndTime).getTime();
  return !Number.isNaN(end) && end > Date.now();
}

export function activeVipTypeId(
  vipUsed?: string | null,
  vipEndTime?: string | null
): number | null {
  return isVipActive(vipEndTime) ? parseVipTypeId(vipUsed) : null;
}
