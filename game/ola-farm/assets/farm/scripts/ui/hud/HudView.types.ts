export interface HudActions {
  pause(): void;
  open(view: 'shop' | 'inventory' | 'factory' | 'coins' | 'gems'): void;
}
