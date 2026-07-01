import kenChestUrl from '@/assets/sounds/ken-chest.mp3';
import kenCreditUrl from '@/assets/sounds/ken-credit.mp3';

function createSoundPlayer(url: string) {
  const base = new Audio(url);
  base.preload = 'auto';
  return () => {
    try {
      const clone = base.cloneNode() as HTMLAudioElement;
      void clone.play().catch(() => {});
    } catch {
      return;
    }
  };
}

export const playKenChestSound = createSoundPlayer(kenChestUrl);
export const playKenCreditSound = createSoundPlayer(kenCreditUrl);
