import type { ImageSourcePropType } from 'react-native';
import type { ReactionType } from '@ola/shared/types';
import { smileyImageForCode } from './chatSmiley';

export const REACTION_ORDER: ReactionType[] = ['LIKE', 'LOVE', 'HAHA', 'WOW', 'SAD', 'ANGRY'];

const REACTION_SMILEY_CODES = ['(y)', '<3', ':-))', ':-O', ':-(', ':-<'];

export const REACTION_IMAGES: Array<ImageSourcePropType | null> = REACTION_SMILEY_CODES.map((code) =>
  smileyImageForCode(code)
);

export const REACTION_IMAGE: Record<ReactionType, ImageSourcePropType | null> = Object.fromEntries(
  REACTION_ORDER.map((type, index) => [type, REACTION_IMAGES[index] ?? null])
) as Record<ReactionType, ImageSourcePropType | null>;

export interface ReactionChip {
  type: string;
  image: ImageSourcePropType | null;
  count: number;
}

const EMPTY_CHIPS: ReactionChip[] = [];
const chipsCache = new WeakMap<object, ReactionChip[]>();

export function reactionChips(reactions?: Record<string, readonly unknown[]>): ReactionChip[] {
  if (reactions == null) return EMPTY_CHIPS;
  const cached = chipsCache.get(reactions);
  if (cached != null) return cached;
  const chips = Object.entries(reactions)
    .filter(([, users]) => users.length > 0)
    .map(([type, users]) => ({
      type,
      image: REACTION_IMAGE[type as ReactionType] ?? null,
      count: users.length,
    }));
  chipsCache.set(reactions, chips);
  return chips;
}
