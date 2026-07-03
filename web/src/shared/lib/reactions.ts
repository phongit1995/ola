export const REACTION_EMOJI: Record<string, string> = {
  LIKE: '👍',
  LOVE: '❤️',
  HAHA: '😂',
  WOW: '😮',
  SAD: '😢',
  ANGRY: '😡',
};

export const REACTION_ORDER = ['LIKE', 'LOVE', 'HAHA', 'WOW', 'SAD', 'ANGRY'] as const;

export interface ReactionChip {
  type: string;
  emoji: string;
  count: number;
}

export function reactionChips(reactions?: Record<string, readonly unknown[]>): ReactionChip[] {
  if (reactions == null) return [];
  return Object.entries(reactions)
    .filter(([, users]) => users.length > 0)
    .map(([type, users]) => ({ type, emoji: REACTION_EMOJI[type] ?? '❓', count: users.length }));
}
