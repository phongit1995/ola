import { useQuery } from '@tanstack/react-query'
import { AdminReportService } from '@/services/adminReport.service'

export const REPORT_SUMMARY_KEY = 'admin-report-summary'

const REPORT_SUMMARY_REFETCH_MS = 60_000

export function useReportSummary() {
  return useQuery({
    queryKey: [REPORT_SUMMARY_KEY],
    queryFn: () => AdminReportService.summary(),
    refetchInterval: REPORT_SUMMARY_REFETCH_MS,
  })
}
