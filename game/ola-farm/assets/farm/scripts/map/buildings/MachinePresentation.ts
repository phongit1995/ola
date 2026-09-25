import { MACHINE_PRESENTATION } from '../generated/BuildingPresentationData';
import type { MapBounds } from '../../render/types/MapTypes';

/** Art, placement and camera share geometry generated from the complete source prefab. */
export function machinePresentation(prefab: string) {
  const value = MACHINE_PRESENTATION[prefab as keyof typeof MACHINE_PRESENTATION];
  if (!value) throw Error('Thiếu hình học xưởng Farm Town: ' + prefab);
  return value;
}

export function machineDisplayScale(prefab: string): number {
  return machinePresentation(prefab).scale;
}

/** Generated bounds already include the 784-unit display scale and source pivot. */
export function machineArtBounds(prefab: string, position: { x: number; y: number }): MapBounds {
  const b = machinePresentation(prefab).bounds;
  return {
    left: position.x + b.left,
    right: position.x + b.right,
    bottom: position.y + b.bottom,
    top: position.y + b.top,
  };
}
