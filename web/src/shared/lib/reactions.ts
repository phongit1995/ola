import type { ReactionType } from '@app-types';
import { smileyImageForCode } from './chatSmiley';

export const REACTION_ORDER: ReactionType[] = [
  'LIKE',
  'LOVE',
  'HAHA',
  'WOW',
  'SAD',
  'ANGRY',
];

const REACTION_SMILEY_CODES = ['(y)', '<3', ':-))', ':-O', ':-(', ':-<'];

export const REACTION_IMAGES: string[] = REACTION_SMILEY_CODES.map(
  (code) => smileyImageForCode(code) ?? ''
);

export const REACTION_IMAGE: Record<ReactionType, string> = Object.fromEntries(
  REACTION_ORDER.map((type, index) => [type, REACTION_IMAGES[index] ?? ''])
) as Record<ReactionType, string>;

export interface ReactionChip {
  type: string;
  image: string;
  count: number;
}

export function reactionChips(
  reactions?: Record<string, readonly unknown[]>
): ReactionChip[] {
  if (reactions == null) return [];
  return Object.entries(reactions)
    .filter(([, users]) => users.length > 0)
    .map(([type, users]) => ({
      type,
      image: REACTION_IMAGE[type as ReactionType] ?? '',
      count: users.length,
    }));
}
