import type { Art } from '../../render/Art';

/** Single-use handoff between the authored Loading and Farm scenes. */
export interface PreparedFarm {
  art: Art;
  /** Ola account from the host's access token; null plays the device-wide save. */
  account: string | null;
  isHidden(): boolean;
  complete(): void;
  fail(error: unknown): void;
}
