import type { KenChest } from '@/types'

export function kenChestRewardText(chest: KenChest): string {
  if (chest.rewardMode === 'fixed') {
    return `${(chest.kenAmount ?? 0).toLocaleString('vi-VN')} KEN`
  }
  return `${(chest.kenMin ?? 0).toLocaleString('vi-VN')} – ${(chest.kenMax ?? 0).toLocaleString('vi-VN')} KEN`
}
