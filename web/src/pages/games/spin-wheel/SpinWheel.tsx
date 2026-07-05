import type { CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import {
  SEGMENT_ANGLE,
  SPIN_DURATION_MS,
  SPIN_SEGMENTS,
} from './spinWheel.constants';
import { spinRewardText } from './spinWheelText';
import { pointerUrl, wheelCenterUrl, wheelUrl } from './spinWheelAssets';

const LABEL_RADIUS = 33;

function labelStyle(index: number): CSSProperties {
  const angle = index * SEGMENT_ANGLE;
  const radians = ((angle - 90) * Math.PI) / 180;
  const left = 50 + LABEL_RADIUS * Math.cos(radians);
  const top = 50 + LABEL_RADIUS * Math.sin(radians);
  return {
    left: `${left}%`,
    top: `${top}%`,
    transform: `translate(-50%, -50%) rotate(${angle}deg)`,
  };
}

interface SpinWheelProps {
  rotation: number;
  spinning: boolean;
  onSettle: () => void;
}

export function SpinWheel({ rotation, spinning, onSettle }: SpinWheelProps) {
  const { t } = useTranslation();

  return (
    <div className="relative" style={{ width: 'min(84vw, 360px)', aspectRatio: '1 / 1' }}>
      <img
        src={pointerUrl}
        alt=""
        className="absolute left-1/2 top-[-5%] z-20 w-[13%] -translate-x-1/2 drop-shadow-md"
      />
      <div
        className="absolute inset-0"
        style={{
          transform: `rotate(${rotation}deg)`,
          transition: spinning
            ? `transform ${SPIN_DURATION_MS}ms cubic-bezier(0.16, 0.72, 0.12, 1)`
            : 'none',
        }}
        onTransitionEnd={(event) => {
          if (event.propertyName === 'transform') onSettle();
        }}
      >
        <img src={wheelUrl} alt="" className="absolute inset-0 h-full w-full" />
        {SPIN_SEGMENTS.map((segment, index) => (
          <div
            key={segment.id}
            className="absolute w-[26%] text-center leading-tight"
            style={labelStyle(index)}
          >
            <span className="block text-[12px] font-extrabold text-white [text-shadow:0_1px_2px_rgba(0,0,0,0.55)]">
              {spinRewardText(t, segment)}
            </span>
          </div>
        ))}
      </div>
      <img
        src={wheelCenterUrl}
        alt=""
        className="absolute left-1/2 top-1/2 z-10 w-[26%] -translate-x-1/2 -translate-y-1/2"
      />
    </div>
  );
}
