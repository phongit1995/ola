import Sound from 'react-native-sound';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';

Sound.setCategory('Ambient', true);

let spinSound: Sound | null = null;
let loadFailed = false;

function ensureSpinSound(): Sound | null {
  if (spinSound != null || loadFailed) return spinSound;
  spinSound = new Sound(require('../../../assets/sounds/lucky_wheel_spin.mp3'), (error) => {
    if (error) {
      loadFailed = true;
      spinSound = null;
    }
  });
  return spinSound;
}

export function playSpinSound() {
  if (!useSettingsStore.getState().settings.soundGame) return;
  const sound = ensureSpinSound();
  if (sound == null) return;
  sound.stop(() => {
    sound.setCurrentTime(0);
    sound.play();
  });
}

export function stopSpinSound() {
  spinSound?.stop();
}
