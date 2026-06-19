import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminVipService } from '@/services/adminVip.service'
import type { UpdateVipIconTypeRequest } from '@/types'

const VIP_ICON_TYPES_KEY = 'admin-vip-icon-types'

export function useVipIconTypes() {
  return useQuery({
    queryKey: [VIP_ICON_TYPES_KEY],
    queryFn: () => AdminVipService.listIconTypes(),
  })
}

export function useUpdateVipIconType() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ typeId, payload }: { typeId: number; payload: UpdateVipIconTypeRequest }) =>
      AdminVipService.updateIconType(typeId, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [VIP_ICON_TYPES_KEY] })
    },
  })
}
