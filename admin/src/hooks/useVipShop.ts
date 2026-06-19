import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminVipService } from '@/services/adminVip.service'
import type { CreateVipShopItemRequest, UpdateVipShopItemRequest } from '@/types'

const VIP_SHOP_KEY = 'admin-vip-shop'

export function useVipShopItems() {
  return useQuery({
    queryKey: [VIP_SHOP_KEY],
    queryFn: () => AdminVipService.listShopItems(),
  })
}

export function useCreateVipShopItem() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateVipShopItemRequest) => AdminVipService.createShopItem(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [VIP_SHOP_KEY] })
    },
  })
}

export function useUpdateVipShopItem() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateVipShopItemRequest }) =>
      AdminVipService.updateShopItem(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [VIP_SHOP_KEY] })
    },
  })
}

export function useDeleteVipShopItem() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminVipService.removeShopItem(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [VIP_SHOP_KEY] })
    },
  })
}
