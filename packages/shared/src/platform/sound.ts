import type { SoundPort } from '../types/platform.type';
import {
  getCurrentSound,
  setCurrentSound,
} from './platformRuntime.state';

export type { SoundPort } from '../types/platform.type';

export function configureSound(port: SoundPort): void {
  setCurrentSound(port);
}

export function playMessageSound(): void {
  getCurrentSound()?.playMessage();
}

export function playRoomTagSound(): void {
  getCurrentSound()?.playRoomTag();
}

export function playKenChestSound(): void {
  getCurrentSound()?.playKenChest();
}

export function playKenCreditSound(): void {
  getCurrentSound()?.playKenCredit();
}
