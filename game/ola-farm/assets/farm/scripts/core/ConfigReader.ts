import { isRecord } from './utils/TypeGuards';

/** Strict JSON readers shared by gameplay/runtime config; errors point to the editable field. */
export class ConfigReader {
  constructor(private file: string) {}
  fail(path: string, reason: string): never {
    throw Error(`${this.file} · ${path}: ${reason}`);
  }
  object(value: unknown, path: string, keys?: readonly string[]): Record<string, any> {
    if (!isRecord(value)) return this.fail(path, 'cần một mục cấu hình.');
    if (keys) {
      for (const key of keys) if (!(key in value)) this.fail(`${path}.${key}`, 'thiếu cấu hình.');
      for (const key of Object.keys(value))
        if (!keys.includes(key)) this.fail(`${path}.${key}`, 'khóa không được hỗ trợ.');
    }
    return value;
  }
  number(value: unknown, path: string, min: number, max = Number.MAX_SAFE_INTEGER, integer = false): number {
    if (
      typeof value !== 'number' ||
      !Number.isFinite(value) ||
      value < min ||
      value > max ||
      (integer && !Number.isSafeInteger(value))
    )
      return this.fail(path, `cần ${integer ? 'số nguyên' : 'số'} từ ${min} đến ${max}.`);
    return value;
  }
  bool(value: unknown, path: string): boolean {
    if (typeof value !== 'boolean') return this.fail(path, 'cần true hoặc false.');
    return value;
  }
  text(value: unknown, path: string): string {
    if (typeof value !== 'string' || !value.trim()) return this.fail(path, 'cần chuỗi khác rỗng.');
    return value;
  }
}
