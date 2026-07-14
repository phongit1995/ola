import { createSoundPlayer } from '../../../lib/sound';

const spinSound = createSoundPlayer(
  require('../../../assets/sounds/lucky_wheel_spin.mp3'),
  'soundGame'
);

export const playSpinSound = spinSound.play;
export const stopSpinSound = spinSound.stop;
