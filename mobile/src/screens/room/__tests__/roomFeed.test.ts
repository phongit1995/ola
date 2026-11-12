import { buildRoomFeed } from '@ola/shared/lib';
import type { RoomMessage } from '@ola/shared/types';

function msg(id: string, senderId: string, minute: number): RoomMessage {
  return {
    id,
    senderId,
    senderName: senderId,
    content: id,
    type: 'text',
    createdAt: new Date(Date.UTC(2026, 10, 12, 3, minute)).toISOString(),
  } as RoomMessage;
}

function lastKeys(messages: RoomMessage[], hasMore: boolean): string[] {
  return buildRoomFeed(messages, 'me', { omitLeadingDate: hasMore }).map(item =>
    item.kind === 'group' ? item.messages[item.messages.length - 1]!.key : item.key,
  );
}

describe('buildRoomFeed khi nạp thêm tin cũ', () => {
  const page = [msg('m10', 'a', 10), msg('m11', 'a', 11), msg('m12', 'b', 12)];
  const older = [msg('m8', 'b', 8), msg('m9', 'a', 9)];

  it('bỏ vạch ngày đầu list khi còn tin cũ hơn', () => {
    const feed = buildRoomFeed(page, 'me', { omitLeadingDate: true });
    expect(feed[0]?.kind).toBe('group');
    expect(buildRoomFeed(page, 'me')[0]?.kind).toBe('date');
  });

  it('nhóm trên cùng gộp thêm tin cũ cùng người gửi vẫn giữ key theo tin cuối', () => {
    const before = lastKeys(page, true);
    const after = lastKeys([...older, ...page], true);
    expect(before).toEqual(['m11', 'm12']);
    expect(after.slice(-2)).toEqual(before);
  });

  it('hết tin cũ thì vạch ngày chèn lên đầu, không đổi key các mục bên dưới', () => {
    const after = lastKeys([...older, ...page], false);
    expect(after[0]).toMatch(/^date-/);
    expect(after.slice(-2)).toEqual(['m11', 'm12']);
  });
});
