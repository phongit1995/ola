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
