import { useEffect, useRef, type CSSProperties } from 'react';
import type { TFunction } from 'i18next';
import { useTranslation } from 'react-i18next';
import { formatKen } from '@lib';
import {
  SEGMENT_ANGLE,
  SPIN_DURATION_MS,
  SPIN_SEGMENTS,
  segmentTheme,
  type SegmentTheme,
  type SpinSegment,
} from './spinWheel.constants';
import {
  pointerUrl,
  rewardMissUrl,
  rewardVipDaysUrl,
  spinCoinUrl,
  wheelCenterUrl,
  wheelLogoUrl,
  wheelOuterRingUrl,
} from './spinWheelAssets';

const VIEWBOX = 100;
const CENTER = VIEWBOX / 2;
const SLICE_RADIUS = 48;
const LABEL_RADIUS = 31;

const POINTER_MAX_TICK_DEG = 11;
const DIVIDER_PHASE_OFFSET = SEGMENT_ANGLE / 2;

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

function pointerTickDeg(wheelAngle: number): number {
  const phase =
    (((wheelAngle - DIVIDER_PHASE_OFFSET) % SEGMENT_ANGLE) + SEGMENT_ANGLE) % SEGMENT_ANGLE;
  const t = phase / SEGMENT_ANGLE;
  return -POINTER_MAX_TICK_DEG * t * t;
}

function polar(angleDeg: number, radius: number) {
  const radians = ((angleDeg - 90) * Math.PI) / 180;
  return {
    x: CENTER + radius * Math.cos(radians),
    y: CENTER + radius * Math.sin(radians),
  };
}

function slicePath(index: number): string {
  const half = SEGMENT_ANGLE / 2;
  const start = polar(index * SEGMENT_ANGLE - half, SLICE_RADIUS);
  const end = polar(index * SEGMENT_ANGLE + half, SLICE_RADIUS);
  return `M ${CENTER} ${CENTER} L ${start.x} ${start.y} A ${SLICE_RADIUS} ${SLICE_RADIUS} 0 0 1 ${end.x} ${end.y} Z`;
}

const DIVIDER_INNER_RADIUS = 12;

function dividerLine(index: number) {
  const angle = index * SEGMENT_ANGLE - SEGMENT_ANGLE / 2;
  const inner = polar(angle, DIVIDER_INNER_RADIUS);
  const outer = polar(angle, SLICE_RADIUS);
  return { x1: inner.x, y1: inner.y, x2: outer.x, y2: outer.y };
}

function labelStyle(index: number): CSSProperties {
  const point = polar(index * SEGMENT_ANGLE, LABEL_RADIUS);
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

interface RewardContent {
  icon: string | null;
  iconClass: string;
  primary: string;
  secondary: string | null;
}

function rewardContent(segment: SpinSegment, t: TFunction): RewardContent {
  if (segment.kind === 'ken') {
    return {
      icon: spinCoinUrl,
      iconClass: 'w-[44%]',
      primary: formatKen(segment.kenAmount ?? 0),
      secondary: 'KEN',
    };
  }
  if (segment.kind === 'vip') {
    return {
      icon: rewardVipDaysUrl,
      iconClass: 'w-[58%]',
      primary: t('wheelGame.vipDaysShort', { n: segment.vipDays ?? 0 }),
      secondary: 'VIP',
    };
  }
  if (segment.kind === 'miss') {
    return { icon: rewardMissUrl, iconClass: 'w-[52%]', primary: t('wheelGame.miss'), secondary: null };
  }
  return { icon: null, iconClass: '', primary: t('wheelGame.doll'), secondary: null };
}

interface SpinWheelProps {
  rotation: number;
  spinning: boolean;
  onSettle: () => void;
}

export function SpinWheel({ rotation, spinning, onSettle }: SpinWheelProps) {
  const { t } = useTranslation();
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
        const angle = wheelAngleFromTransform(getComputedStyle(wheel).transform);
        pointer.style.rotate = `${pointerTickDeg(angle)}deg`;
      }
      frame = requestAnimationFrame(step);
    };
    frame = requestAnimationFrame(step);
    return () => {
      cancelAnimationFrame(frame);
      if (pointer) pointer.style.rotate = '0deg';
    };
  }, [spinning]);

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
            ? `transform ${SPIN_DURATION_MS}ms cubic-bezier(0.3, 0, 0.08, 1)`
            : 'none',
        }}
        onTransitionEnd={(event) => {
          if (event.propertyName === 'transform') onSettle();
        }}
      >
        <svg viewBox={`0 0 ${VIEWBOX} ${VIEWBOX}`} className="absolute inset-0 h-full w-full">
          <defs>
            {SPIN_SEGMENTS.map((segment, index) => {
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
          {SPIN_SEGMENTS.map((segment, index) => (
            <path
              key={segment.id}
              d={slicePath(index)}
              fill={`url(#wheel-grad-${index})`}
            />
          ))}
          <circle cx={CENTER} cy={CENTER} r={SLICE_RADIUS} fill="url(#wheel-shade)" />
          <circle cx={CENTER} cy={CENTER} r={SLICE_RADIUS} fill="url(#wheel-gloss)" />
          {SPIN_SEGMENTS.map((segment, index) => {
            const line = dividerLine(index);
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
          {SPIN_SEGMENTS.map((segment, index) => {
            const line = dividerLine(index);
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
        {SPIN_SEGMENTS.map((segment, index) => {
          const theme = segmentTheme(index);
          const content = rewardContent(segment, t);
          return (
            <div
              key={segment.id}
              className="absolute flex w-[26%] flex-col items-center leading-[0.9]"
              style={labelStyle(index)}
            >
              {content.icon != null && (
                <img src={content.icon} alt="" className={`${content.iconClass} drop-shadow-md`} />
              )}
              <span className="mt-0.5 block text-[13px] font-extrabold" style={textStyle(theme)}>
                {content.primary}
              </span>
              {content.secondary != null && (
                <span className="block text-[10px] font-extrabold" style={textStyle(theme)}>
                  {content.secondary}
                </span>
              )}
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
      <img
        src={wheelLogoUrl}
        alt=""
        className="absolute left-1/2 top-1/2 z-10 w-[17%] -translate-x-1/2 -translate-y-1/2 drop-shadow-md"
      />
    </div>
  );
}
