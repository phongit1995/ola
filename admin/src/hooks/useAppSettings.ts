import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminSettingsService } from '@/services/adminSettings.service'

const APP_SETTINGS_KEY = 'admin-app-settings'

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
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [APP_SETTINGS_KEY] })
    },
  })
}

export function usePutAppSetting() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ key, value }: { key: string; value: Record<string, unknown> }) =>
      AdminSettingsService.put(key, value),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [APP_SETTINGS_KEY] })
    },
  })
}
