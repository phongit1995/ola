import bgUrl from '@/assets/games/egg/Egg_Background.png';
import eggUrl from '@/assets/games/egg/Egg.png';
import egg1 from '@/assets/games/egg/Egg_1.png';
import egg2 from '@/assets/games/egg/Egg_2.png';
import egg3 from '@/assets/games/egg/Egg_3.png';
import egg4 from '@/assets/games/egg/Egg_4.png';
import egg5 from '@/assets/games/egg/Egg_5.png';
import egg6 from '@/assets/games/egg/Egg_6.png';
import egg7 from '@/assets/games/egg/Egg_7.png';
import egg8 from '@/assets/games/egg/Egg_8.png';
import egg9 from '@/assets/games/egg/Egg_9.png';
import egg7Miss from '@/assets/games/egg/Egg_7_Miss.png';
import egg8Miss from '@/assets/games/egg/Egg_8_Miss.png';
import egg9Miss from '@/assets/games/egg/Egg_9_Miss.png';
import historyUrl from '@/assets/games/egg/ic_history.png';
import reloadUrl from '@/assets/games/egg/ic_reload.png';
import smashUrl from '@/assets/sounds/smash.wav';

export const EGG_BACKGROUND_KEY = 'Egg_Background';
export const EGG_REST_KEY = 'Egg';
export const EGG_RELOAD_KEY = 'Egg_Reload';

export const EGG_TEXTURE_URLS: Record<string, string> = {
  Egg_Background: bgUrl,
  Egg: eggUrl,
  Egg_1: egg1,
  Egg_2: egg2,
  Egg_3: egg3,
  Egg_4: egg4,
  Egg_5: egg5,
  Egg_6: egg6,
  Egg_7: egg7,
  Egg_8: egg8,
  Egg_9: egg9,
  Egg_7_Miss: egg7Miss,
  Egg_8_Miss: egg8Miss,
  Egg_9_Miss: egg9Miss,
  Egg_Reload: reloadUrl,
};

export const smashSoundUrl = smashUrl;
export const historyIconUrl = historyUrl;
