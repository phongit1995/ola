import { keepPreviousData, useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { useListOrder } from '@/hooks/useListOrder'
import { AdminGiftService } from '@/services/adminGift.service'
import type {
  AdminGift,
  CreateGiftRequest,
  GiftTransactionListParams,
  UpdateGiftRequest,
} from '@/types'

const GIFTS_KEY = 'admin-gifts'
const GIFT_TRANSACTIONS_KEY = 'admin-gift-transactions'

export function useGifts() {
  return useQuery({
    queryKey: [GIFTS_KEY],
    queryFn: () => AdminGiftService.list(),
  })
}

export function useCreateGift() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateGiftRequest) => AdminGiftService.create(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [GIFTS_KEY] })
    },
  })
}

export function useUpdateGift() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateGiftRequest }) =>
      AdminGiftService.update(id, payload),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: [GIFTS_KEY] }),
  })
}

export function useGiftOrder(gifts: AdminGift[]) {
  return useListOrder({
    items: gifts,
    queryKey: [GIFTS_KEY],
    orderKey: 'sortOrder',
    reorder: AdminGiftService.reorder,
    nameOf: (gift) => gift.name,
  })
}

export function useDeleteGift() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminGiftService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [GIFTS_KEY] })
    },
  })
}

export function useGiftTransactions(params: GiftTransactionListParams) {
  return useQuery({
    queryKey: [GIFT_TRANSACTIONS_KEY, params],
    queryFn: () => AdminGiftService.transactions(params),
    placeholderData: keepPreviousData,
  })
}
