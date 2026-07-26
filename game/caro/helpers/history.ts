import type { MatchHistoryEntry, MatchHistoryOutcome } from '../../src/sdk';

const BOT_HISTORY_LIMIT = 50;
const HISTORY_LIMIT = 100;
const STORAGE_PREFIX = 'ola:caro:bot-history:v1:';

function storageKey(userID: string): string {
  return `${STORAGE_PREFIX}${userID}`;
}

function isOutcome(value: unknown): value is MatchHistoryOutcome {
  return value === 'win' || value === 'lose' || value === 'draw';
}

function isHistoryEntry(value: unknown): value is MatchHistoryEntry {
  if (value == null || typeof value !== 'object') return false;
  const entry = value as Partial<MatchHistoryEntry>;
  return (
    typeof entry.id === 'string' &&
    entry.id.length > 0 &&
    typeof entry.playedAt === 'number' &&
    Number.isFinite(entry.playedAt) &&
    entry.opponentId === 'bot' &&
    typeof entry.opponentName === 'string' &&
    entry.opponentName.length > 0 &&
    entry.opponentName.length <= 80 &&
    entry.bet === 0 &&
    isOutcome(entry.outcome)
  );
}

export function readBotHistory(userID: string): MatchHistoryEntry[] {
  if (!userID || typeof window === 'undefined') return [];
  try {
    const parsed: unknown = JSON.parse(window.localStorage.getItem(storageKey(userID)) ?? '[]');
    if (!Array.isArray(parsed)) return [];
    return parsed.filter(isHistoryEntry).slice(0, BOT_HISTORY_LIMIT);
  } catch {
    return [];
  }
}

export function mergeMatchHistory(...groups: ReadonlyArray<readonly MatchHistoryEntry[]>): MatchHistoryEntry[] {
  const byID = new Map<string, MatchHistoryEntry>();
  groups.flat().forEach((entry) => {
    if (!byID.has(entry.id)) byID.set(entry.id, entry);
  });
  return [...byID.values()]
    .sort((a, b) => b.playedAt - a.playedAt || b.id.localeCompare(a.id))
    .slice(0, HISTORY_LIMIT);
}

export function saveBotHistory(userID: string, entry: MatchHistoryEntry): MatchHistoryEntry[] {
  const entries = mergeMatchHistory([entry], readBotHistory(userID)).slice(0, BOT_HISTORY_LIMIT);
  if (!userID || typeof window === 'undefined') return entries;
  try {
    window.localStorage.setItem(storageKey(userID), JSON.stringify(entries));
  } catch {
    // Keep the in-memory entry even when browser storage is unavailable.
  }
  return entries;
}
