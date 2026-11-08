import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminAvatarFrameService } from '@/services/adminAvatarFrame.service'
import type {
  AvatarFramePurchaseListParams,
  AvatarFramePurchaseStatsParams,
  AvatarFrameTransferListParams,
  CreateAvatarFrameShopItemsRequest,
  UpdateAvatarFrameShopItemRequest,
} from '@/types'

const AVATAR_FRAME_SHOP_KEY = 'admin-avatar-frame-shop'
const AVATAR_FRAME_PURCHASES_KEY = 'admin-avatar-frame-purchases'
const AVATAR_FRAME_PURCHASE_STATS_KEY = 'admin-avatar-frame-purchase-stats'
const AVATAR_FRAME_TRANSFERS_KEY = 'admin-avatar-frame-transfers'

export function useAvatarFrameShopItems() {
  return useQuery({
    queryKey: [AVATAR_FRAME_SHOP_KEY],
    queryFn: () => AdminAvatarFrameService.listShopItems(),
  })
}

export function useCreateAvatarFrameShopItems() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateAvatarFrameShopItemsRequest) =>
      AdminAvatarFrameService.createShopItems(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [AVATAR_FRAME_SHOP_KEY] })
    },
  })
}

export function useUpdateAvatarFrameShopItem() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateAvatarFrameShopItemRequest }) =>
      AdminAvatarFrameService.updateShopItem(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [AVATAR_FRAME_SHOP_KEY] })
    },
  })
}

export function useDeleteAvatarFrameShopItem() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminAvatarFrameService.removeShopItem(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [AVATAR_FRAME_SHOP_KEY] })
    },
  })
}

export function useAvatarFramePurchases(params: AvatarFramePurchaseListParams) {
  return useQuery({
    queryKey: [AVATAR_FRAME_PURCHASES_KEY, params],
    queryFn: () => AdminAvatarFrameService.listPurchases(params),
    placeholderData: (prev) => prev,
  })
}

export function useAvatarFramePurchaseStats(params: AvatarFramePurchaseStatsParams) {
  return useQuery({
    queryKey: [AVATAR_FRAME_PURCHASE_STATS_KEY, params],
    queryFn: () => AdminAvatarFrameService.getPurchaseStats(params),
    placeholderData: (prev) => prev,
  })
}

export function useAvatarFrameTransfers(params: AvatarFrameTransferListParams) {
  return useQuery({
    queryKey: [AVATAR_FRAME_TRANSFERS_KEY, params],
    queryFn: () => AdminAvatarFrameService.listTransfers(params),
    placeholderData: (prev) => prev,
  })
}
