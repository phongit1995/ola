import { FarmGame } from './FarmGame';
import { FARM_KEY, SIMPLE_FARM_KEY, PREVIOUS_SAVE_KEYS } from './constants/SaveKeys';
import type { FarmCatalog } from './types/CatalogTypes';
import type { FarmState } from './types/StateTypes';
import { isRecord } from './utils/TypeGuards';
import { needsResidentSlots } from './FarmMigration';
import type { FarmSettings, FarmPack, StoragePort } from './types/SaveTypes';

/** One pack constructor for autosave, actions, restart and export. */
export function farmPack(free: FarmState, settings: FarmSettings): FarmPack {
  return {
    version: free.version === 7 ? 6 : free.version === 6 ? 5 : free.version === 5 ? 4 : 2,
    ...(free.contentProfile === 'simple-1' ? { contentProfile: 'simple-1' as const } : {}),
    current: 'free',
    free,
    settings: { ...settings },
  };
}

/** A separate slot preserves every byte of the full farm and its recovery copies. */
export class FarmSave {
  readonly key: string;
  /** Text this instance wrote last; a matching primary needs no re-validation before it becomes the backup. */
  private lastWritten: string | null = null;
  constructor(
    private storage: StoragePort,
    private catalog: FarmCatalog
  ) {
    this.key = catalog.contentProfile === 'simple-1' ? SIMPLE_FARM_KEY : FARM_KEY;
  }
  private prepare(value: unknown): FarmPack {
    const simple = this.catalog.contentProfile === 'simple-1';
    if (simple && isRecord(value) && [1, 2, 3].includes(value.version))
      throw Error(
        'Đây là bản lưu nông trại cũ/đầy đủ. Hãy dùng bản game tương ứng để khôi phục; bản mới dùng lượt chơi riêng.'
      );
    if (
      !isRecord(value) ||
      !(simple
        ? [4, 5, 6].includes(value.version) && value.contentProfile === 'simple-1'
        : [1, 2].includes(value.version)) ||
      value.current !== 'free' ||
      !isRecord(value.settings) ||
      ![1, 6, 12].includes(value.settings.speed) ||
      typeof value.settings.sound !== 'boolean' ||
      (value.settings.music !== undefined && typeof value.settings.music !== 'boolean') ||
      !isRecord(value.free) ||
      value.free.version !== value.version + 1
    )
      throw Error('Phiên bản hoặc nội dung bản lưu không được hỗ trợ.');
    const free = new FarmGame(this.catalog, value.free).state;
    if (
      value.clock !== undefined &&
      (!isRecord(value.clock) ||
        value.clock.version !== 1 ||
        !Number.isSafeInteger(value.clock.savedAt) ||
        value.clock.savedAt < 0 ||
        typeof value.clock.running !== 'boolean')
    )
      throw Error('Đồng hồ bản lưu không hợp lệ.');
    return {
      ...farmPack(free, {
        speed: value.settings.speed,
        sound: value.settings.sound,
        music: value.settings.music ?? value.settings.sound,
      }),
      ...(value.clock
        ? { clock: { version: 1 as const, savedAt: value.clock.savedAt, running: value.clock.running } }
        : {}),
    };
  }
  private sourceKey(key: string): string {
    return this.storage.getItem(key) !== null ? key : PREVIOUS_SAVE_KEYS[key];
  }
  private backupFor(key: string): string | null {
    const current = this.storage.getItem(key + '.backup');
    return current !== null
      ? current
      : this.storage.getItem(key) === null
        ? this.storage.getItem(PREVIOUS_SAVE_KEYS[key] + '.backup')
        : null;
  }
  load(): FarmPack | null {
    const raw = this.source();
    return raw === null ? null : this.parse(raw);
  }
  parse(text: string): FarmPack {
    if (text.length > 2_000_000) throw Error('Bản lưu quá lớn.');
    return this.prepare(JSON.parse(text));
  }
  save(pack: FarmPack): void {
    const next = this.prepare(pack),
      previous = this.source();
    if (previous !== null) {
      if (previous !== this.lastWritten) this.parse(previous);
      this.preserveMigration(previous);
      this.storage.setItem(this.key + '.backup', previous);
    }
    const text = JSON.stringify(next);
    this.storage.setItem(this.key, text);
    this.lastWritten = text;
  }
  importText(text: string): FarmPack {
    const next = this.parse(text),
      previous = this.source();
    if (previous !== null) this.preserveMigration(previous);
    this.preserveMigration(text);
    if (previous !== null) this.storage.setItem(this.key + '.before-import', previous);
    this.storage.setItem(this.key + '.import-source', text);
    const stored = JSON.stringify(next);
    this.storage.setItem(this.key, stored);
    this.lastWritten = stored;
    return next;
  }
  source(): string | null {
    return this.storage.getItem(this.sourceKey(this.key));
  }
  private preserveMigration(raw: string): void {
    if (this.catalog.contentProfile !== 'simple-1') return;
    let value: any;
    try {
      value = JSON.parse(raw);
    } catch {
      return;
    }
    if (!isRecord(value)) return;
    if (
      value.contentProfile === 'simple-1' &&
      [5, 6].includes(value.free?.version) &&
      this.storage.getItem(this.key + '.before-two-buildings-v7') === null
    )
      this.storage.setItem(this.key + '.before-two-buildings-v7', raw);
    if (needsResidentSlots(value.free) && this.storage.getItem(this.key + '.before-animal-slots-v1') === null)
      this.storage.setItem(this.key + '.before-animal-slots-v1', raw);
    if (
      value.contentProfile === 'simple-1' &&
      isRecord(value.free) &&
      !('husbandry' in value.free) &&
      this.storage.getItem(this.key + '.before-town-husbandry') === null
    )
      this.storage.setItem(this.key + '.before-town-husbandry', raw);
    if (
      value.version === 4 &&
      value.free?.version === 5 &&
      this.storage.getItem(this.key + '.before-layout-v6') === null
    )
      this.storage.setItem(this.key + '.before-layout-v6', raw);
    if (
      value.free?.version === 6 &&
      value.free?.buildingLayout?.version === 1 &&
      this.storage.getItem(this.key + '.before-fixed-roads-v2') === null
    )
      this.storage.setItem(this.key + '.before-fixed-roads-v2', raw);
    if (
      value.free?.version === 6 &&
      [1, 2].includes(value.free?.buildingLayout?.version) &&
      this.storage.getItem(this.key + '.before-large-pens-v3') === null
    )
      this.storage.setItem(this.key + '.before-large-pens-v3', raw);
    if (
      value.free?.version === 6 &&
      [1, 2, 3].includes(value.free?.buildingLayout?.version) &&
      this.storage.getItem(this.key + '.before-four-field-pens-v4') === null
    )
      this.storage.setItem(this.key + '.before-four-field-pens-v4', raw);
    if (
      value.free?.version === 6 &&
      [1, 2, 3, 4].includes(value.free?.buildingLayout?.version) &&
      this.storage.getItem(this.key + '.before-large-machines-v5') === null
    )
      this.storage.setItem(this.key + '.before-large-machines-v5', raw);
  }
  backup(): string | null {
    return this.backupFor(this.key);
  }
  legacySource(): string | null {
    return this.storage.getItem(this.sourceKey(FARM_KEY));
  }
  legacyBackup(): string | null {
    return this.backupFor(FARM_KEY);
  }
}
