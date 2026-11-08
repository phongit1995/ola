import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { useListOrder } from '@/hooks/useListOrder'
import { fetchAllPages } from '@/lib/fetchAllPages'
import { AdminVipService } from '@/services/adminVip.service'
import type { CreateVipPackageRequest, UpdateVipPackageRequest, VipPackage } from '@/types'

const VIP_PACKAGES_KEY = 'admin-vip-packages'

export function useVipPackages() {
  return useQuery({
    queryKey: [VIP_PACKAGES_KEY],
    queryFn: () => fetchAllPages((page) => AdminVipService.listPackages(page)),
  })
}

export function useVipPackageOrder(packages: VipPackage[]) {
  return useListOrder({
    items: packages,
    queryKey: [VIP_PACKAGES_KEY],
    orderKey: 'sortOrder',
    reorder: AdminVipService.reorderPackages,
    nameOf: (pkg) => pkg.name,
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
