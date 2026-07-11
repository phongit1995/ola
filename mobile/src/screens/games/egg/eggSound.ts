import Sound from 'react-native-sound';

let smashSound: Sound | null = null;
let loadFailed = false;

function ensureSmashSound(): Sound | null {
  if (smashSound != null || loadFailed) return smashSound;
  smashSound = new Sound(require('../../../assets/sounds/smash.wav'), (error) => {
    if (error) {
      loadFailed = true;
      smashSound = null;
    }
  });
  return smashSound;
}

export function playSmashSound() {
  const sound = ensureSmashSound();
  if (sound == null) return;
  sound.stop(() => {
    sound.setCurrentTime(0);
    sound.play();
  });
}
