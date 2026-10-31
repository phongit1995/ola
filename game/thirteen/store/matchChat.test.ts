import { describe, expect, it } from 'vitest';
import { receiveMatchChat } from './matchChat';

const players = [
  { id: 'me', name: 'test1' },
  { id: 'u-2', name: 'hoangminh' },
];
const base = { matchChat: [], chatUnread: 0, chatBubbles: [], chatOpen: false, players, user: { id: 'me' } };
const message = (userId: string, text: string) => ({ matchId: 'm1', userId, name: userId, text, sentAt: 1 });

describe('receiveMatchChat', () => {
  it('counts unread messages from others while the chat is closed', () => {
    expect(receiveMatchChat(base, message('u-2', 'hi'), 1).chatUnread).toBe(1);
    expect(receiveMatchChat(base, message('me', 'hi'), 1).chatUnread).toBe(0);
    expect(receiveMatchChat({ ...base, chatOpen: true }, message('u-2', 'hi'), 1).chatUnread).toBe(0);
  });

  it('shows one bubble per seat, replacing the previous message', () => {
    const first = receiveMatchChat(base, message('u-2', 'một'), 1);
    const second = receiveMatchChat({ ...base, ...first }, message('u-2', 'hai'), 2);
    expect(second.chatBubbles).toEqual([{ seat: 1, text: 'hai', key: 2 }]);
  });

  it('skips the bubble for someone not at the table and caps the history', () => {
    const history = Array.from({ length: 50 }, (_, i) => message('u-2', String(i)));
    const next = receiveMatchChat({ ...base, matchChat: history }, message('ghost', 'x'), 1);
    expect(next.chatBubbles).toEqual([]);
    expect(next.matchChat).toHaveLength(50);
    expect(next.matchChat[49].text).toBe('x');
  });
});
