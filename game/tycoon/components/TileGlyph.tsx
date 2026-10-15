import type { TileKind } from '../logic/constants';

export type GlyphName =
  | 'go'
  | 'chest'
  | 'chance'
  | 'tax'
  | 'train'
  | 'plane'
  | 'ship'
  | 'bus'
  | 'electric'
  | 'water'
  | 'jail'
  | 'parking'
  | 'gotojail';

const GLYPH_PATHS: Record<GlyphName, string> = {
  go: 'M16 5a11 11 0 1 0 11 11h-4a7 7 0 1 1-7-7v4l7-6-7-6z',
  chest: 'M5 13a4 4 0 0 1 4-4h14a4 4 0 0 1 4 4v2H5zM5 17h22v8a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2zm9 1v4h4v-4z',
  chance: 'M16 4a7 7 0 0 0-7 7h4a3 3 0 1 1 4.6 2.5C15.4 14.9 14 16.5 14 19h4c0-1.2.8-2 2.2-3A7 7 0 0 0 16 4zm-2 18h4v4h-4z',
  tax: 'M8 4h12l6 6v18H8zm11 1v6h6zM11 15h10v2H11zm0 5h10v2H11z',
  train: 'M9 6h14a3 3 0 0 1 3 3v12a3 3 0 0 1-3 3h-1l2 3h-3l-2-3h-6l-2 3H8l2-3H9a3 3 0 0 1-3-3V9a3 3 0 0 1 3-3zm1 4v6h12v-6zm1 9a2 2 0 1 0 0 .1zm10 0a2 2 0 1 0 0 .1z',
  plane: 'M15 3h2l1 9 9 5v3l-9-2v5l3 2v2l-5-1-5 1v-2l3-2v-5l-9 2v-3l9-5z',
  ship: 'M6 20l2 7h16l2-7zM9 19V9h6V5h2v4h6v10zm2-2h12V11H11z',
  bus: 'M8 5h16a3 3 0 0 1 3 3v15a2 2 0 0 1-2 2h-1a2 2 0 1 1-4 0h-8a2 2 0 1 1-4 0H7a2 2 0 0 1-2-2V8a3 3 0 0 1 3-3zm0 5v7h16v-7z',
  electric: 'M18 3L7 18h7l-2 11 11-15h-7z',
  water: 'M16 3c5 7 9 11 9 17a9 9 0 0 1-18 0c0-6 4-10 9-17zm-4 17a4 4 0 0 0 4 4v-2a2 2 0 0 1-2-2z',
  jail: 'M5 5h22v3H5zm0 19h22v3H5zM9 8h3v16H9zm5.5 0h3v16h-3zM20 8h3v16h-3z',
  parking: 'M5 19l3-7a3 3 0 0 1 3-2h10a3 3 0 0 1 3 2l3 7v6h-3a2 2 0 1 1-4 0h-8a2 2 0 1 1-4 0H5zm5-7l-2 5h16l-2-5z',
  gotojail: 'M16 4a9 9 0 0 1 9 9v8H7v-8a9 9 0 0 1 9-9zm0 3a6 6 0 0 0-6 6v5h12v-5a6 6 0 0 0-6-6zM5 23h22v4H5z',
};

export const GLYPH_BY_KIND: Partial<Record<TileKind, GlyphName>> = {
  go: 'go',
  chest: 'chest',
  chance: 'chance',
  tax: 'tax',
  utility: 'electric',
  jail: 'jail',
  parking: 'parking',
  gotojail: 'gotojail',
};

const STATION_GLYPH: Record<number, GlyphName> = { 5: 'train', 15: 'plane', 25: 'ship', 35: 'bus' };

export function glyphForTile(idx: number, kind: TileKind): GlyphName | null {
  if (kind === 'station') return STATION_GLYPH[idx] ?? 'train';
  if (kind === 'utility') return idx === 28 ? 'water' : 'electric';
  return GLYPH_BY_KIND[kind] ?? null;
}

export const GLYPH_COLOR: Record<GlyphName, string> = {
  go: 'var(--ty-navy)',
  chest: 'var(--ty-sky-deep)',
  chance: 'var(--ty-gold-deep)',
  tax: 'var(--ty-coral)',
  train: 'var(--ty-navy)',
  plane: 'var(--ty-navy)',
  ship: 'var(--ty-navy)',
  bus: 'var(--ty-navy)',
  electric: 'var(--ty-jade)',
  water: 'var(--ty-jade)',
  jail: 'var(--ty-navy)',
  parking: 'var(--ty-navy)',
  gotojail: 'var(--ty-coral)',
};

export function TileGlyph({ name, size = 18, color }: { name: GlyphName; size?: number; color?: string }) {
  return (
    <svg viewBox="0 0 32 32" width={size} height={size} aria-hidden="true" focusable="false" className="ty-tile-glyph">
      <path d={GLYPH_PATHS[name]} fill={color ?? GLYPH_COLOR[name]} />
    </svg>
  );
}
