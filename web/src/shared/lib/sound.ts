import kenChestUrl from '@/assets/sounds/ken-chest.mp3';
import kenCreditUrl from '@/assets/sounds/ken-credit.mp3';

const unlockableSounds: HTMLAudioElement[] = [];

function createSoundPlayer(url: string) {
  const base = new Audio(url);
  base.preload = 'auto';
  unlockableSounds.push(base);
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

let soundsUnlocked = false;

export function unlockSounds() {
  if (soundsUnlocked) return;
  soundsUnlocked = true;
  unlockableSounds.forEach((audio) => {
    audio
      .play()
      .then(() => {
        audio.pause();
        audio.currentTime = 0;
      })
      .catch(() => {});
  });
}
