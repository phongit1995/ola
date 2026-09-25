/** Stable storage IDs; persisted farm40:* item IDs remain independent of display branding. */
export const FARM_KEY = 'ola-farm-cocos-40-v1';
export const SIMPLE_FARM_KEY = 'ola-farm-cocos-simple-v1';

/** Read-only aliases preserve saves from before the Ola Farm rename, including recovery copies. */
export const PREVIOUS_SAVE_KEYS: Readonly<Record<string, string>> = {
  [FARM_KEY]: 'happy-farm-cocos-40-v1',
  [SIMPLE_FARM_KEY]: 'happy-farm-cocos-simple-v1',
};
