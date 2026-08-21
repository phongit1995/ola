import { memo } from 'react';

const CELL = 40;
const MARGIN = 20;
const W = 360;
const H = 400;
const LAST_ROW = 9;

function px(x: number): number {
  return MARGIN + x * CELL;
}

// Trục y của server đi từ nhà Đỏ (y=0) lên nhà Đen (y=9), còn SVG vẽ xuống, nên
// phải đảo: y=0 nằm ở ĐÁY. Nhờ vậy Đỏ không lật là đã thấy quân mình ở dưới, Đen
// lật flipIndex là đủ (spec 05 §1 "mình luôn ở dưới").
function py(y: number): number {
  return MARGIN + (LAST_ROW - y) * CELL;
}

const STAR_POINTS: Array<[number, number]> = [
  [1, 2], [7, 2], [1, 7], [7, 7],
  [0, 3], [2, 3], [4, 3], [6, 3], [8, 3],
  [0, 6], [2, 6], [4, 6], [6, 6], [8, 6],
];

function StarMark({ x, y }: { x: number; y: number }) {
  const cx = px(x);
  const cy = py(y);
  const g = 4;
  const len = 7;
  const arms: string[] = [];
  if (x > 0) {
    arms.push(`M${cx - g} ${cy - g} h-${len} M${cx - g} ${cy - g} v-${len}`);
    arms.push(`M${cx - g} ${cy + g} h-${len} M${cx - g} ${cy + g} v${len}`);
  }
  if (x < 8) {
    arms.push(`M${cx + g} ${cy - g} h${len} M${cx + g} ${cy - g} v-${len}`);
    arms.push(`M${cx + g} ${cy + g} h${len} M${cx + g} ${cy + g} v${len}`);
  }
  return <path d={arms.join(' ')} className="xq-board-mark" />;
}

export const BoardSurface = memo(function BoardSurface() {
  const verticals = [];
  for (let x = 0; x < 9; x++) {
    if (x === 0 || x === 8) {
      verticals.push(<line key={`v${x}`} x1={px(x)} y1={py(0)} x2={px(x)} y2={py(9)} />);
    } else {
      verticals.push(<line key={`v${x}a`} x1={px(x)} y1={py(0)} x2={px(x)} y2={py(4)} />);
      verticals.push(<line key={`v${x}b`} x1={px(x)} y1={py(5)} x2={px(x)} y2={py(9)} />);
    }
  }
  const horizontals = [];
  for (let y = 0; y < 10; y++) {
    horizontals.push(<line key={`h${y}`} x1={px(0)} y1={py(y)} x2={px(8)} y2={py(y)} />);
  }
  return (
    <svg className="xq-board-svg" viewBox={`0 0 ${W} ${H}`} aria-hidden="true">
      <defs>
        <pattern id="xq-paper-fiber" width="18" height="18" patternUnits="userSpaceOnUse">
          <path d="M1 5h5M11 14h4M7 9h2" className="xq-board-fiber" />
        </pattern>
      </defs>
      <rect x={2} y={2} width={W - 4} height={H - 4} rx={12} className="xq-board-wood" />
      <rect x={7} y={7} width={W - 14} height={H - 14} rx={8} className="xq-board-paper" />
      <rect x={7} y={7} width={W - 14} height={H - 14} rx={8} fill="url(#xq-paper-fiber)" />
      <g className="xq-board-lines">
        {verticals}
        {horizontals}
        <rect x={px(0) - 5} y={py(0) - 5} width={8 * CELL + 10} height={9 * CELL + 10} rx={4} className="xq-board-frame" />
        <line x1={px(3)} y1={py(0)} x2={px(5)} y2={py(2)} />
        <line x1={px(5)} y1={py(0)} x2={px(3)} y2={py(2)} />
        <line x1={px(3)} y1={py(7)} x2={px(5)} y2={py(9)} />
        <line x1={px(5)} y1={py(7)} x2={px(3)} y2={py(9)} />
      </g>
      <g>
        {STAR_POINTS.map(([x, y]) => (
          <StarMark key={`${x}-${y}`} x={x} y={y} />
        ))}
      </g>
      <g className="xq-board-river">
        <text x={px(1.6)} y={py(4.5) + 8}>楚 河</text>
        <text x={px(5.4)} y={py(4.5) + 8}>漢 界</text>
      </g>
    </svg>
  );
});

export function squareLeft(x: number): string {
  return `${(px(x) / W) * 100}%`;
}

export function squareTop(y: number): string {
  return `${(py(y) / H) * 100}%`;
}
