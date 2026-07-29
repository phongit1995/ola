import type { WheelPlayerSegment } from '@app-types';
import { segmentTheme } from './spinWheel.constants';
import {
  CENTER,
  SLICE_RADIUS,
  VIEWBOX,
  dividerLine,
  slicePath,
} from './wheelGeometry';

interface WheelFaceProps {
  segments: WheelPlayerSegment[];
  angle: number;
}

export function WheelFace({ segments, angle }: WheelFaceProps) {
  return (
    <svg
      viewBox={`0 0 ${VIEWBOX} ${VIEWBOX}`}
      className="absolute inset-0 h-full w-full"
    >
      <defs>
        {segments.map((segment, index) => {
          const theme = segmentTheme(index);
          return (
            <radialGradient
              key={segment.id}
              id={`wheel-grad-${index}`}
              cx={CENTER}
              cy={CENTER}
              r={SLICE_RADIUS}
              gradientUnits="userSpaceOnUse"
            >
              <stop offset="0.15" stopColor={theme.dark} />
              <stop offset="1" stopColor={theme.light} />
            </radialGradient>
          );
        })}
        <radialGradient
          id="wheel-shade"
          cx={CENTER}
          cy={CENTER}
          r={SLICE_RADIUS}
          gradientUnits="userSpaceOnUse"
        >
          <stop offset="0" stopColor="#000000" stopOpacity="0.32" />
          <stop offset="0.24" stopColor="#000000" stopOpacity="0" />
          <stop offset="0.8" stopColor="#7a3a00" stopOpacity="0" />
          <stop offset="1" stopColor="#7a3a00" stopOpacity="0.36" />
        </radialGradient>
        <linearGradient id="wheel-gloss" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#ffffff" stopOpacity="0.18" />
          <stop offset="0.42" stopColor="#ffffff" stopOpacity="0" />
        </linearGradient>
      </defs>
      {segments.map((segment, index) => (
        <path
          key={segment.id}
          d={slicePath(index, angle)}
          fill={`url(#wheel-grad-${index})`}
        />
      ))}
      <circle
        cx={CENTER}
        cy={CENTER}
        r={SLICE_RADIUS}
        fill="url(#wheel-shade)"
      />
      <circle
        cx={CENTER}
        cy={CENTER}
        r={SLICE_RADIUS}
        fill="url(#wheel-gloss)"
      />
      {segments.map((segment, index) => {
        const line = dividerLine(index, angle);
        return (
          <line
            key={segment.id}
            x1={line.x1}
            y1={line.y1}
            x2={line.x2}
            y2={line.y2}
            stroke="#ffe878"
            strokeWidth={1.8}
            strokeOpacity={0.35}
            strokeLinecap="round"
          />
        );
      })}
      {segments.map((segment, index) => {
        const line = dividerLine(index, angle);
        return (
          <line
            key={segment.id}
            x1={line.x1}
            y1={line.y1}
            x2={line.x2}
            y2={line.y2}
            stroke="#fff7c8"
            strokeWidth={0.6}
            strokeOpacity={0.9}
            strokeLinecap="round"
          />
        );
      })}
    </svg>
  );
}
