import type { KenChestAutoJob, KenChestAutoJobRequest } from '@/types'

export function jobToRequest(job: KenChestAutoJob): KenChestAutoJobRequest {
  return {
    name: job.name,
    enabled: job.enabled,
    scheduleType: job.scheduleType,
    intervalMinMinutes: job.intervalMinMinutes,
    intervalMaxMinutes: job.intervalMaxMinutes,
    dailyTimes: job.dailyTimes,
    rewardMode: job.rewardMode,
    kenAmount: job.kenAmount,
    kenMin: job.kenMin,
    kenMax: job.kenMax,
    maxRecipients: job.maxRecipients,
    durationSeconds: job.durationSeconds,
    remainingRuns: job.remainingRuns,
  }
}

export function rewardText(job: KenChestAutoJob): string {
  if (job.rewardMode === 'fixed') {
    return `${(job.kenAmount ?? 0).toLocaleString('vi-VN')} KEN`
  }
  return `${(job.kenMin ?? 0).toLocaleString('vi-VN')} – ${(job.kenMax ?? 0).toLocaleString('vi-VN')} KEN`
}

export function scheduleText(job: KenChestAutoJob): string {
  if (job.scheduleType === 'interval') {
    const min = job.intervalMinMinutes ?? 0
    const max = job.intervalMaxMinutes ?? 0
    return min === max ? `Mỗi ${min} phút` : `Mỗi ${min}–${max} phút`
  }
  return `Giờ: ${(job.dailyTimes ?? []).join(', ')}`
}
