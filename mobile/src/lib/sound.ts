import { Image } from 'react-native';
import Sound from 'react-native-sound';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import type { UserSettings } from '@ola/shared/types';

Sound.setCategory('Ambient', true);

type SoundGate = {
  [K in keyof UserSettings]: UserSettings[K] extends boolean ? K : never;
}[keyof UserSettings];

export interface SoundPlayer {
  play: () => void;
  stop: () => void;
}

export function createSoundPlayer(asset: number, gate: SoundGate): SoundPlayer {
  let sound: Sound | null = null;
  let loadFailed = false;
  let playWhenLoaded = false;
  return {
    play: () => {
      if (!useSettingsStore.getState().settings[gate]) return;
      if (loadFailed) return;
      if (sound == null) {
        const source = Image.resolveAssetSource(asset);
        if (source?.uri == null || source.uri === '') {
          loadFailed = true;
          return;
        }
        playWhenLoaded = true;
        const created = new Sound(source.uri, undefined, (error) => {
          if (error) {
            loadFailed = true;
            sound = null;
            return;
          }
          if (playWhenLoaded) created.play();
        });
        sound = created;
        return;
      }
      if (!sound.isLoaded()) {
        playWhenLoaded = true;
        return;
      }
      const current = sound;
      current.stop(() => {
        current.setCurrentTime(0);
        current.play();
      });
    },
    stop: () => {
      playWhenLoaded = false;
      sound?.stop();
    },
  };
}

export const playKenChestSound = createSoundPlayer(
  require('@assets/sounds/ken-chest.mp3'),
  'soundGame'
).play;
export const playKenShotFailSound = createSoundPlayer(
  require('@assets/sounds/ken-shot-fail.mp3'),
  'soundGame'
).play;
export const playKenCreditSound = createSoundPlayer(
  require('@assets/sounds/ken-credit.mp3'),
  'soundKen'
).play;
export const playMessageSound = createSoundPlayer(
  require('@assets/sounds/message.mp3'),
  'notifSound'
).play;
export const playRoomTagSound = createSoundPlayer(
  require('@assets/sounds/room-tag.mp3'),
  'notifSound'
).play;
