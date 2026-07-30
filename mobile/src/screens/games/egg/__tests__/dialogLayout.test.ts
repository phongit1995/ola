import { eggGiftScrollHeight, eggHistoryScrollHeight } from '../dialogLayout';

describe('egg dialog scroll height', () => {
  it.each([320, 480, 568, 844])('keeps scroll regions inside a %ipx viewport', (windowHeight) => {
    expect(eggHistoryScrollHeight(windowHeight) + 180).toBeLessThanOrEqual(windowHeight);
    expect(eggGiftScrollHeight(windowHeight) + 114).toBeLessThanOrEqual(windowHeight);
  });

  it('caps scroll regions on tall devices', () => {
    expect(eggHistoryScrollHeight(844)).toBe(380);
    expect(eggGiftScrollHeight(844)).toBe(500);
  });
});
