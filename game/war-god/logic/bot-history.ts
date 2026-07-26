const STORAGE_KEY = 'wg-bot-history';
const MAX_ENTRIES = 50;

export type BotHistoryOutcome = 'win' | 'lose';

export interface BotHistoryEntry {
  playedAt: number;
  level: string;
  outcome: BotHistoryOutcome;
}

function isEntry(value: unknown): value is BotHistoryEntry {
  if (value == null || typeof value !== 'object') return false;
  const entry = value as Partial<BotHistoryEntry>;
  return (
    typeof entry.playedAt === 'number' &&
    Number.isFinite(entry.playedAt) &&
    typeof entry.level === 'string' &&
    (entry.outcome === 'win' || entry.outcome === 'lose')
  );
}

export function readBotHistory(): BotHistoryEntry[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return [];
    const parsed: unknown = JSON.parse(raw);
    if (!Array.isArray(parsed)) return [];
    return parsed.filter(isEntry).slice(0, MAX_ENTRIES);
  } catch {
    return [];
  }
}

export function recordBotMatch(entry: { level: string; won: boolean; forfeit?: boolean }): void {
  try {
    const items = readBotHistory();
    items.unshift({
      playedAt: Date.now(),
      level: entry.level,
      outcome: entry.won ? 'win' : 'lose',
    });
    localStorage.setItem(STORAGE_KEY, JSON.stringify(items.slice(0, MAX_ENTRIES)));
  } catch {
    return;
  }
}
