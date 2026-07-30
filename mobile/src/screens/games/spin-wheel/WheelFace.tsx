import Svg, {
  Circle,
  Defs,
  Line,
  LinearGradient,
  Path,
  RadialGradient,
  Stop,
} from 'react-native-svg';
import {
  WHEEL_CENTER,
  WHEEL_SLICE_RADIUS,
  WHEEL_VIEWBOX,
  segmentTheme,
  wheelDividerLine,
  wheelSlicePath,
} from '@ola/shared/lib';
import type { WheelLayerProps } from './types';

export function WheelFace({ segments, angle, size }: WheelLayerProps) {
  return (
    <Svg
      width={size}
      height={size}
      viewBox={`0 0 ${WHEEL_VIEWBOX} ${WHEEL_VIEWBOX}`}
      style={{ position: 'absolute', left: 0, top: 0 }}
    >
      <Defs>
        {segments.map((segment, index) => {
          const theme = segmentTheme(index);
          return (
            <RadialGradient
              key={segment.id}
              id={`wheel-grad-${index}`}
              cx={WHEEL_CENTER}
              cy={WHEEL_CENTER}
              r={WHEEL_SLICE_RADIUS}
              gradientUnits="userSpaceOnUse"
            >
              <Stop offset="0.15" stopColor={theme.dark} />
              <Stop offset="1" stopColor={theme.light} />
            </RadialGradient>
          );
        })}
        <RadialGradient
          id="wheel-shade"
          cx={WHEEL_CENTER}
          cy={WHEEL_CENTER}
          r={WHEEL_SLICE_RADIUS}
          gradientUnits="userSpaceOnUse"
        >
          <Stop offset="0" stopColor="#000000" stopOpacity="0.32" />
          <Stop offset="0.24" stopColor="#000000" stopOpacity="0" />
          <Stop offset="0.8" stopColor="#7a3a00" stopOpacity="0" />
          <Stop offset="1" stopColor="#7a3a00" stopOpacity="0.36" />
        </RadialGradient>
        <LinearGradient id="wheel-gloss" x1="0" y1="0" x2="0" y2="1">
          <Stop offset="0" stopColor="#ffffff" stopOpacity="0.18" />
          <Stop offset="0.42" stopColor="#ffffff" stopOpacity="0" />
        </LinearGradient>
      </Defs>
      {segments.map((segment, index) => (
        <Path key={segment.id} d={wheelSlicePath(index, angle)} fill={`url(#wheel-grad-${index})`} />
      ))}
      <Circle cx={WHEEL_CENTER} cy={WHEEL_CENTER} r={WHEEL_SLICE_RADIUS} fill="url(#wheel-shade)" />
      <Circle cx={WHEEL_CENTER} cy={WHEEL_CENTER} r={WHEEL_SLICE_RADIUS} fill="url(#wheel-gloss)" />
      {segments.map((segment, index) => {
        const line = wheelDividerLine(index, angle);
        return (
          <Line
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
        const line = wheelDividerLine(index, angle);
        return (
          <Line
            key={`inner-${segment.id}`}
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
    </Svg>
  );
}
