import type { Art } from '../../render/Art';

/** Single-use handoff between the authored Loading and Farm scenes. */
export interface PreparedFarm {
  art: Art;
  isHidden(): boolean;
  complete(): void;
  fail(error: unknown): void;
}
