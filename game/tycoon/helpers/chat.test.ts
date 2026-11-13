import { describe, expect, it } from 'vitest';
import type { ChatMessageData } from '../../src/sdk';
import { chatAuthor, chatKeys } from './chat';

const msg = (over: Partial<ChatMessageData>): ChatMessageData => ({ userId: 'u1', name: 'an', text: 'hi', sentAt: 100, ...over });

describe('chatAuthor', () => {
  it('labels own messages as Bạn', () => {
    expect(chatAuthor(msg({}), 'u1')).toBe('Bạn');
  });

  it('labels others with @name', () => {
    expect(chatAuthor(msg({}), 'u2')).toBe('@an');
    expect(chatAuthor(msg({}), undefined)).toBe('@an');
  });
});

describe('chatKeys', () => {
  it('keeps the plain key for unique messages', () => {
    expect(chatKeys([msg({}), msg({ userId: 'u2' }), msg({ sentAt: 101 })])).toEqual(['u1-100', 'u2-100', 'u1-101']);
  });

  it('disambiguates messages sent by the same user in the same millisecond', () => {
    const keys = chatKeys([msg({ text: 'a' }), msg({ text: 'b' }), msg({ userId: 'u2' }), msg({ text: 'c' })]);
    expect(keys).toEqual(['u1-100', 'u1-100-1', 'u2-100', 'u1-100-2']);
    expect(new Set(keys).size).toBe(keys.length);
  });
});
