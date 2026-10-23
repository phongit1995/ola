import { describe, expect, it } from 'vitest';
import { MAX_BOTS, addBot, botLevelLabel, botName, createBot, removeBot, setBotLevel, type BotSetupItem } from './bot';

const one: BotSetupItem[] = [createBot([], 'a')];

describe('bot setup list', () => {
  it('starts a new bot at normal level with the first free VIP', () => {
    expect(one).toEqual([{ id: 'a', vip: 1, level: 'normal' }]);
    expect(addBot(one, 'b').at(-1)).toEqual({ id: 'b', vip: 2, level: 'normal' });
  });

  it('stops at three bots', () => {
    const full = addBot(addBot(one, 'b'), 'c');
    expect(full).toHaveLength(MAX_BOTS);
    expect(addBot(full, 'd')).toEqual(full);
  });

  it('never removes the last bot', () => {
    expect(removeBot(one, 'a')).toEqual(one);
  });

  it('removes one bot and keeps the others with their level and VIP', () => {
    const full = setBotLevel(setBotLevel(addBot(addBot(one, 'b'), 'c'), 'b', 'easy'), 'c', 'hard');
    const left = removeBot(full, 'b');
    expect(left).toEqual([
      { id: 'a', vip: 1, level: 'normal' },
      { id: 'c', vip: 3, level: 'hard' },
    ]);
    expect(addBot(left, 'd').at(-1)).toEqual({ id: 'd', vip: 2, level: 'normal' });
  });

  it('labels bots by position and level in Vietnamese', () => {
    expect(botName(0)).toBe('Bot 1');
    expect(botName(2)).toBe('Bot 3');
    expect(botLevelLabel('easy')).toBe('Dễ');
    expect(botLevelLabel('hard')).toBe('Khó');
  });
});
