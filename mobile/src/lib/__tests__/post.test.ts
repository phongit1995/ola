import { EDIT_WINDOW_MS } from '@ola/shared/constants';
import { isPostEditExpired } from '../post';

describe('isPostEditExpired', () => {
  const now = Date.parse('2026-07-30T12:00:00.000Z');

  it('keeps posts inside the edit window editable', () => {
    const createdAt = new Date(now - EDIT_WINDOW_MS + 1).toISOString();
    expect(isPostEditExpired(createdAt, now)).toBe(false);
  });

  it('expires posts outside the edit window', () => {
    const createdAt = new Date(now - EDIT_WINDOW_MS - 1).toISOString();
    expect(isPostEditExpired(createdAt, now)).toBe(true);
  });

  it('treats missing or invalid timestamps as expired', () => {
    expect(isPostEditExpired(undefined, now)).toBe(true);
    expect(isPostEditExpired('not-a-date', now)).toBe(true);
  });
});
