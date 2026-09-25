import type { Vec3 } from 'cc';

export interface FooterActions {
  enabled: boolean;
  plant(cropId: number): void;
  livestock(): void;
  rescue(): void;
}

export interface SeedHoldState {
  timer: ReturnType<typeof setTimeout> | null;
  start: Vec3 | null;
  fired: boolean;
}
