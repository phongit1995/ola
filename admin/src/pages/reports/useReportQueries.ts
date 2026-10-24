import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminReportService } from '@/services/adminReport.service'
import { AdminMeService } from '@/services/adminMe.service'
import { AdminReelService } from '@/services/adminReel.service'
import { AdminStoryService } from '@/services/adminStory.service'
import { AdminRoomService } from '@/services/adminRoom.service'
import { AdminUserService } from '@/services/adminUser.service'
import { REPORT_SUMMARY_KEY } from '@/hooks/useReportSummary'
import { REELS_QUERY_KEY } from '@/pages/reels/useReelQueries'
import { toApiError } from '@/lib/apiError'
import type { AdminReport, ReportListParams, UpdateReportStatusRequest } from '@/types'

const REPORTS_KEY = 'admin-reports'
const HTTP_NOT_FOUND = 404

export interface ReportHandling {
  report: AdminReport
  status: UpdateReportStatusRequest['status']
  note: string
  removeContent?: boolean
  lockUser?: boolean
}

export function useReports(params: ReportListParams) {
  return useQuery({
    queryKey: [REPORTS_KEY, params],
    queryFn: () => AdminReportService.list(params),
    placeholderData: (prev) => prev,
  })
}

async function removeReportedContent(report: AdminReport): Promise<void> {
  const { targetType, targetId, contextId } = report
  try {
    if (targetType === 'post') {
      await AdminMeService.setStatus(targetId, false)
    } else if (targetType === 'reel') {
      await AdminReelService.setStatus(targetId, false)
    } else if (targetType === 'comment' && contextId) {
      await AdminMeService.removeComment(contextId, targetId)
    } else if (targetType === 'story_comment' && contextId) {
      await AdminStoryService.removeComment(contextId, targetId)
    } else if (targetType === 'room_message' && contextId) {
      await AdminRoomService.deleteMessage(contextId, targetId)
    }
  } catch (err) {
    if (toApiError(err).status !== HTTP_NOT_FOUND) throw err
  }
}

export function useHandleReport() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: async ({ report, status, note, removeContent, lockUser }: ReportHandling) => {
      if (removeContent) await removeReportedContent(report)
      if (lockUser && report.reportedUser) {
        await AdminUserService.updateStatus(report.reportedUser.id, false)
      }
      return AdminReportService.updateStatus(report.id, { status, note: note.trim() || undefined })
    },
    onSettled: () => {
      void queryClient.invalidateQueries({ queryKey: [REPORTS_KEY] })
      void queryClient.invalidateQueries({ queryKey: [REPORT_SUMMARY_KEY] })
      void queryClient.invalidateQueries({ queryKey: ['admin-users'] })
      void queryClient.invalidateQueries({ queryKey: [REELS_QUERY_KEY] })
    },
  })
}
