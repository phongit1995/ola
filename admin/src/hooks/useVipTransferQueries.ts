import { useQuery } from '@tanstack/react-query'
import { AdminVipService } from '@/services/adminVip.service'
import type { VipTransferListParams } from '@/types'

const VIP_TRANSFERS_KEY = 'admin-vip-transfers'

export function useVipTransfers(params: VipTransferListParams, enabled = true) {
  return useQuery({
    queryKey: [VIP_TRANSFERS_KEY, params],
    queryFn: () => AdminVipService.listTransfers(params),
    enabled,
  })
}

const VIP_HISTORY_KEY = 'admin-vip-history'

export function useVipHistory(
  userId: string | null,
  params: { limit: number; offset: number },
) {
  return useQuery({
    queryKey: [VIP_HISTORY_KEY, userId, params],
    queryFn: () => AdminVipService.listHistory(userId as string, params),
    enabled: userId != null,
    placeholderData: (prev) => prev,
  })
}
