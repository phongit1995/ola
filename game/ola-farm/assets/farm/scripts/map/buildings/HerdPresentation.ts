import { HERD_DISPLAY_SCALE } from '../generated/BuildingPresentationData';

/** Yard art and placement geometry share the scale generated from the field-width target. */
export function herdDisplayScale(species: string | undefined): number {
  return species === 'layer' || species === 'dairy-cow' || species === 'pig' || species === 'sheep'
    ? HERD_DISPLAY_SCALE
    : 1;
}

/** Leave more room around residents in the larger yard while keeping them easy to see. */
export function herdResidentScale(species: string | undefined): number {
  return species === 'layer' || species === 'dairy-cow' || species === 'pig' || species === 'sheep' ? 3 : 1;
}

/** Tap and hold use the same rectangle as the enlarged yard presentation. */
export function herdHitBox(species: string | undefined): { y: number; w: number; h: number } {
  const scale = herdDisplayScale(species);
  // Imported yards are 190 wide, grounded at -30, with their highest roof at 110.
  return scale === 1 ? { y: 10, w: 170, h: 130 } : { y: 40 * scale, w: 190 * scale, h: 140 * scale };
}
