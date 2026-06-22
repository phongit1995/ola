import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminKenService } from '@/services/adminKen.service'
import type { KenAdjustRequest } from '@/types'

const KEN_KEY = 'admin-ken'
const USERS_KEY = 'admin-users'

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
