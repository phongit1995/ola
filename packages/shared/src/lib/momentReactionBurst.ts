import type { ReactionType } from '../types/api/chat.type';
import type { MomentReactionBurst, MomentReactionSpark } from '../types/client/moment.type';

const EMOJI_SPARKS = 10;
const GLITTER_SPARKS = 10;
const REACH_BASE = 400;
const GLITTER_COLORS = ['#ffffff', '#fff3b0', '#ffd166', '#ff9eb5', '#9be7ff'] as const;

let nextBurstId = 0;

function randomBetween(min: number, max: number) {
  return min + Math.random() * (max - min);
}

function glitterColor(): string {
  const index = Math.floor(Math.random() * GLITTER_COLORS.length);
  return GLITTER_COLORS[index] ?? GLITTER_COLORS[0];
}

function sparkRing(
  count: number,
  minDistance: number,
  maxDistance: number,
  look: () => Pick<MomentReactionSpark, 'size' | 'color'>
): MomentReactionSpark[] {
  return Array.from({ length: count }, (_, index) => {
    const angle = (index / count) * Math.PI * 2 + randomBetween(-0.25, 0.25);
    const distance = randomBetween(minDistance, maxDistance);
    return {
      x: Math.round(Math.cos(angle) * distance),
      y: Math.round(Math.sin(angle) * distance),
      rotate: Math.round(randomBetween(-70, 70)),
      ...look(),
    };
  });
}

export function createMomentReactionBurst(
  type: ReactionType,
  stage: { width: number; height: number },
  origin: { x: number; y: number }
): MomentReactionBurst {
  nextBurstId += 1;
  const reach = Math.min(stage.width, stage.height) / REACH_BASE;
  return {
    id: nextBurstId,
    type,
    fromX: origin.x,
    fromY: origin.y,
    toX: stage.width * randomBetween(0.38, 0.62),
    toY: stage.height * randomBetween(0.36, 0.48),
    sparks: [
      ...sparkRing(EMOJI_SPARKS, 70 * reach, 130 * reach, () => ({
        size: Math.round(randomBetween(18, 30)),
        color: null,
      })),
      ...sparkRing(GLITTER_SPARKS, 95 * reach, 165 * reach, () => ({
        size: Math.round(randomBetween(4, 7)),
        color: glitterColor(),
      })),
    ],
  };
}
