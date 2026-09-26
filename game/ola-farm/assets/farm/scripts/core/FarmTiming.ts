import type { FarmCatalog } from './types/CatalogTypes';
import { isRecord } from './utils/TypeGuards';
import type { FarmCatalogSource } from './types/TimingTypes';

const fail = (field: string, reason: string): never => {
  throw Error(`timing.json · ${field}: ${reason}`);
};
function seconds(value: unknown, field: string): number {
  if (typeof value !== 'number' || !Number.isFinite(value) || value <= 0 || value > Number.MAX_SAFE_INTEGER)
    return fail(field, 'cần số giây lớn hơn 0.');
  return value;
}
function keys(value: Record<string, unknown>, allowed: string[], field: string): void {
  for (const key of Object.keys(value)) if (!allowed.includes(key)) fail(`${field}.${key}`, 'khóa không được hỗ trợ.');
}

/** Diamonds to finish a job now: one gem per started `boostSecondsPerGem` of remaining time (60 = 1 gem a minute). */
export function boostGems(catalog: FarmCatalog, remainingSeconds: number): number {
  return remainingSeconds > 0 ? Math.ceil(remainingSeconds / (catalog.boostSecondsPerGem ?? 60)) : 0;
}

/** Used by the Cocos asset loader and Node tools. Missing/typoed durations never silently fall back. */
export function withFarmTiming(source: FarmCatalogSource, value: unknown): FarmCatalog {
  if (!isRecord(value) || value.version !== 1) return fail('version', 'chỉ hỗ trợ phiên bản 1.');
  const timing = value;
  keys(value, ['version', 'boostSecondsPerGem', 'crops', 'animals', 'recipes'], 'config');
  if ('boostSecondsPerGem' in source)
    return fail('boostSecondsPerGem', 'hãy bỏ cấu hình thời gian trùng trong catalog.json.');
  const boostSecondsPerGem = seconds(value.boostSecondsPerGem, 'boostSecondsPerGem');
  function timed<T extends object>(
    entries: T[],
    group: 'crops' | 'animals' | 'recipes',
    keyOf: (entry: T) => string
  ): (T & { duration: number })[] {
    const durations = timing[group];
    if (!isRecord(durations)) return fail(group, 'thiếu bảng thời gian.');
    const expected = entries.map(keyOf);
    if (new Set(expected).size !== expected.length) return fail(group, 'catalog.json có khóa trùng.');
    keys(durations, expected, group);
    return entries.map(entry => {
      const key = keyOf(entry),
        config = durations[key],
        field = `${group}.${key}`;
      if ('duration' in entry) return fail(field, 'hãy bỏ duration trùng trong catalog.json.');
      if (!isRecord(config)) return fail(field, 'thiếu cấu hình thời gian.');
      keys(config, ['name', 'durationSeconds'], field);
      if (typeof config.name !== 'string' || !config.name.trim())
        return fail(`${field}.name`, 'cần tên để nhận diện khi chỉnh JSON.');
      return { ...entry, duration: seconds(config.durationSeconds, `${field}.durationSeconds`) };
    });
  }
  return {
    ...source,
    boostSecondsPerGem,
    farm: timed(source.farm, 'crops', crop => crop.key),
    livestock: timed(source.livestock, 'animals', animal => animal.key),
    products: timed(source.products, 'recipes', recipe => String(recipe.id)),
  };
}
