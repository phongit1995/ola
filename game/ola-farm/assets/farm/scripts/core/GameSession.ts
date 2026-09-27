import { runtimeConfig } from './FarmRuntime';
import { Emitter } from './Emitter';
import { FarmGame } from './FarmGame';
import { FarmSave, farmPack } from './FarmSave';
import type { FarmPack, FarmSettings } from './types/SaveTypes';
import type { FarmAction } from './types/ActionTypes';
import { applyAction } from './FarmActions';
import type { FarmCatalog } from './types/CatalogTypes';
import type { SessionEvents, Dispatch, AudioKind, SaveExport } from './types/SessionTypes';
import { SPEEDS, MAX_TICK_SECONDS } from './constants/SessionDefaults';
import { t } from './i18n/I18n';

const clone = <T>(value: T): T => JSON.parse(JSON.stringify(value));

/**
 * Owns the live farm, its persisted pack and every failure mode around saving.
 * Engine-free: the Cocos layer only renders this object and forwards input as actions.
 */
export class GameSession extends Emitter<SessionEvents> {
  game: FarmGame;
  pack: FarmPack;
  speed: number;
  paused = false;
  layoutEditing = false;
  hidden = false;
  storageFailed = false;
  pendingPack: FarmPack | null = null;
  /** Pause state before the menu opened, so closing the menu restores it. In real time a pause only blocks input. */
  pauseBeforeMenu: boolean | null = null;
  /** The stored save could not be read; the previous bytes are kept for export. */
  readonly recovered: boolean;
  private saveElapsed = 0;
  private lastWallTime = 0;
  get realTime(): boolean {
    return this.catalog.timeMode === 'real';
  }
  get runtime() {
    return runtimeConfig(this.catalog);
  }
  get availableSpeeds(): readonly number[] {
    return this.realTime ? [1] : SPEEDS;
  }

  constructor(
    readonly catalog: FarmCatalog,
    readonly saver: FarmSave,
    private readonly now: () => number = Date.now
  ) {
    super();
    let loaded: FarmPack | null = null,
      recovered = false;
    try {
      loaded = saver.load();
    } catch {
      recovered = true;
    }
    this.recovered = recovered;
    if (recovered) {
      this.storageFailed = true;
      this.paused = true;
    }
    const settings: FarmSettings = {
      ...(loaded?.settings ?? {
        speed: 1,
        sound: this.runtime.session.defaultSound,
        music: this.runtime.session.defaultMusic,
      }),
    };
    if (this.realTime) settings.speed = 1;
    this.game = this.createGame(loaded?.free ?? null);
    this.pack = farmPack(this.game.state, settings);
    this.speed = settings.speed;
    this.lastWallTime = loaded?.clock?.savedAt ?? this.wallStamp();
    if (this.realTime && loaded?.clock && !recovered) this.advanceOffline(loaded.clock.running);
  }

  createGame(saved: unknown = null): FarmGame {
    return new FarmGame(this.catalog, saved);
  }
  get settings(): FarmSettings {
    return this.pack.settings;
  }
  get canAct(): boolean {
    return !this.paused && !this.layoutEditing && !this.hidden && !this.storageFailed;
  }
  canDispatch(action: FarmAction): boolean {
    return action.type === 'moveBuilding' ? this.layoutEditing && !this.hidden && !this.storageFailed : this.canAct;
  }
  /** Why input is refused. Real time never stops for the menu or building moves, so name what is open instead. */
  get blockedMessage(): string {
    if (!this.realTime || this.storageFailed || this.hidden) return t('session.paused');
    return this.layoutEditing ? t('session.arranging') : t('session.menuOpen');
  }
  beginLayout(): boolean {
    if (this.hidden || this.storageFailed || !this.game.simple) return false;
    this.tick(0);
    this.leaveMenu();
    if (this.storageFailed) return false;
    this.layoutEditing = true;
    if (this.realTime && !this.save()) return false;
    this.emit('paused', true);
    return true;
  }
  endLayout(): void {
    this.tick(0);
    this.layoutEditing = false;
    if (this.realTime) this.save();
    this.emit('paused', this.paused || this.hidden || this.storageFailed);
  }

