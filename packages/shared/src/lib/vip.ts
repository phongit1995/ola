import { VIP_CATALOG } from './vip.constants';
import type { VipCatalogEntry } from '../types/lib.type';

export { VIP_CATALOG } from './vip.constants';
export type { VipCatalogEntry } from '../types/lib.type';

export function vipById(id: number): VipCatalogEntry | undefined {
  return VIP_CATALOG[id - 1];
}

export function vipName(id: number): string {
  return vipById(id)?.name ?? `VIP ${id}`;
}

export function vipIconUrl(id: number): string {
  return `/vip-icons/vip_${String(id).padStart(3, '0')}.png`;
}

export function parseVipTypeId(vipUsed: string | null | undefined): number | null {
  if (vipUsed == null || vipUsed === '') return null;
  const id = Number(vipUsed);
  if (!Number.isInteger(id) || id < 1 || id > VIP_CATALOG.length) return null;
  return id;
}

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
