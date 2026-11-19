import { keepPreviousData, useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminMegaphoneService } from '@/services/adminMegaphone.service'
import type { GrantMegaphoneTicketsRequest, MegaphoneListParams, RemoveMegaphoneRequest } from '@/types'

const MEGAPHONES_KEY = 'admin-megaphones'
const USER_TICKETS_KEY = 'admin-user-megaphone-tickets'

export function useMegaphones(params: MegaphoneListParams) {
  return useQuery({
    queryKey: [MEGAPHONES_KEY, params],
    queryFn: () => AdminMegaphoneService.list(params),
    placeholderData: keepPreviousData,
  })
}

export function useRemoveMegaphone() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: RemoveMegaphoneRequest }) =>
      AdminMegaphoneService.remove(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [MEGAPHONES_KEY] })
    },
  })
}

export function useUserMegaphoneTickets(userId: string | null) {
  return useQuery({
    queryKey: [USER_TICKETS_KEY, userId],
    queryFn: () => AdminMegaphoneService.userTickets(userId!),
    enabled: userId != null,
  })
}

export function useGrantMegaphoneTickets(userId: string | null) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: GrantMegaphoneTicketsRequest) => AdminMegaphoneService.grantUserTickets(userId!, payload),
    onSuccess: (data) => {
      queryClient.setQueryData([USER_TICKETS_KEY, userId], data)
    },
  })
}

export function useRevokeMegaphoneTicket(userId: string | null) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (ticketId: string) => AdminMegaphoneService.revokeUserTicket(userId!, ticketId),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [USER_TICKETS_KEY, userId] })
    },
  })
}

export function useCheckContent() {
  return useMutation({
    mutationFn: (text: string) => AdminMegaphoneService.checkContent(text),
  })
}
