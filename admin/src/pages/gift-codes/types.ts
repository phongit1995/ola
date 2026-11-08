import type { Dayjs } from 'dayjs'
import type { GiftCodeKind, GiftCodePlatform, GiftCodeRewardType } from '@/types'

export interface GiftCodeRewardFormValue {
  type: GiftCodeRewardType
  days?: number
  vipIconId?: number
}

export interface GiftCodeFormValues {
  name: string
  kind: GiftCodeKind
  code: string
  codePrefix: string
  codeLength: number
  totalUses: number
  rewards: GiftCodeRewardFormValue[]
  successMessage: string
  sendNotification: boolean
  minAccountAgeDays: number
  platforms: GiftCodePlatform[]
  onePerDevice: boolean
  startsAt: Dayjs | null
  endsAt: Dayjs | null
  enabled: boolean
}
