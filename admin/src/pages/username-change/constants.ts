import type { UsernameChangeSetting } from '@/types'

export const DEFAULT_USERNAME_CHANGE: UsernameChangeSetting = {
  enabled: true,
  enabledMobile: true,
  tiers: [
    { minLength: 2, cost: 2_000_000 },
    { minLength: 3, cost: 1_000_000 },
    { minLength: 4, cost: 500_000 },
    { minLength: 6, cost: 100_000 },
  ],
}

export const ACTOR_OPTIONS = [
  { value: 'user', label: 'User tự đổi' },
  { value: 'admin', label: 'Admin đổi hộ' },
]
