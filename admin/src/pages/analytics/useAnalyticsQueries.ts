import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminAnalyticsService } from '@/services/adminAnalytics.service'
import { usePutAppSetting } from '@/hooks/useAppSettingQueries'
import type { AnalyticsPlatform, AnalyticsQueryParams, AnalyticsSettingValue } from '@/types'
import { ANALYTICS_REALTIME_POLL_MS, ANALYTICS_SETTING_KEY, ANALYTICS_STALE_MS } from './constants'

const ANALYTICS_KEY = 'admin-analytics'

function overviewKey(params: AnalyticsQueryParams) {
  return [ANALYTICS_KEY, 'overview', params] as const
}

function realtimeKey(platform: AnalyticsPlatform) {
  return [ANALYTICS_KEY, 'realtime', platform] as const
}

export function useAnalyticsOverview(params: AnalyticsQueryParams) {
  return useQuery({
    queryKey: overviewKey(params),
    queryFn: () => AdminAnalyticsService.getOverview(params),
    placeholderData: (prev) => prev,
    staleTime: ANALYTICS_STALE_MS,
  })
}

export function useAnalyticsRealtime(platform: AnalyticsPlatform, enabled: boolean) {
  return useQuery({
    queryKey: realtimeKey(platform),
    queryFn: () => AdminAnalyticsService.getRealtime(platform),
    enabled,
    refetchInterval: ANALYTICS_REALTIME_POLL_MS,
  })
}

export function useRefreshAnalytics(params: AnalyticsQueryParams) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: () =>
      Promise.all([
        AdminAnalyticsService.getOverview({ ...params, refresh: true }),
        AdminAnalyticsService.getRealtime(params.platform, true),
      ]),
    onSuccess: ([overview, realtime]) => {
      queryClient.setQueryData(overviewKey(params), overview)
      queryClient.setQueryData(realtimeKey(params.platform), realtime)
    },
  })
}

export function useSaveAnalyticsSetting() {
  const queryClient = useQueryClient()
  const putSetting = usePutAppSetting()
  return useMutation({
    mutationFn: (value: AnalyticsSettingValue) =>
      putSetting.mutateAsync({ key: ANALYTICS_SETTING_KEY, value: { ...value } }),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [ANALYTICS_KEY] })
    },
  })
}
