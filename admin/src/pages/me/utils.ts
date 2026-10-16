import type { TriState } from './types'

export const triToBool = (v: TriState): boolean | undefined =>
  v === 'all' ? undefined : v === 'yes'
