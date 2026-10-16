export type EggCategoryType = 'nothing' | 'vip_icon' | 'ken' | 'vip_days'

export interface EggPack {
  id: string
  name: string
  kenCost: number
  isEnabled: boolean
}

export interface EggCategory {
  id: string
  packId: string
  type: EggCategoryType
  label: string
  weight: number
  isActive: boolean
}

export interface EggReward {
  id: string
  categoryId: string
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
}

export interface CategoryTemplate {
  type: EggCategoryType
  label: string
  hasItems: boolean
}
