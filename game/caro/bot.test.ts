import { describe, expect, it } from 'vitest';
import { pickBotMove } from './botBrain';
import { SIZE, emptyState } from './types';

const PLAYER = 1;
const BOT = 2;

function boardWith(cells: ReadonlyArray<readonly [number, number, number]>): number[] {
  const board = emptyState().board;
  for (const [x, y, mark] of cells) board[y * SIZE + x] = mark;
  return board;
}

describe('pickBotMove expert', () => {
  it('chọn nước tạo hai đường thắng độc lập (thắng cưỡng bức)', () => {
    const board = boardWith([
      [7, 10, BOT],
      [8, 10, BOT],
      [9, 10, BOT],
      [10, 7, BOT],
      [10, 8, BOT],
      [10, 9, BOT],
      [2, 3, BOT],
      [6, 10, PLAYER],
      [10, 6, PLAYER],
      [3, 3, PLAYER],
      [4, 3, PLAYER],
      [5, 3, PLAYER],
    ]);
    const move = pickBotMove(board, 'expert');
    expect(move).toMatchObject({ x: 10, y: 10 });
  });

  it('thắng ngay khi có năm quân', () => {
    const board = boardWith([
      [5, 5, BOT],
      [6, 5, BOT],
      [7, 5, BOT],
      [8, 5, BOT],
      [4, 6, PLAYER],
      [5, 6, PLAYER],
      [6, 6, PLAYER],
      [4, 5, PLAYER],
    ]);
    const move = pickBotMove(board, 'expert');
    expect(move).toMatchObject({ x: 9, y: 5 });
  });

  it('chặn ba mở của người chơi khi không có đòn tấn công tốt hơn', () => {
    const board = boardWith([
      [3, 3, PLAYER],
      [4, 3, PLAYER],
      [5, 3, PLAYER],
      [12, 12, BOT],
      [13, 14, BOT],
    ]);
    const move = pickBotMove(board, 'expert');
    expect([
      { x: 2, y: 3 },
      { x: 6, y: 3 },
    ]).toContainEqual({ x: move?.x, y: move?.y });
  });

  it('không đổi nội dung bàn cờ sau khi suy nghĩ', () => {
    const cells = [
      [3, 3, PLAYER],
      [4, 3, PLAYER],
      [5, 3, PLAYER],
      [12, 12, BOT],
      [13, 14, BOT],
    ] as const;
    const board = boardWith(cells);
    pickBotMove(board, 'expert');
    expect(board).toEqual(boardWith(cells));
  });
});