  private wallStamp(): number {
    const value = this.now();
    return Number.isSafeInteger(value) && value >= 0 ? Math.max(this.lastWallTime, value) : this.lastWallTime;
  }

  private packNow(state = this.game.state, savedAt = this.lastWallTime): FarmPack {
    return {
      ...farmPack(state, { ...this.pack.settings, speed: this.realTime ? 1 : this.speed }),
      ...(this.realTime ? { clock: { version: 1 as const, savedAt, running: true } } : {}),
    };
  }

  /** Offline advancement only finishes already paid work. Persist before publishing it. */
  private advanceOffline(running = true): void {
    if (!this.realTime || this.storageFailed) return;
    const stamp = this.wallStamp(),
      seconds = (stamp - this.lastWallTime) / 1000;
    if (seconds <= 0) return;
    const candidate = this.createGame(this.game.state);
    if (running && this.runtime.session.offlineProgressEnabled)
      candidate.tick(Math.min(seconds, this.runtime.session.maxOfflineSeconds ?? seconds));
    const next = this.packNow(candidate.state, stamp);
    try {
      this.saver.save(next);
    } catch {
      this.failSave(next);
      return;
    }
    this.game = candidate;
    this.pack = next;
    this.lastWallTime = stamp;
    this.emit('replaced');
  }

  suspend(): void {
    if (this.hidden) return;
    this.tick(0);
    this.hidden = true;
    this.save();
  }

  resume(): void {
    if (!this.hidden) return;
    this.hidden = false;
    this.advanceOffline();
  }

  /** Apply to a candidate, persist, then publish. A failed save keeps the visible farm and pauses. */
  dispatch(action: FarmAction): Dispatch {
    // Input can arrive before the next frame. Start new work at this wall-clock instant.
    if (this.realTime) this.tick(0);
    if (!this.canDispatch(action)) return { ok: false, result: { error: this.blockedMessage } };
    const candidate = this.createGame(this.game.state);
    const result = applyAction(candidate, action);
    if (result.error) return { ok: false, result };
    const next = this.packNow(candidate.state);
    try {
      this.saver.save(next);
    } catch {
      this.failSave(next);
      return { ok: false, result };
    }
    this.game = candidate;
    this.pack = next;
    this.pendingPack = null;
    this.emit('committed', action, result);
    return { ok: true, result };
  }

  tick(dt: number): void {
    if (this.hidden || !Number.isFinite(dt) || dt < 0) return;
    if (this.realTime) {
      const stamp = this.wallStamp();
      // Like Hay Day, the menu and building moves never stop the farm; only a failed save freezes it.
      // Moving the clock backwards never replays time.
      if (!this.storageFailed) this.game.tick((stamp - this.lastWallTime) / 1000);
      this.lastWallTime = stamp;
    } else if (this.canAct) this.game.tick(Math.min(MAX_TICK_SECONDS, dt) * this.speed);
    this.saveElapsed += dt;
    if (this.saveElapsed >= this.runtime.session.autosaveSeconds) {
      this.saveElapsed = 0;
      this.save();
    }
  }

  save(): boolean {
    if (this.storageFailed) return false;
    const next = this.packNow();
    try {
      this.saver.save(next);
      this.pack = next;
      this.pendingPack = null;
      return true;
    } catch {
      this.failSave(next);
      return false;
    }
  }

  private failSave(next: FarmPack): void {
    this.layoutEditing = false;
    this.pendingPack = clone(next);
    this.storageFailed = true;
    this.paused = true;
    this.emit('saveFailed');
    this.emit('paused', true);
    this.emit('toast', t('save.failed'));
  }

