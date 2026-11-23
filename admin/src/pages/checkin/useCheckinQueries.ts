import { keepPreviousData, useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { settingValue } from '@/lib/appSetting'
import { AdminCheckinService } from '@/services/adminCheckin.service'
import { AdminSettingsService } from '@/services/adminSettings.service'
import type { CheckinCreateMonthRequest, CheckinHistoryParams, CheckinMonthDetail, CheckinSetting, CheckinSlot } from '@/types'
import { CHECKIN_QUERY_KEY, CHECKIN_SETTING_KEY, DEFAULT_CHECKIN_SETTING } from './constants'
import type { CheckinApi } from './types'
import { swapSlots } from './utils'

const api: CheckinApi = {
  ...AdminCheckinService,
  async getSetting() {
    return settingValue(await AdminSettingsService.list(), CHECKIN_SETTING_KEY, DEFAULT_CHECKIN_SETTING)
  },
  async saveSetting(value) {
    await AdminSettingsService.put(CHECKIN_SETTING_KEY, { ...value })
  },
}

export function useCheckinMonths() {
  return useQuery({
    queryKey: [CHECKIN_QUERY_KEY, 'months'],
    queryFn: () => api.listMonths(),
  })
}

export function useCheckinMonth(month: string | undefined) {
  return useQuery({
    queryKey: [CHECKIN_QUERY_KEY, 'month', month],
    queryFn: () => api.getMonth(month ?? ''),
    enabled: month != null && month !== '',
  })
}

export function useCheckinStats(month: string | undefined) {
  return useQuery({
    queryKey: [CHECKIN_QUERY_KEY, 'stats', month],
    queryFn: () => api.stats(month ?? ''),
    enabled: month != null && month !== '',
  })
}

export function useCheckinHistory(params: CheckinHistoryParams | undefined) {
  return useQuery({
    queryKey: [CHECKIN_QUERY_KEY, 'history', params],
    queryFn: () => api.history(params as CheckinHistoryParams),
    enabled: params != null,
    placeholderData: keepPreviousData,
  })
}

export function useCheckinUserMonth(userId: string | undefined, month: string | undefined) {
  return useQuery({
    queryKey: [CHECKIN_QUERY_KEY, 'user-month', userId, month],
    queryFn: () => api.userMonth(userId ?? '', month ?? ''),
    enabled: !!userId && !!month,
  })
}

export function useCheckinSetting() {
  return useQuery({
    queryKey: [CHECKIN_QUERY_KEY, 'setting'],
    queryFn: () => api.getSetting(),
  })
}

function useInvalidateCheckin() {
  const queryClient = useQueryClient()
  return () => queryClient.invalidateQueries({ queryKey: [CHECKIN_QUERY_KEY] })
}

export function useCreateCheckinMonth() {
  const invalidate = useInvalidateCheckin()
  return useMutation({
    mutationFn: (payload: CheckinCreateMonthRequest) => api.createMonth(payload),
    onSuccess: invalidate,
  })
}

export function useUpdateCheckinSlotCount() {
  const invalidate = useInvalidateCheckin()
  return useMutation({
    mutationFn: ({ month, slotCount }: { month: string; slotCount: number }) => api.updateSlotCount(month, slotCount),
    onSuccess: invalidate,
  })
}

export function usePublishCheckinMonth() {
  const invalidate = useInvalidateCheckin()
  return useMutation({
    mutationFn: (month: string) => api.publishMonth(month),
    onSuccess: invalidate,
  })
}

export function useDeleteCheckinMonth() {
  const invalidate = useInvalidateCheckin()
  return useMutation({
    mutationFn: (month: string) => api.deleteMonth(month),
    onSuccess: invalidate,
  })
}

export function useSaveCheckinSlots() {
  const invalidate = useInvalidateCheckin()
  return useMutation({
    mutationFn: ({ month, slots }: { month: string; slots: CheckinSlot[] }) => api.saveSlots(month, slots),
    onSettled: invalidate,
  })
}

export function useSwapCheckinSlots() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ month, from, to }: { month: string; from: number; to: number }) => api.swapSlots(month, from, to),
    onMutate: async ({ month, from, to }) => {
      const key = [CHECKIN_QUERY_KEY, 'month', month]
      await queryClient.cancelQueries({ queryKey: key })
      const previous = queryClient.getQueryData<CheckinMonthDetail>(key)
      if (previous) {
        const swapped = swapSlots(previous.slots, from, to)
        const slots = previous.slots.map((slot) => swapped.find((item) => item.slot === slot.slot) ?? slot)
        queryClient.setQueryData<CheckinMonthDetail>(key, { ...previous, slots })
      }
      return { key, previous }
    },
    onError: (_err, _vars, context) => {
      if (context?.previous) queryClient.setQueryData(context.key, context.previous)
    },
    onSettled: () => queryClient.invalidateQueries({ queryKey: [CHECKIN_QUERY_KEY] }),
  })
}

export function useSaveCheckinSetting() {
  const invalidate = useInvalidateCheckin()
  return useMutation({
    mutationFn: (value: CheckinSetting) => api.saveSetting(value),
    onSuccess: invalidate,
  })
}
