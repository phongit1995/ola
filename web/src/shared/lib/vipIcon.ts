export function vipIconUrl(id: number): string {
  return `/vip-icons/vip_${String(id).padStart(3, '0')}.png`;
}

export function parseVipTypeId(vipUsed: string | null | undefined): number | null {
  if (vipUsed == null || vipUsed === '') return null;
  const id = Number(vipUsed);
  if (!Number.isInteger(id) || id < 1 || id > 120) return null;
  return id;
}
