import type { CSSProperties } from 'react';
import { WHEEL_LABEL_RADIUS, wheelPolar } from '@ola/shared/lib';

export {
  WHEEL_VIEWBOX as VIEWBOX,
  WHEEL_CENTER as CENTER,
  WHEEL_SLICE_RADIUS as SLICE_RADIUS,
  WHEEL_LABEL_RADIUS as LABEL_RADIUS,
  WHEEL_DIVIDER_INNER_RADIUS as DIVIDER_INNER_RADIUS,
  wheelPolar as polar,
  wheelSlicePath as slicePath,
  wheelDividerLine as dividerLine,
} from '@ola/shared/lib';
export type {
  WheelPoint as Point,
  WheelDividerLine as DividerLine,
} from '@ola/shared/types';

export function labelStyle(index: number, angle: number): CSSProperties {
  const point = wheelPolar(index * angle, WHEEL_LABEL_RADIUS);
  return {
    left: `${point.x}%`,
    top: `${point.y}%`,
    transform: 'translate(-50%, -50%)',
  };
}
