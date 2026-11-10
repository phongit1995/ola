export interface AdminAuditLog {
  id: string
  adminId: string
  adminUsername?: string
  adminFullName?: string
  method: string
  resource: string
  path: string
  route?: string
  status: number
  ip?: string
  detail?: Record<string, unknown>
  createdAt: string
}

export interface AuditLogListParams {
  adminId?: string
  resource?: string
  method?: string
  route?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}
