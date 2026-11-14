import type { PlatformRules } from '@/types'

export const DEFAULT_ODDS_VISIBILITY: PlatformRules = {
  web: { enabled: false, disableVersions: [] },
  android: { enabled: true, disableVersions: [] },
  ios: { enabled: true, disableVersions: [] },
}
