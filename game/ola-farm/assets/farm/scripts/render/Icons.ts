import { Art } from './Art';

/** Unity storage icons are keyed by the legacy numeric ID; Farm Town items fall back to their own image. */
export function legacyIcon(art: Art, tab: 'raw' | 'goods', legacyId: number | undefined): string | undefined {
  return legacyId === undefined ? undefined : art.data.panels.icons[tab][legacyId];
}

export function seedIcon(art: Art, item: { id: number; key: string; image: string }): string {
  return art.data.ui.icons[`${item.id}.${item.key}`] ?? `assets/sprites/${item.image}.png`;
}
