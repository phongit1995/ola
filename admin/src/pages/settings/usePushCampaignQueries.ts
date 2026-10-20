import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminPushCampaignService } from '@/services/adminPushCampaign.service'
import type { CreatePushCampaignRequest, ListParams, PushAudience } from '@/types'
import { PUSH_HISTORY_POLL_MS } from './constants'

const PUSH_CAMPAIGNS_KEY = 'admin-push-campaigns'

export function usePushCampaigns(params: ListParams) {
  return useQuery({
    queryKey: [PUSH_CAMPAIGNS_KEY, params],
    queryFn: () => AdminPushCampaignService.list(params),
    placeholderData: (prev) => prev,
    refetchInterval: (query) =>
      query.state.data?.items.some((item) => item.status === 'queued' || item.status === 'sending')
        ? PUSH_HISTORY_POLL_MS
        : false,
  })
}

export function usePushAudience(audience: PushAudience, username: string) {
  const needsUsername = audience === 'user'
  return useQuery({
    queryKey: [PUSH_CAMPAIGNS_KEY, 'audience', audience, needsUsername ? username : ''],
    queryFn: () =>
      AdminPushCampaignService.audience(audience, needsUsername ? username : undefined),
    enabled: !needsUsername || username !== '',
    retry: false,
  })
}

export function useCreatePushCampaign() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreatePushCampaignRequest) => AdminPushCampaignService.create(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [PUSH_CAMPAIGNS_KEY] })
    },
  })
}
