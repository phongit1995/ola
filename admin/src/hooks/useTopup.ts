import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminTopupService } from '@/services/adminTopup.service'
import type { TopupStatsParams, TopupTransactionListParams } from '@/types'

const TOPUP_TRANSACTIONS_KEY = 'admin-topup-transactions'
const TOPUP_STATS_KEY = 'admin-topup-stats'
const USERS_KEY = 'admin-users'

export function useTopupStats(params: TopupStatsParams) {
  return useQuery({
    queryKey: [TOPUP_STATS_KEY, params],
    queryFn: () => AdminTopupService.getStats(params),
    placeholderData: (prev) => prev,
  })
}

export function useTopupTransactions(params: TopupTransactionListParams) {
  return useQuery({
    queryKey: [TOPUP_TRANSACTIONS_KEY, params],
    queryFn: () => AdminTopupService.listTransactions(params),
    placeholderData: (prev) => prev,
  })
}

export function useManualCreditTopup() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, username }: { id: string; username: string }) =>
      AdminTopupService.manualCredit(id, username),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [TOPUP_TRANSACTIONS_KEY] })
      void queryClient.invalidateQueries({ queryKey: [TOPUP_STATS_KEY] })
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
    },
  })
}
