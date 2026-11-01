import type { MeListItem } from '@/types'
import { ME_HIDDEN_BY_LABEL } from './constants'
import type { TriState } from './types'

export const triToBool = (v: TriState): boolean | undefined =>
  v === 'all' ? undefined : v === 'yes'

export function meHiddenByLabel(post: Pick<MeListItem, 'enabled' | 'hiddenBy'>): string | null {
  if (post.enabled || post.hiddenBy == null) return null
  return ME_HIDDEN_BY_LABEL[post.hiddenBy]
}
