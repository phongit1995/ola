import { type CSSProperties } from 'react';
import { formatKen } from '@lib';
import { penAssets } from './penAssets';

interface BurstBall {
  dx: number;
  dy: number;
  peak: number;
  rot: number;
  delay: number;
}

const BURST: BurstBall[] = [
  { dx: -150, dy: 70, peak: -150, rot: -540, delay: 0 },
  { dx: 150, dy: 70, peak: -150, rot: 540, delay: 0 },
  { dx: -95, dy: 95, peak: -195, rot: -430, delay: 50 },
  { dx: 95, dy: 95, peak: -195, rot: 430, delay: 50 },
  { dx: -45, dy: 108, peak: -220, rot: -360, delay: 90 },
  { dx: 45, dy: 108, peak: -220, rot: 360, delay: 90 },
  { dx: 0, dy: 80, peak: -245, rot: 300, delay: 70 },
  { dx: -120, dy: 40, peak: -120, rot: -620, delay: 110 },
  { dx: 120, dy: 40, peak: -120, rot: 620, delay: 110 },
];

export function PenWinBurst({ amount }: { amount: number }) {
  return (
    <div className="pointer-events-none absolute inset-0 z-30 overflow-hidden">
      <div className="absolute left-1/2 top-[52%]">
        {BURST.map((ball, i) => (
          <img
            key={i}
            src={penAssets.ball}
            alt=""
            className="pen-burst-ball absolute h-9 w-9 object-contain"
            style={
              {
                animationDelay: `${ball.delay}ms`,
                '--dx': `${ball.dx}px`,
                '--dy': `${ball.dy}px`,
                '--peak': `${ball.peak}px`,
                '--rot': `${ball.rot}deg`,
              } as CSSProperties
            }
          />
        ))}
      </div>

      <span className="pen-reward-float absolute left-1/2 top-[40%] flex items-center gap-1.5 whitespace-nowrap text-4xl font-extrabold italic text-[#46e06a] drop-shadow-[0_3px_8px_rgba(0,0,0,0.7)]">
        +{formatKen(amount)}
        <img
          src={penAssets.kenIcon}
          alt=""
          className="h-8 w-8 object-contain"
        />
      </span>
    </div>
  );
}
