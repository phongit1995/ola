import { Image, type ImageSourcePropType } from 'react-native';

export const eggAssets = {
  background: require('../../../assets/games/egg/Egg_Background.png'),
  history: require('../../../assets/games/egg/ic_history.png'),
  reload: require('../../../assets/games/egg/ic_reload.png'),
  vipDays: require('../../../assets/games/egg/day_vip.png'),
  kenCoin: require('../../../assets/icons/apps/ken.png'),
} as const;

export const EGG_FRAMES: Record<string, ImageSourcePropType> = {
  Egg: require('../../../assets/games/egg/Egg.png'),
  Egg_1: require('../../../assets/games/egg/Egg_1.png'),
  Egg_2: require('../../../assets/games/egg/Egg_2.png'),
  Egg_3: require('../../../assets/games/egg/Egg_3.png'),
  Egg_4: require('../../../assets/games/egg/Egg_4.png'),
  Egg_5: require('../../../assets/games/egg/Egg_5.png'),
  Egg_6: require('../../../assets/games/egg/Egg_6.png'),
  Egg_7: require('../../../assets/games/egg/Egg_7.png'),
  Egg_8: require('../../../assets/games/egg/Egg_8.png'),
  Egg_9: require('../../../assets/games/egg/Egg_9.png'),
  Egg_7_Miss: require('../../../assets/games/egg/Egg_7_Miss.png'),
  Egg_8_Miss: require('../../../assets/games/egg/Egg_8_Miss.png'),
  Egg_9_Miss: require('../../../assets/games/egg/Egg_9_Miss.png'),
};

export interface FrameSize {
  width: number;
  height: number;
}

const frameSizeCache = new Map<string, FrameSize>();

export function frameSize(key: string): FrameSize {
  const cached = frameSizeCache.get(key);
  if (cached) return cached;
  const source = EGG_FRAMES[key];
  const resolved = source != null ? Image.resolveAssetSource(source) : null;
  const size = { width: resolved?.width ?? 0, height: resolved?.height ?? 0 };
  frameSizeCache.set(key, size);
  return size;
}
