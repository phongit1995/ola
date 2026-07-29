import { useRef } from 'react';
import type { WheelPlayerSegment } from '@app-types';
import { SPIN_DURATION_MS, segmentAngle } from './spinWheel.constants';
import {
  pointerUrl,
  wheelCenterUrl,
  wheelLogoUrl,
  wheelOuterRingUrl,
} from './spinWheelAssets';
import { usePointerTick } from './usePointerTick';
import { WheelFace } from './WheelFace';
import { WheelLabels } from './WheelLabels';

interface SpinWheelProps {
  segments: WheelPlayerSegment[];
  rotation: number;
  spinning: boolean;
  onSettle: () => void;
}

export function SpinWheel({
  segments,
  rotation,
  spinning,
  onSettle,
}: SpinWheelProps) {
  const angle = segmentAngle(segments.length);
  const wheelRef = useRef<HTMLDivElement>(null);
  const pointerRef = useRef<HTMLImageElement>(null);

  usePointerTick(wheelRef, pointerRef, spinning, angle);

  return (
    <div
      className="relative"
      style={{ width: 'min(84vw, 360px)', aspectRatio: '1 / 1' }}
    >
      <img
        ref={pointerRef}
        src={pointerUrl}
        alt=""
        className="absolute left-1/2 top-[-5%] z-20 w-[13%] -translate-x-1/2 origin-[50%_36%] drop-shadow-md"
      />
      <div
        ref={wheelRef}
        className="absolute inset-0"
        style={{
          transform: `rotate(${rotation}deg)`,
          willChange: 'transform',
          transition: spinning
            ? `transform ${SPIN_DURATION_MS}ms cubic-bezier(0.16, 0.72, 0.12, 1)`
            : 'none',
        }}
        onTransitionEnd={(event) => {
          if (event.propertyName === 'transform') onSettle();
        }}
      >
        <WheelFace segments={segments} angle={angle} />
        <WheelLabels segments={segments} angle={angle} />
        <img
          src={wheelOuterRingUrl}
          alt=""
          className="absolute inset-0 h-full w-full"
        />
      </div>
      <div
        className="absolute left-1/2 top-1/2 z-10 flex aspect-square w-[26%] -translate-x-1/2 -translate-y-1/2 items-center justify-center bg-contain bg-center bg-no-repeat"
        style={{ backgroundImage: `url(${wheelCenterUrl})` }}
      >
        <img src={wheelLogoUrl} alt="" className="w-[68%]" />
      </div>
    </div>
  );
}
