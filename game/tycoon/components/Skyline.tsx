import { memo, type ReactElement } from 'react';

type Roof = 'flat' | 'gable' | 'terrace' | 'awning';

interface House {
  x: number;
  w: number;
  h: number;
  color: string;
  roof: Roof;
}

const GROUND = 86;
const NAVY = '#1F2A44';

const TOWERS: Array<{ x: number; w: number; h: number }> = [
  { x: 12, w: 30, h: 76 },
  { x: 108, w: 26, h: 84 },
  { x: 186, w: 34, h: 72 },
  { x: 262, w: 28, h: 80 },
];

const HOUSES: House[] = [
  { x: 0, w: 26, h: 44, color: '#F4A6A0', roof: 'flat' },
  { x: 26, w: 22, h: 58, color: '#FFD97A', roof: 'gable' },
  { x: 48, w: 28, h: 40, color: '#9FD3E8', roof: 'terrace' },
  { x: 76, w: 20, h: 64, color: '#F2B5CF', roof: 'flat' },
  { x: 96, w: 30, h: 48, color: '#A8D8B9', roof: 'awning' },
  { x: 126, w: 24, h: 36, color: '#F7C08A', roof: 'gable' },
  { x: 150, w: 22, h: 60, color: '#C7B8F0', roof: 'flat' },
  { x: 172, w: 28, h: 46, color: '#FFD97A', roof: 'terrace' },
  { x: 200, w: 22, h: 56, color: '#F4A6A0', roof: 'gable' },
  { x: 222, w: 30, h: 40, color: '#9DB4E8', roof: 'awning' },
  { x: 252, w: 24, h: 60, color: '#A8D8B9', roof: 'flat' },
  { x: 276, w: 22, h: 44, color: '#F2B5CF', roof: 'gable' },
  { x: 298, w: 22, h: 52, color: '#F7C08A', roof: 'flat' },
];

function houseShapes(house: House, index: number, night: boolean): ReactElement[] {
  const top = GROUND - house.h;
  const out: ReactElement[] = [];
  const key = (part: string) => `${index}-${part}`;
  if (house.roof === 'gable') {
    out.push(
      <path
        key={key('roof')}
        d={`M${house.x - 1.5} ${top + 0.5}L${house.x + house.w / 2} ${top - 8}L${house.x + house.w + 1.5} ${top + 0.5}Z`}
        fill="#D2694F"
        stroke={NAVY}
        strokeWidth="1.2"
        strokeLinejoin="round"
      />,
    );
  }
  out.push(<rect key={key('wall')} x={house.x} y={top} width={house.w} height={house.h} fill={house.color} stroke={NAVY} strokeWidth="1.2" />);
  if (house.roof === 'flat') {
    out.push(<rect key={key('cap')} x={house.x - 1} y={top - 2.5} width={house.w + 2} height={3} fill={house.color} stroke={NAVY} strokeWidth="1.2" />);
  }
  if (house.roof === 'terrace') {
    for (let i = 0; i < 3; i++) {
      out.push(<circle key={key(`plant-${i}`)} cx={house.x + 5 + i * ((house.w - 10) / 2)} cy={top - 2.5} r={3} fill="#3BA776" stroke={NAVY} strokeWidth="1" />);
    }
  }
  const floors = Math.floor((house.h - 16) / 12);
  for (let f = 0; f < floors; f++) {
    const y = top + 6 + f * 12;
    const lit = night && (index + f) % 3 !== 0;
    out.push(
      <rect
        key={key(`win-${f}`)}
        x={house.x + 4}
        y={y}
        width={house.w - 8}
        height={6}
        rx={1}
        fill={night ? (lit ? '#FFD34D' : '#3C5070') : '#FFF8EA'}
        stroke={NAVY}
        strokeWidth="0.9"
      />,
    );
    out.push(<line key={key(`rail-${f}`)} x1={house.x + 2} y1={y + 8.5} x2={house.x + house.w - 2} y2={y + 8.5} stroke={NAVY} strokeWidth="1.1" strokeLinecap="round" />);
  }
  if (house.roof === 'awning') {
    out.push(<rect key={key('awning')} x={house.x + 1} y={GROUND - 15} width={house.w - 2} height={4} fill="#E4573D" stroke={NAVY} strokeWidth="1" />);
  }
  out.push(<rect key={key('door')} x={house.x + house.w / 2 - 3.5} y={GROUND - 10} width={7} height={10} rx={1} fill={night ? '#FFD34D' : NAVY} opacity={night ? 0.9 : 0.85} />);
  return out;
}

export const Skyline = memo(function Skyline({ night = false, className }: { night?: boolean; className?: string }) {
  return (
    <svg className={className} viewBox="0 0 320 92" preserveAspectRatio="xMidYMax slice" aria-hidden="true" focusable="false">
      {TOWERS.map((t, i) => (
        <g key={`tower-${i}`}>
          <rect x={t.x} y={GROUND - t.h} width={t.w} height={t.h} rx={2} fill={night ? '#2C3E55' : '#E9DCBC'} stroke={night ? '#3C5070' : '#D8C59C'} strokeWidth="1" />
          {Array.from({ length: Math.floor(t.h / 9) }, (_, row) => (
            <rect
              key={row}
              x={t.x + 5}
              y={GROUND - t.h + 5 + row * 9}
              width={t.w - 10}
              height={3}
              rx={1}
              fill={night ? ((row + i) % 2 ? '#FFD34D' : '#3C5070') : '#D8C59C'}
              opacity={night ? 0.55 : 0.7}
            />
          ))}
        </g>
      ))}
      {HOUSES.map((house, i) => houseShapes(house, i, night))}
      {[44, 148, 250].map((x) => (
        <g key={`tree-${x}`}>
          <rect x={x + 2.2} y={GROUND - 9} width={1.6} height={9} fill={NAVY} />
          <circle cx={x + 3} cy={GROUND - 12} r={5} fill="#3BA776" stroke={NAVY} strokeWidth="1" />
        </g>
      ))}
      <rect x="0" y={GROUND} width="320" height="6" fill={NAVY} />
      <g stroke={night ? '#FFD34D' : '#FFF8EA'} strokeWidth="1.2" strokeDasharray="7 7" opacity="0.8">
        <line x1="0" y1={GROUND + 3} x2="320" y2={GROUND + 3} />
      </g>
    </svg>
  );
});
