import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminKenService } from '@/services/adminKen.service'
import type {
  KenAdjustRequest,
  KenTransferListParams,
  KenTransferUserStatsParams,
} from '@/types'

const KEN_KEY = 'admin-ken'
const USERS_KEY = 'admin-users'
const KEN_TRANSFERS_KEY = 'admin-ken-transfers'
const KEN_TRANSFER_USER_STATS_KEY = 'admin-ken-transfer-user-stats'

export function useKenTransfers(params: KenTransferListParams, enabled = true) {
  return useQuery({
    queryKey: [KEN_TRANSFERS_KEY, params],
    queryFn: () => AdminKenService.listTransfers(params),
    enabled,
  })
}

export function useKenTransferUserStats(params: KenTransferUserStatsParams, enabled = true) {
  return useQuery({
    queryKey: [KEN_TRANSFER_USER_STATS_KEY, params],
    queryFn: () => AdminKenService.getTransferUserStats(params),
    enabled,
  })
}

export function useKenTransactions(
  userId: string | null,
  params: { limit: number; offset: number },
) {
  return useQuery({
    queryKey: [KEN_KEY, userId, params],
    queryFn: () => AdminKenService.listTransactions(userId as string, params),
    enabled: userId != null,
    placeholderData: (prev) => prev,
  })
}

export function useAdjustKen() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ userId, payload }: { userId: string; payload: KenAdjustRequest }) =>
      AdminKenService.adjust(userId, payload),
    onSuccess: (_res, { userId }) => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
      void queryClient.invalidateQueries({ queryKey: [KEN_KEY, userId] })
    },
  })
}
