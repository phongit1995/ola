import kenChestUrl from '@/assets/sounds/ken-chest.mp3';
import kenCreditUrl from '@/assets/sounds/ken-credit.mp3';
import kenShotFailUrl from '@/assets/sounds/ken-shot-fail.mp3';
import messageUrl from '@/assets/sounds/message.mp3';
import roomTagUrl from '@/assets/sounds/room-tag.mp3';
import type { UserSettings } from '@app-types';
import { useSettingsStore } from '@/store/settingsStore';

const unlockableSounds: HTMLAudioElement[] = [];

function createSoundPlayer(url: string, gate?: keyof UserSettings) {
  const base = new Audio(url);
  base.preload = 'auto';
  unlockableSounds.push(base);
  return () => {
    if (gate != null && !useSettingsStore.getState().settings[gate]) return;
    try {
      const clone = base.cloneNode() as HTMLAudioElement;
      void clone.play().catch(() => {});
    } catch {
      return;
    }
  };
}

export const playKenChestSound = createSoundPlayer(kenChestUrl, 'soundGame');
export const playKenShotFailSound = createSoundPlayer(
  kenShotFailUrl,
  'soundGame'
);
export const playKenCreditSound = createSoundPlayer(kenCreditUrl, 'soundKen');
export const playMessageSound = createSoundPlayer(messageUrl, 'notifSound');
export const playRoomTagSound = createSoundPlayer(roomTagUrl, 'notifSound');

let soundsUnlocked = false;

export function unlockSounds() {
  if (soundsUnlocked) return;
  soundsUnlocked = true;
  unlockableSounds.forEach((audio) => {
    const previousVolume = audio.volume;
    audio.muted = true;
    audio.volume = 0;
    audio
      .play()
      .then(() => {
        audio.pause();
        audio.currentTime = 0;
        audio.muted = false;
        audio.volume = previousVolume;
      })
      .catch(() => {
        audio.muted = false;
        audio.volume = previousVolume;
      });
  });
}
