import { OddsSunburst } from '../OddsSunburst'
import { CATEGORY_COLORS, type EggCategory, type EggReward } from './eggHelpers'

interface EggOddsSunburstProps {
  categories: EggCategory[]
  rewards: EggReward[]
  size?: number
}

export function EggOddsSunburst({ categories, rewards, size = 340 }: EggOddsSunburstProps) {
  const groups = categories
    .filter((category) => category.isActive && category.weight > 0)
    .map((category) => ({
      id: category.id,
      label: category.label,
      weight: category.weight,
      color: CATEGORY_COLORS[category.type],
      children: rewards
        .filter((reward) => reward.categoryId === category.id && reward.isActive && reward.weight > 0)
        .sort((a, b) => a.sortOrder - b.sortOrder),
    }))
  return <OddsSunburst groups={groups} size={size} icon="🥚" ariaLabel="Tỉ lệ phần thưởng" />
}
