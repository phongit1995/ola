export interface SoundPort {
  playMessage(): void;
  playRoomTag(): void;
}

let current: SoundPort | null = null;

export function configureSound(port: SoundPort): void {
  current = port;
}

export function playMessageSound(): void {
  current?.playMessage();
}

export function playRoomTagSound(): void {
  current?.playRoomTag();
}
