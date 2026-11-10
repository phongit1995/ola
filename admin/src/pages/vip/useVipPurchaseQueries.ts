import { useQuery } from '@tanstack/react-query'
import { AdminVipService } from '@/services/adminVip.service'
import type { VipDayTransferListParams, VipPurchaseListParams, VipPurchaseStatsParams } from '@/types'

const VIP_PURCHASES_KEY = 'admin-vip-purchases'
const VIP_PURCHASE_STATS_KEY = 'admin-vip-purchase-stats'
const VIP_DAY_TRANSFERS_KEY = 'admin-vip-day-transfers'

export function useVipPurchases(params: VipPurchaseListParams) {
  return useQuery({
    queryKey: [VIP_PURCHASES_KEY, params],
    queryFn: () => AdminVipService.listPurchases(params),
    placeholderData: (prev) => prev,
  })
}

export function useVipPurchaseStats(params: VipPurchaseStatsParams) {
  return useQuery({
    queryKey: [VIP_PURCHASE_STATS_KEY, params],
    queryFn: () => AdminVipService.getPurchaseStats(params),
    placeholderData: (prev) => prev,
  })
}

export function useVipDayTransfers(params: VipDayTransferListParams) {
  return useQuery({
    queryKey: [VIP_DAY_TRANSFERS_KEY, params],
    queryFn: () => AdminVipService.listDayTransfers(params),
    placeholderData: (prev) => prev,
  })
}
