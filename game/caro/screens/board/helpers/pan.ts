import { SIZE } from '../../../types';
import type { BoardPan } from '../useBoard';

export interface PanBounds {
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
}

export function clampPan(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), Math.max(min, max));
}

export function panBounds(
  clip: Pick<DOMRect, 'width' | 'height'>,
  board: Pick<DOMRect, 'width' | 'height'>,
): PanBounds {
  const slackX = clip.width - board.width;
  const slackY = clip.height - board.height;
  return {
    minX: slackX >= 0 ? slackX / 2 : slackX,
    maxX: slackX >= 0 ? slackX / 2 : 0,
    minY: slackY >= 0 ? slackY / 2 : slackY,
    maxY: slackY >= 0 ? slackY / 2 : 0,
  };
}

export function clampPanPoint(point: BoardPan, bounds: PanBounds): BoardPan {
  return {
    x: clampPan(point.x, bounds.minX, bounds.maxX),
    y: clampPan(point.y, bounds.minY, bounds.maxY),
  };
}

export function centerPan(bounds: PanBounds): BoardPan {
  return {
    x: (bounds.minX + bounds.maxX) / 2,
    y: (bounds.minY + bounds.maxY) / 2,
  };
}

export function revealCell(
  current: BoardPan,
  index: number,
  clip: Pick<DOMRect, 'width' | 'height'>,
  board: Pick<DOMRect, 'width' | 'height'>,
  bounds: PanBounds,
): BoardPan {
  const cellWidth = board.width / SIZE;
  const cellHeight = board.height / SIZE;
  const x = index % SIZE;
  const y = Math.floor(index / SIZE);
  const marginX = cellWidth * 0.6;
  const marginY = cellHeight * 0.6;
  const left = current.x + x * cellWidth;
  const right = left + cellWidth;
  const top = current.y + y * cellHeight;
  const bottom = top + cellHeight;
  let nextX = current.x;
  let nextY = current.y;

  if (left < marginX) nextX += marginX - left;
  else if (right > clip.width - marginX) nextX -= right - (clip.width - marginX);
  if (top < marginY) nextY += marginY - top;
  else if (bottom > clip.height - marginY) nextY -= bottom - (clip.height - marginY);

  return clampPanPoint({ x: nextX, y: nextY }, bounds);
}
