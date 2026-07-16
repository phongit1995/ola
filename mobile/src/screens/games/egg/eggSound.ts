import { createSoundPlayer } from '@lib/sound';

const smashSound = createSoundPlayer(require('@assets/sounds/smash.wav'), 'soundGame');

export const playSmashSound = smashSound.play;
