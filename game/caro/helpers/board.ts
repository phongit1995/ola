import { SIZE, findWinLine, type CaroState, type WinLine } from '../types';

export function findFinalWinLine(state: CaroState): WinLine | null {
  const { board, lastX, lastY } = state;
  if (lastX < 0 || lastX >= SIZE || lastY < 0 || lastY >= SIZE) return null;
  const mark = board[lastY * SIZE + lastX];
  return mark ? findWinLine(board, lastX, lastY, mark) : null;
}
