import type { FarmAction, ActionResult } from './ActionTypes';

export type SaveExport = 'current' | 'source' | 'backup' | 'pending' | 'legacy' | 'legacy-backup';

export type AudioKind = 'sound' | 'music';

export type SessionEvents = {
  /** A message for the player; views decide how to show it. */
  toast: [string];
  /** An action was applied and persisted. */
  committed: [FarmAction, ActionResult];
  /** The whole farm was swapped (import, restart, retried save). */
  replaced: [];
  /** Persisting failed; the session is paused until a retry or import succeeds. */
  saveFailed: [];
  /** Pause state changed. */
  paused: [boolean];
};

export interface Dispatch {
  ok: boolean;
  result: ActionResult;
}
