export class RecentMatchIds {
  private readonly ids = new Set<string>();

  constructor(private readonly maxSize = 128) {
    if (!Number.isInteger(maxSize) || maxSize < 1) {
      throw new RangeError('maxSize must be a positive integer');
    }
  }

  mark(id: string): boolean {
    if (this.ids.has(id)) return false;
    this.ids.add(id);
    while (this.ids.size > this.maxSize) {
      const oldest = this.ids.values().next().value;
      if (oldest === undefined) break;
      this.ids.delete(oldest);
    }
    return true;
  }

  get size(): number {
    return this.ids.size;
  }
}
