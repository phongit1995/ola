export interface PresenceInfo {
  isOnline: boolean;
  lastActiveAt?: string;
}

export interface PresenceState {
  presence: Map<string, PresenceInfo>;
  listIntervalId: ReturnType<typeof setInterval> | null;
  focusIntervalId: ReturnType<typeof setInterval> | null;
  fetch: (userIds: string[]) => Promise<void>;
  startListPolling: (getUserIds: () => string[]) => void;
  stopListPolling: () => void;
  startFocusPolling: (userId: string) => void;
  stopFocusPolling: () => void;
  reset: () => void;
}
