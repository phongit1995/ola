import type { AnyListener, Listener } from './types/EmitterTypes';

/**
 * Minimal typed event emitter. The core stays free of engine imports so sessions run under Node tests.
 * `Events` maps each event name to its argument tuple; declare it as a type alias, not an interface.
 */
export class Emitter<Events extends Record<string, unknown[]>> {
  private listeners = new Map<keyof Events, Set<AnyListener>>();

  on<K extends keyof Events>(event: K, listener: Listener<Events[K]>): () => void {
    let set = this.listeners.get(event);
    if (!set) {
      set = new Set();
      this.listeners.set(event, set);
    }
    const entry = listener as unknown as AnyListener;
    set.add(entry);
    return () => {
      set!.delete(entry);
    };
  }

  protected emit<K extends keyof Events>(event: K, ...args: Events[K]): void {
    const set = this.listeners.get(event);
    if (!set) return;
    // Array.from, not spread: Creator's loose Babel output turns `[...set]` into `[].concat(set)`.
    for (const listener of Array.from(set)) listener(...args);
  }

  removeAllListeners(): void {
    this.listeners.clear();
  }
}
