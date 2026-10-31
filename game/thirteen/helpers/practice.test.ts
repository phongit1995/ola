import { describe, expect, it } from 'vitest';
import { MAX_BOTS, addBot, botLevelLabel, botName, createBot, isBotName, removeBot, setBotLevel } from './practice';

describe('practice bot setup', () => {
  it('adds bots up to the limit with distinct avatars', () => {
    let bots = [createBot([], 'a')];
    bots = addBot(addBot(addBot(bots, 'b'), 'c'), 'd');
    expect(bots).toHaveLength(MAX_BOTS);
    expect(new Set(bots.map((bot) => bot.vipType)).size).toBe(MAX_BOTS);
  });

  it('keeps at least one bot and changes one level at a time', () => {
    const one = [createBot([], 'a')];
    expect(removeBot(one, 'a')).toHaveLength(1);
    const two = setBotLevel(addBot(one, 'b'), 'b', 'hard');
    expect(two.map((bot) => bot.level)).toEqual(['normal', 'hard']);
    expect(removeBot(two, 'a').map((bot) => bot.id)).toEqual(['b']);
  });

  it('names bots so they read without an @ handle', () => {
    expect(botName(0)).toBe('Máy 1');
    expect(isBotName(botName(2))).toBe(true);
    expect(isBotName('hoangminh')).toBe(false);
    expect(botLevelLabel('easy')).toBe('Dễ');
  });
});
