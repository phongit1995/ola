import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminVipService } from '@/services/adminVip.service'
import type { CreateVipPackageRequest, ListParams, UpdateVipPackageRequest } from '@/types'

const VIP_PACKAGES_KEY = 'admin-vip-packages'

export function useVipPackages(params: ListParams) {
  return useQuery({
    queryKey: [VIP_PACKAGES_KEY, params],
    queryFn: () => AdminVipService.listPackages(params),
    placeholderData: (prev) => prev,
  })
}

export function useCreateVipPackage() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateVipPackageRequest) => AdminVipService.create(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [VIP_PACKAGES_KEY] })
    },
  })
}

export function useUpdateVipPackage() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: UpdateVipPackageRequest }) =>
      AdminVipService.update(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [VIP_PACKAGES_KEY] })
    },
  })
}

export function useDeleteVipPackage() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminVipService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [VIP_PACKAGES_KEY] })
    },
  })
}
