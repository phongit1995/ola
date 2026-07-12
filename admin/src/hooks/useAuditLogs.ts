import { useQuery } from '@tanstack/react-query'
import { AdminAuditService } from '@/services/adminAudit.service'
import type { AuditLogListParams } from '@/types'

const AUDIT_KEY = 'admin-audit'

export function useAuditLogs(params: AuditLogListParams) {
  return useQuery({
    queryKey: [AUDIT_KEY, params],
    queryFn: () => AdminAuditService.list(params),
    placeholderData: (prev) => prev,
  })
}