  retrySave(): boolean {
    if (!this.pendingPack) {
      this.emit('toast', t('save.importOrRestore'));
      return false;
    }
    try {
      const candidate = this.saver.parse(JSON.stringify(this.pendingPack));
      // Storage failure paused the farm; retry must not replay that waiting interval.
      if (this.realTime) candidate.clock = { version: 1, savedAt: this.wallStamp(), running: true };
      this.saver.save(candidate);
      this.adopt(candidate);
      this.emit('toast', t('save.retried'));
      return true;
    } catch {
      this.emit('toast', t('save.stillFailing'));
      return false;
    }
  }

  /** Replace the live farm with a pack that is already persisted and leave every failure mode. */
  private adopt(pack: FarmPack): void {
    this.layoutEditing = false;
    this.pack = pack;
    this.game = this.createGame(pack.free);
    this.speed = this.realTime ? 1 : pack.settings.speed;
    this.lastWallTime = pack.clock?.savedAt ?? this.wallStamp();
    if (!pack.clock?.running) this.lastWallTime = this.wallStamp();
    this.pendingPack = null;
    this.storageFailed = false;
    this.paused = false;
    this.pauseBeforeMenu = null;
    this.emit('replaced');
    this.emit('paused', false);
  }

  /** Throws with a player-readable message when the text is not a valid save of this profile. */
  importText(text: string): void {
    const candidate = this.saver.parse(text);
    this.createGame(candidate.free);
    this.saver.importText(text);
    this.adopt(candidate);
    this.advanceOffline(candidate.clock?.running ?? false);
    this.save();
  }

  restart(): boolean {
    this.layoutEditing = false;
    if (this.storageFailed) {
      this.emit('toast', t('save.restoreBeforeRestart'));
      return false;
    }
    const next = this.createGame(),
      candidate = this.packNow(next.state, this.wallStamp());
    try {
      this.saver.save(candidate);
    } catch {
      this.failSave(candidate);
      return false;
    }
    this.pack = candidate;
    this.game = next;
    this.lastWallTime = candidate.clock?.savedAt ?? this.lastWallTime;
    this.pauseBeforeMenu = null;
    this.paused = false;
    this.emit('replaced');
    this.emit('paused', false);
    return true;
  }

  setSpeed(speed: number): boolean {
    if (!this.availableSpeeds.includes(speed)) return false;
    this.speed = speed;
    this.save();
    return true;
  }

  toggleAudio(kind: AudioKind): boolean {
    const settings = this.pack.settings;
    settings[kind] = !settings[kind];
    this.save();
    return settings[kind];
  }

  togglePause(): void {
    if (this.storageFailed) return;
    this.tick(0);
    this.paused = !this.paused;
    if (this.realTime) this.save();
    this.emit('paused', this.paused);
  }

  /** The menu always blocks input; closing it restores whatever the player had before. Real time keeps running. */
  enterMenu(): void {
    if (this.pauseBeforeMenu !== null) return;
    this.tick(0);
    this.pauseBeforeMenu = this.paused;
    this.paused = true;
    if (this.realTime) this.save();
    this.emit('paused', true);
  }

  leaveMenu(): void {
    if (this.pauseBeforeMenu === null) return;
    this.tick(0);
    this.paused = this.storageFailed || this.pauseBeforeMenu;
    this.pauseBeforeMenu = null;
    if (this.realTime) this.save();
    this.emit('paused', this.paused);
  }

  exportText(): string {
    return JSON.stringify(this.packNow(), null, 2);
  }

  exportSource(kind: SaveExport): string | null {
    switch (kind) {
      case 'legacy':
        return this.saver.legacySource();
      case 'legacy-backup':
        return this.saver.legacyBackup();
      case 'source':
        return this.saver.source();
      case 'backup':
        return this.saver.backup();
      case 'pending':
        return this.pendingPack ? JSON.stringify(this.pendingPack, null, 2) : null;
      default:
        return this.exportText();
    }
  }
}
