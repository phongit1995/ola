import type {
  CheckinCreateMonthRequest,
  CheckinHistoryItem,
  CheckinHistoryParams,
  CheckinMonth,
  CheckinMonthDetail,
  CheckinMonthSource,
  CheckinRewardItem,
  CheckinSetting,
  CheckinSlot,
  CheckinSlotTask,
  CheckinStats,
  CheckinUserMonth,
  ListResult,
} from '@/types'

export type CheckinMonthStatus = 'past' | 'running' | 'upcoming' | 'draft' | 'missing'

export interface CheckinMonthOption {
  month: string
  status: CheckinMonthStatus
}

export interface CheckinItemFormValue {
  type: CheckinRewardItem['type']
  days?: number
  vipIconId?: number
  frameId?: string
  count?: number
  amount?: number
  amountMin?: number
  amountMax?: number
  kenRandom?: boolean
  expiresInDays?: number | null
}

export type CheckinOptionFormValue = CheckinItemFormValue & { weight?: number }

export interface CheckinGiftFormValue {
  options?: CheckinOptionFormValue[]
}

export interface CheckinSlotFormValues {
  enabled: boolean
  gifts?: CheckinGiftFormValue[]
  featured: boolean
  requireVip: boolean
  task: CheckinSlotTask | null
}

export interface CheckinCreateMonthFormValues {
  slotCount: number
  source: CheckinMonthSource
  copyFrom?: string
}

export interface CheckinApi {
  listMonths(): Promise<CheckinMonth[]>
  getMonth(month: string): Promise<CheckinMonthDetail>
  createMonth(payload: CheckinCreateMonthRequest): Promise<CheckinMonthDetail>
  updateSlotCount(month: string, slotCount: number): Promise<CheckinMonthDetail>
  publishMonth(month: string): Promise<CheckinMonthDetail>
  deleteMonth(month: string): Promise<void>
  saveSlots(month: string, slots: CheckinSlot[]): Promise<CheckinMonthDetail>
  swapSlots(month: string, from: number, to: number): Promise<CheckinMonthDetail>
  stats(month: string): Promise<CheckinStats>
  history(params: CheckinHistoryParams): Promise<ListResult<CheckinHistoryItem>>
  userMonth(userId: string, month: string): Promise<CheckinUserMonth>
  getSetting(): Promise<CheckinSetting>
  saveSetting(value: CheckinSetting): Promise<void>
}
