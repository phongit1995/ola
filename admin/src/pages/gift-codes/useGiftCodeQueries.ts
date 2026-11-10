import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminGiftCodeService } from '@/services/adminGiftCode.service'
import type {
  GiftCodeAttemptParams,
  GiftCodeCampaignListParams,
  GiftCodeCampaignRequest,
  GiftCodeListParams,
  GiftCodeRedemptionListParams,
} from '@/types'
import { GIFT_CODE_QUERY_KEY } from './constants'

export function useGiftCodeCampaigns(params: GiftCodeCampaignListParams) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'list', params],
    queryFn: () => AdminGiftCodeService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useGiftCodeCampaign(id: string | undefined) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'detail', id],
    queryFn: () => AdminGiftCodeService.get(id ?? ''),
    enabled: id != null && id !== '',
  })
}

export function useGiftCodes(id: string, params: GiftCodeListParams) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'codes', id, params],
    queryFn: () => AdminGiftCodeService.listCodes(id, params),
    placeholderData: (prev) => prev,
  })
}

export function useGiftCodeRedemptions(id: string, params: GiftCodeRedemptionListParams) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'redemptions', id, params],
    queryFn: () => AdminGiftCodeService.listRedemptions(id, params),
    placeholderData: (prev) => prev,
  })
}

export function useGiftCodeAttemptSummary(params: GiftCodeAttemptParams) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'attempt-summary', params],
    queryFn: () => AdminGiftCodeService.attemptSummary(params),
    placeholderData: (prev) => prev,
  })
}

export function useGiftCodeAttemptUsers(params: GiftCodeAttemptParams, enabled: boolean) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'attempt-users', params],
    queryFn: () => AdminGiftCodeService.attemptUsers(params),
    placeholderData: (prev) => prev,
    enabled,
  })
}

export function useGiftCodeAttemptDevices(params: GiftCodeAttemptParams, enabled: boolean) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'attempt-devices', params],
    queryFn: () => AdminGiftCodeService.attemptDevices(params),
    placeholderData: (prev) => prev,
    enabled,
  })
}

export function useGiftCodeAttempts(params: GiftCodeAttemptParams, enabled: boolean) {
  return useQuery({
    queryKey: [GIFT_CODE_QUERY_KEY, 'attempts', params],
    queryFn: () => AdminGiftCodeService.attempts(params),
    placeholderData: (prev) => prev,
    enabled,
  })
}

function useInvalidateGiftCodes() {
  const queryClient = useQueryClient()
  return () => queryClient.invalidateQueries({ queryKey: [GIFT_CODE_QUERY_KEY] })
}

export function useExportGiftCodes() {
  return useMutation({
    mutationFn: ({ id, params }: { id: string; params: GiftCodeListParams }) => AdminGiftCodeService.exportCodes(id, params),
  })
}

export function useExportGiftCodeRedemptions() {
  return useMutation({
    mutationFn: ({ id, params }: { id: string; params: GiftCodeRedemptionListParams }) =>
      AdminGiftCodeService.exportRedemptions(id, params),
  })
}

export function useSaveGiftCodeCampaign() {
  const invalidate = useInvalidateGiftCodes()
  return useMutation({
    mutationFn: ({ id, payload }: { id?: string; payload: GiftCodeCampaignRequest }) =>
      id ? AdminGiftCodeService.update(id, payload) : AdminGiftCodeService.create(payload),
    onSuccess: () => void invalidate(),
  })
}

export function useSetGiftCodeEnabled() {
  const invalidate = useInvalidateGiftCodes()
  return useMutation({
    mutationFn: ({ id, enabled }: { id: string; enabled: boolean }) => AdminGiftCodeService.setEnabled(id, enabled),
    onSuccess: () => void invalidate(),
  })
}

export function useGenerateGiftCodes() {
  const invalidate = useInvalidateGiftCodes()
  return useMutation({
    mutationFn: ({ id, count }: { id: string; count: number }) => AdminGiftCodeService.generateCodes(id, count),
    onSuccess: () => void invalidate(),
  })
}

export function useSetGiftCodeLock() {
  const invalidate = useInvalidateGiftCodes()
  return useMutation({
    mutationFn: ({ id, codeId, locked, reason }: { id: string; codeId: string; locked: boolean; reason: string }) =>
      AdminGiftCodeService.setCodeLock(id, codeId, locked, reason),
    onSuccess: () => void invalidate(),
  })
}
