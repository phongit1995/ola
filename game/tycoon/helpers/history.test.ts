import { afterEach, describe, expect, it, vi } from 'vitest';
import { newGame } from '../logic/engine';
import {
  botHistoryEntry,
  entryKen,
  formatKenDelta,
  historyReason,
  historyTitle,
  mergeHistory,
  readBotHistory,
  saveBotHistory,
  summarize,
  type HistoryEntry,
} from './history';

const entry = (over: Partial<HistoryEntry>): HistoryEntry => ({
  id: 'm-1',
  playedAt: 1,
  source: 'online',
  place: 1,
  playerCount: 4,
  endReason: 'groups',
  exitReason: null,
  bet: 500,
  kenDelta: 1400,
  players: [],
  ...over,
});

const me = { id: 'u-me', username: 'me', vipType: '3' };
const bots = [
  { id: 'bot-1', vip: 1, level: 'normal' as const },
  { id: 'bot-2', vip: 2, level: 'hard' as const },
];

function memoryStorage() {
  const data = new Map<string, string>();
  return {
    getItem: (key: string) => data.get(key) ?? null,
    setItem: (key: string, value: string) => void data.set(key, value),
  };
}

afterEach(() => {
  vi.unstubAllGlobals();
});

describe('history helpers', () => {
  it('titles exit before place', () => {
    expect(historyTitle(entry({}))).toBe('Tỷ phú số 1');
    expect(historyTitle(entry({ place: 2 }))).toBe('Hạng 2');
    expect(historyTitle(entry({ place: 4 }))).toBe('Hạng cuối');
    expect(historyTitle(entry({ place: 4, exitReason: 'bankrupt' }))).toBe('Phá sản');
    expect(historyTitle(entry({ place: 3, exitReason: 'timeout' }))).toBe('Bỏ cuộc');
  });

  it('describes the end reason with player count', () => {
    expect(historyReason(entry({}))).toBe('Thắng ngay · 3 nhóm màu · 4 người');
    expect(historyReason(entry({ endReason: 'rounds', playerCount: 3 }))).toBe('Hết 30 vòng · 3 người');
    expect(historyReason(entry({ endReason: null, playerCount: 2 }))).toBe('2 người');
  });

  it('formats KEN with sign and a dash for no-stake games', () => {
    expect(formatKenDelta(1400, 500)).toBe('+1.400');
    expect(formatKenDelta(-500, 500)).toBe('−500');
    expect(formatKenDelta(0, 0)).toBe('—');
  });

  it('labels no-stake online games apart from bot games', () => {
    expect(entryKen(entry({ bet: 0, kenDelta: 0 }))).toEqual({ text: 'Giao lưu', tone: 'free' });
    expect(entryKen(entry({ source: 'bot', bet: 0, kenDelta: 0 }))).toEqual({ text: '—', tone: 'none' });
    expect(entryKen(entry({ kenDelta: -500 }))).toEqual({ text: '−500', tone: 'minus' });
  });

  it('summarizes online KEN only and counts bot wins', () => {
    const list = [entry({}), entry({ id: 'bot-1', source: 'bot', bet: 0, kenDelta: 0 }), entry({ id: 'm-2', place: 2, kenDelta: -500 }), entry({ id: 'm-3', place: 4, bet: 200, kenDelta: -200 })];
    expect(summarize(list)).toEqual({ played: 4, firstPlaces: 2, ken: 700 });
  });

  it('merges newest first without duplicates', () => {
    const merged = mergeHistory([entry({ id: 'a', playedAt: 1 })], [entry({ id: 'b', playedAt: 3 }), entry({ id: 'a', playedAt: 1 })]);
    expect(merged.map((item) => item.id)).toEqual(['b', 'a']);
  });

  it('builds a bot entry from the final state', () => {
    const state = newGame(7, 3);
    state.players[2].bankrupt = true;
    state.endReason = 'last';
    const result = botHistoryEntry(state, [0, 1, 2], 0, me, bots, 1000);
    expect(result).toMatchObject({ id: 'bot-1000', source: 'bot', place: 1, playerCount: 3, endReason: 'last', exitReason: null, bet: 0 });
    expect(result.players.map((player) => [player.username, player.place, player.exitReason, player.level])).toEqual([
      ['me', 1, null, undefined],
      ['Bot 1', 2, null, 'normal'],
      ['Bot 2', 3, 'bankrupt', 'hard'],
    ]);
  });

  it('marks a forfeit as the player exit reason', () => {
    const state = newGame(7, 2);
    state.players[0].quit = true;
    state.players[0].bankrupt = true;
    const result = botHistoryEntry(state, [1, 0], 0, me, bots, 2000);
    expect(result).toMatchObject({ place: 2, exitReason: 'forfeit' });
  });

  it('saves and reads bot history, ignoring broken data', () => {
    const localStorage = memoryStorage();
    vi.stubGlobal('window', { localStorage });
    const state = newGame(7, 2);
    saveBotHistory(me.id, botHistoryEntry(state, [0, 1], 0, me, bots, 1000));
    saveBotHistory(me.id, botHistoryEntry(state, [1, 0], 0, me, bots, 2000));
    expect(readBotHistory(me.id).map((item) => item.id)).toEqual(['bot-2000', 'bot-1000']);
    localStorage.setItem('ola:tycoon:bot-history:v1:u-me', '[{"id":"x"}]');
    expect(readBotHistory(me.id)).toEqual([]);
    localStorage.setItem('ola:tycoon:bot-history:v1:u-me', '{broken');
    expect(readBotHistory(me.id)).toEqual([]);
  });
});
