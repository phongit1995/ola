import { GAME_REACTION_TYPE, type GameReactionType } from '../../src/sdk';
import { assetSrc, type AssetKey } from '../assets';

export interface CaroReactionOption {
  type: GameReactionType;
  label: string;
  src: string;
}

const REACTION_ASSET: Record<GameReactionType, AssetKey> = {
  [GAME_REACTION_TYPE.Like]: 'reactionLike',
  [GAME_REACTION_TYPE.Love]: 'reactionLove',
  [GAME_REACTION_TYPE.Haha]: 'reactionHaha',
  [GAME_REACTION_TYPE.Wow]: 'reactionWow',
  [GAME_REACTION_TYPE.Sad]: 'reactionSad',
  [GAME_REACTION_TYPE.Angry]: 'reactionAngry',
};

export const CARO_REACTIONS: readonly CaroReactionOption[] = [
  { type: GAME_REACTION_TYPE.Like, label: 'Thích', src: assetSrc(REACTION_ASSET.LIKE) },
  { type: GAME_REACTION_TYPE.Love, label: 'Yêu thích', src: assetSrc(REACTION_ASSET.LOVE) },
  { type: GAME_REACTION_TYPE.Haha, label: 'Haha', src: assetSrc(REACTION_ASSET.HAHA) },
  { type: GAME_REACTION_TYPE.Wow, label: 'Wow', src: assetSrc(REACTION_ASSET.WOW) },
  { type: GAME_REACTION_TYPE.Sad, label: 'Buồn', src: assetSrc(REACTION_ASSET.SAD) },
  { type: GAME_REACTION_TYPE.Angry, label: 'Tức giận', src: assetSrc(REACTION_ASSET.ANGRY) },
];

const REACTION_BY_TYPE = new Map(CARO_REACTIONS.map((reaction) => [reaction.type, reaction]));

export function reactionOption(type: GameReactionType): CaroReactionOption | null {
  return REACTION_BY_TYPE.get(type) ?? null;
}
