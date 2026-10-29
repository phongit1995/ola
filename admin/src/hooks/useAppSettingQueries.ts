import { useMutation, useQuery, useQueryClient, type QueryClient } from '@tanstack/react-query'
import { AdminSettingsService } from '@/services/adminSettings.service'
import { ANALYTICS_QUERY_KEY } from '@/lib/constants'

const APP_SETTINGS_KEY = 'admin-app-settings'

function invalidateSettingQueries(queryClient: QueryClient) {
  void queryClient.invalidateQueries({ queryKey: [APP_SETTINGS_KEY] })
  void queryClient.invalidateQueries({ queryKey: [ANALYTICS_QUERY_KEY] })
}

export function useAppSettings() {
  return useQuery({
    queryKey: [APP_SETTINGS_KEY],
    queryFn: () => AdminSettingsService.list(),
  })
}

export function usePutAppSettings() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (items: { key: string; value: Record<string, unknown> }[]) =>
      AdminSettingsService.putMany(items),
    onSuccess: () => invalidateSettingQueries(queryClient),
  })
}

export function useTestMail() {
  return useMutation({
    mutationFn: (to: string) => AdminSettingsService.testMail(to),
  })
}

export function usePutAppSetting() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ key, value }: { key: string; value: Record<string, unknown> }) =>
      AdminSettingsService.put(key, value),
    onSuccess: () => invalidateSettingQueries(queryClient),
  })
}
