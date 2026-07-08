import { useEffect, useRef, type CSSProperties } from 'react';
import { VipIcon } from '@components';
import type { WheelPlayerSegment } from '@app-types';
import {
  SPIN_DURATION_MS,
  segmentAngle,
  segmentTheme,
  type SegmentTheme,
} from './spinWheel.constants';
import { pointerUrl, wheelCenterUrl, wheelOuterRingUrl } from './spinWheelAssets';
import { isVipItemKind, rewardKindIcon } from './spinWheelReward';

const VIEWBOX = 100;
const CENTER = VIEWBOX / 2;
const SLICE_RADIUS = 48;
const LABEL_RADIUS = 31;
const DIVIDER_INNER_RADIUS = 12;
const POINTER_MAX_TICK_DEG = 15;

function wheelAngleFromTransform(transform: string): number {
  if (!transform || transform === 'none') return 0;
  const open = transform.indexOf('(');
  const close = transform.indexOf(')');
  if (open < 0 || close < 0) return 0;
  const parts = transform.slice(open + 1, close).split(',');
  const a = Number(parts[0]);
  const b = Number(parts[1]);
  if (Number.isNaN(a) || Number.isNaN(b)) return 0;
  return (Math.atan2(b, a) * 180) / Math.PI;
}

function pointerTickDeg(wheelAngle: number, angle: number): number {
  if (angle <= 0) return 0;
  const phase = (((wheelAngle - angle / 2) % angle) + angle) % angle;
  const t = phase / angle;
  return -POINTER_MAX_TICK_DEG * t * t;
}

function polar(angleDeg: number, radius: number) {
  const radians = ((angleDeg - 90) * Math.PI) / 180;
  return {
    x: CENTER + radius * Math.cos(radians),
    y: CENTER + radius * Math.sin(radians),
  };
}

function slicePath(index: number, angle: number): string {
  const half = angle / 2;
  const start = polar(index * angle - half, SLICE_RADIUS);
  const end = polar(index * angle + half, SLICE_RADIUS);
  return `M ${CENTER} ${CENTER} L ${start.x} ${start.y} A ${SLICE_RADIUS} ${SLICE_RADIUS} 0 0 1 ${end.x} ${end.y} Z`;
}

function dividerLine(index: number, angle: number) {
  const boundary = index * angle - angle / 2;
  const inner = polar(boundary, DIVIDER_INNER_RADIUS);
  const outer = polar(boundary, SLICE_RADIUS);
  return { x1: inner.x, y1: inner.y, x2: outer.x, y2: outer.y };
}

function labelStyle(index: number, angle: number): CSSProperties {
  const point = polar(index * angle, LABEL_RADIUS);
  return {
    left: `${point.x}%`,
    top: `${point.y}%`,
    transform: 'translate(-50%, -50%)',
  };
}

function textStyle(theme: SegmentTheme): CSSProperties {
  return {
    color: '#fff7e8',
    WebkitTextStroke: `2px ${theme.stroke}`,
    paintOrder: 'stroke fill',
    textShadow: `0 2px 0 ${theme.shadow}, 0 3px 3px rgba(0,0,0,0.3)`,
  };
}

interface RewardVisual {
  icon: string | null;
  vipTypeId: number | null;
  iconClass: string;
}

function rewardIconClass(kind: WheelPlayerSegment['kind']): string {
  if (kind === 'ken_fixed') return 'w-[44%]';
  if (kind === 'ken_random') return 'w-[54%]';
  if (kind === 'vip_random') return 'w-[60%]';
  if (kind === 'miss') return 'w-[52%]';
  return 'w-[58%]';
}

function rewardVisual(segment: WheelPlayerSegment): RewardVisual {
  if (isVipItemKind(segment.kind) && typeof segment.vipTypeId === 'number') {
    return { icon: null, vipTypeId: segment.vipTypeId, iconClass: '' };
  }
  return { icon: rewardKindIcon(segment.kind), vipTypeId: null, iconClass: rewardIconClass(segment.kind) };
}

interface SpinWheelProps {
  segments: WheelPlayerSegment[];
  rotation: number;
  spinning: boolean;
  onSettle: () => void;
}

export function SpinWheel({ segments, rotation, spinning, onSettle }: SpinWheelProps) {
  const count = segments.length;
  const angle = segmentAngle(count);
  const wheelRef = useRef<HTMLDivElement>(null);
  const pointerRef = useRef<HTMLImageElement>(null);

  useEffect(() => {
    const pointer = pointerRef.current;
    if (!spinning) {
      if (pointer) pointer.style.rotate = '0deg';
      return;
    }
    let frame = 0;
    const step = () => {
      const wheel = wheelRef.current;
      if (wheel && pointer) {
        const wheelAngle = wheelAngleFromTransform(getComputedStyle(wheel).transform);
        pointer.style.rotate = `${pointerTickDeg(wheelAngle, angle)}deg`;
      }
      frame = requestAnimationFrame(step);
    };
    frame = requestAnimationFrame(step);
    return () => {
      cancelAnimationFrame(frame);
      if (pointer) pointer.style.rotate = '0deg';
    };
  }, [spinning, angle]);

  return (
    <div className="relative" style={{ width: 'min(84vw, 360px)', aspectRatio: '1 / 1' }}>
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
        <svg viewBox={`0 0 ${VIEWBOX} ${VIEWBOX}`} className="absolute inset-0 h-full w-full">
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
            <path key={segment.id} d={slicePath(index, angle)} fill={`url(#wheel-grad-${index})`} />
          ))}
          <circle cx={CENTER} cy={CENTER} r={SLICE_RADIUS} fill="url(#wheel-shade)" />
          <circle cx={CENTER} cy={CENTER} r={SLICE_RADIUS} fill="url(#wheel-gloss)" />
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
        {segments.map((segment, index) => {
          const theme = segmentTheme(index);
          const visual = rewardVisual(segment);
          return (
            <div
              key={segment.id}
              className="absolute flex w-[26%] flex-col items-center leading-[0.9]"
              style={labelStyle(index, angle)}
            >
              {visual.vipTypeId != null ? (
                <VipIcon typeId={visual.vipTypeId} className="h-auto w-[56%] drop-shadow-md" rounded />
              ) : visual.icon != null ? (
                <img src={visual.icon} alt="" className={`${visual.iconClass} drop-shadow-md`} />
              ) : null}
              <span className="mt-0.5 block text-[12px] font-extrabold" style={textStyle(theme)}>
                {segment.label}
              </span>
            </div>
          );
        })}
        <img src={wheelOuterRingUrl} alt="" className="absolute inset-0 h-full w-full" />
      </div>
      <img
        src={wheelCenterUrl}
        alt=""
        className="absolute left-1/2 top-1/2 z-10 w-[26%] -translate-x-1/2 -translate-y-1/2"
      />
    </div>
  );
}
