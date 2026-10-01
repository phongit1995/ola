import type { AppSetting } from '@/types'

export function settingValue<T>(settings: AppSetting[] | undefined, key: string, defaults: T): T {
  const found = settings?.find((item) => item.key === key)
  if (!found) return defaults
  return { ...defaults, ...(found.value as Partial<T>) }
}
