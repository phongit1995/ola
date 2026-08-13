import { describe, expect, it } from 'vitest';
import { RecentMatchIds } from './recent-match-ids';

describe('RecentMatchIds', () => {
  it('rejects duplicate results while retaining them', () => {
    const ids = new RecentMatchIds(2);
    expect(ids.mark('match-a')).toBe(true);
    expect(ids.mark('match-a')).toBe(false);
  });

  it('evicts the oldest result at the configured bound', () => {
    const ids = new RecentMatchIds(2);
    ids.mark('match-a');
    ids.mark('match-b');
    ids.mark('match-c');
    expect(ids.size).toBe(2);
    expect(ids.mark('match-a')).toBe(true);
    expect(ids.size).toBe(2);
  });
});
