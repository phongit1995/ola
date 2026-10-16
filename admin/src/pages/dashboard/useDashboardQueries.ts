import { useQuery } from '@tanstack/react-query'
import { AdminDashboardService } from '@/services/adminDashboard.service'
import type { DashboardOverviewParams } from '@/types'

const DASHBOARD_KEY = 'admin-dashboard'

export function useDashboardOverview(params: DashboardOverviewParams) {
  return useQuery({
    queryKey: [DASHBOARD_KEY, params],
    queryFn: () => AdminDashboardService.getOverview(params),
    placeholderData: (prev) => prev,
  })
}
