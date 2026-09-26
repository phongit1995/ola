/** What one queue slot shows: a batch waiting in the tray, the running job, a queued job, or nothing. */
export interface QueueSlotJob {
  image: string;
  /** Countdown, duration or "Nhận". */
  label: string;
  tone: 'ready' | 'running' | 'queued';
  /** A queued job's cancel button; the running job and ready batches cannot be cancelled. */
  cancel?: { id: string; action: () => void; enabled: boolean };
}
