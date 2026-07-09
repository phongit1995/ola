import spinSoundUrl from '@/assets/sounds/lucky_wheel_spin.mp3';
import { useSettingsStore } from '@/store/settingsStore';

const spinAudio = new Audio(spinSoundUrl);
spinAudio.preload = 'auto';

export function playSpinSound() {
  if (!useSettingsStore.getState().settings.soundGame) return;
  try {
    spinAudio.currentTime = 0;
    void spinAudio.play().catch(() => {});
  } catch {
    return;
  }
}

export function stopSpinSound() {
  try {
    spinAudio.pause();
    spinAudio.currentTime = 0;
  } catch {
    return;
  }
}
