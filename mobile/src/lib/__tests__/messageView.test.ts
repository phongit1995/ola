import {
  isCopyableMessageText,
  messageReplyExcerpt,
  type ReplyExcerptLabels,
} from '../messageView';

const labels: ReplyExcerptLabels = {
  image: 'Image',
  audio: 'Audio',
  sticker: 'Sticker',
};

describe('messageView', () => {
  it('allows copying regular text, including room text without an explicit type', () => {
    expect(isCopyableMessageText({ type: 'text', content: 'Hello' })).toBe(
      true,
    );
    expect(isCopyableMessageText({ content: 'Hello' })).toBe(true);
  });

  it('rejects empty, media, and sticker messages for copying', () => {
    expect(isCopyableMessageText({ type: 'text', content: '   ' })).toBe(false);
    expect(isCopyableMessageText({ type: 'image', content: '' })).toBe(false);
    expect(isCopyableMessageText({ type: 'text', content: '[kul:1]' })).toBe(
      false,
    );
  });

  it('builds reply excerpts for media, stickers, and text', () => {
    expect(messageReplyExcerpt({ type: 'image', content: '' }, labels)).toBe(
      'Image',
    );
    expect(messageReplyExcerpt({ type: 'audio', content: '' }, labels)).toBe(
      'Audio',
    );
    expect(
      messageReplyExcerpt({ type: 'text', content: '[kul:1]' }, labels),
    ).toBe('Sticker');
    expect(
      messageReplyExcerpt({ type: 'text', content: 'Hello' }, labels),
    ).toBe('Hello');
  });
});
