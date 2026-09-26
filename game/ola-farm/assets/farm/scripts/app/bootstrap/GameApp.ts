import { MAP_INSET, TOAST_ABOVE_NAVIGATION, TOAST_ABOVE_FOOTER, TOAST_ABOVE_PANEL } from './GameApp.constants';
import {
  _decorator,
  Component,
  Node,
  Color,
  UITransform,
  UIOpacity,
  director,
  game as cocosGame,
  Game as CocosGame,
  sys,
  view,
  profiler,
  input,
  Input,
  KeyCode,
  EventKeyboard,
  Prefab,
  macro,
} from 'cc';
import { DEBUG } from 'cc/env';
import type { Art } from '../../render/Art';
import { Ui } from '../../render/Ui';
import { UiPrefabs } from '../../render/UiPrefabs';
import { AudioService } from '../services/AudioService';
import { ContextualFooter } from '../layout/ContextualFooter';
import { installDebugApi, uninstallDebugApi } from '../debug/DebugApi';
import { applyDesignResolution } from '../layout/Layout';
import { claimPreparedFarm } from './PreparedFarm';
import { accountStorage } from '../../core/AccountStorage';
import { olaReady } from '../services/OlaBridge';
import { downloadJson, pickJsonFile } from '../services/SaveFiles';
import { FarmGame } from '../../core/FarmGame';
import { machineSites, penBuildingId, penDefinition } from '../../core/FarmCatalog';
import { FarmSave } from '../../core/FarmSave';
import type { FarmAction } from '../../core/types/ActionTypes';
import type { AudioKind, SaveExport } from '../../core/types/SessionTypes';
import { GameSession } from '../../core/GameSession';
import { countdown, remainingSeconds } from '../../core/Countdown';
import type { Plot } from '../../core/types/PlotTypes';
import { FarmMapView } from '../../map/FarmMapView';
import type { AppFacade, OpenOptions } from '../../ui/shared/AppFacade.types';
import type { PanelView } from '../../ui/shared/PanelView.types';
import { HudView } from '../../ui/hud/HudView';

import { PanelHost } from '../../ui/shared/PanelHost';

import { ToastView } from '../../ui/shared/ToastView';
import { isPanelView } from '../../ui/panels/index';

const { ccclass, property } = _decorator;

/**
 * Receives loaded art from Loading.scene, builds the session and wires the views. Gameplay rules live in the
 * core, rendering in the map and UI components; this class only routes between them.
 */
@ccclass('GameApp')
export class GameApp extends Component implements AppFacade {
  @property(Prefab) cropPlotPrefab: Prefab | null = null;
  @property(Prefab) shopPrefab: Prefab | null = null;
  @property(Node) root: Node = null!;
  @property(FarmMapView) map: FarmMapView = null!;
  @property(HudView) hud: HudView = null!;
  @property(UiPrefabs) uiPrefabs: UiPrefabs = null!;

  art!: Art;
  ui!: Ui;
  session!: GameSession;
  audio!: AudioService;
  panels!: PanelHost;
  toastView!: ToastView;
  footer!: ContextualFooter;
  selected: number | null = null;
  initialized = false;
  motion = true;
  /** A long press entered arrangement with the pointer still down; releasing it ends the mode. */
  directArrangement = false;

  private elapsed = 0;
  private skipDelta = false;
  /** Set by the root's SIZE_CHANGED; the footer and toast are re-laid out in update(). */
  private layoutDirty = false;
  private tabHidden = false;
  /** Ola account whose save is open; null for the device-wide save. */
  private account: string | null = null;

  // Thin accessors kept for tests and the debug API.
  get game(): FarmGame {
    return this.session.game;
  }
  get paused(): boolean {
    return this.session.paused;
  }
  set paused(value: boolean) {
    if (value !== this.session.paused) this.session.togglePause();
  }
  get speed(): number {
    return this.session.speed;
  }
  set speed(value: number) {
    this.session.setSpeed(value);
  }
  get storageFailed(): boolean {
    return this.session.storageFailed;
  }
  get toastBox(): Node {
    return this.toastView.node;
  }
  get menu(): Node {
    return this.footer.menu;
  }
  get width(): number {
    return this.getComponent(UITransform)!.width;
  }
  get height(): number {
    return this.getComponent(UITransform)!.height;
  }
  /** Device pixels across the canvas; code-sized widgets scale their touch targets by it. */
  get frameWidth(): number {
    return view.getFrameSize().width;
  }

  onLoad(): void {
    const prepared = claimPreparedFarm();
    try {
      if (!this.root || !this.map || !this.hud || !this.cropPlotPrefab || !this.shopPrefab)
        throw Error('Scene thiếu map, HUD, prefab ô đất hoặc Shop.');
      if (!this.uiPrefabs) throw Error('Scene thiếu thư viện prefab giao diện.');
      // Direct Play from Farm in the Editor still enters through the authored loading scene.
      const visibility = this.root.getComponent(UIOpacity) ?? this.root.addComponent(UIOpacity);
      const gameOpacity = visibility.opacity;
      visibility.opacity = 0;
      if (!prepared) {
        this.scheduleOnce(() => {
          const opened = director.loadScene('Loading', error => {
            if (error) console.error(error);
          });
          if (!opened) console.error('Không thể mở scene Loading.');
        });
        return;
      }
      this.art = prepared.art;
      this.account = prepared.account;
      this.ui = new Ui(this.art);
      this.tabHidden = prepared.isHidden();
      this.ui.prefabs = this.uiPrefabs;
      profiler.hideStats();
      // Never rotate the canvas with CSS; the layout adapts to whichever way the window is.
      if (sys.isBrowser) view.setOrientation(macro.ORIENTATION_AUTO);
      applyDesignResolution();
      view.on('canvas-resize', this.onCanvasResize, this);
      this.motion = !(globalThis as { matchMedia?: (q: string) => { matches: boolean } }).matchMedia?.(
        '(prefers-reduced-motion: reduce)'
      ).matches;
      cocosGame.on(CocosGame.EVENT_HIDE, this.onHide, this);
      cocosGame.on(CocosGame.EVENT_SHOW, this.onShow, this);
      input.on(Input.EventType.KEY_DOWN, this.keyDown, this);
      this.boot();
      visibility.opacity = gameOpacity;
      prepared.complete();
    } catch (error: unknown) {
      this.initialized = false;
      if (prepared) prepared.fail(error);
      else console.error(error);
    }
  }

  private boot(): void {
    const catalog = this.art.data.data;
    this.session = new GameSession(catalog, new FarmSave(accountStorage(sys.localStorage, this.account), catalog));
    this.session.hidden = this.tabHidden;
    this.motion = this.motion && this.session.runtime.ui.motionEnabled;
    this.session.on('toast', message => this.toast(message));
    this.session.on('paused', paused => {
      if (paused) this.audio.pauseMusic();
      else this.audio.startMusic();
    });
    this.session.on('saveFailed', () => {
      this.map?.cancelGesture();
      this.finishArrangement();
      this.audio.pauseMusic();
      this.refresh();
      this.panels.refresh(true);
    });
    this.session.on('replaced', () => {
      this.map?.cancelGesture();
      this.finishArrangement();
      // A farm without machines has nothing for the production navigation to point at.
      if (this.panels && !this.game.state.machines.length) this.panels.resetProductionNavigation();
    });
    this.audio = new AudioService(this.node, this.art, this.session);
    this.buildViews();
    this.initialized = true;
    this.refresh();
    if (this.session.recovered) {
      this.open('help');
      this.toast('Bản lưu đang lỗi. Dữ liệu cũ được giữ; nhập bản lưu hợp lệ để tiếp tục.');
    } else {
      this.session.save();
      if (this.session.storageFailed) this.open('help');
      else if (!this.game.state.guideDismissed) this.open('welcome');
    }
    if (DEBUG) installDebugApi(this);
    olaReady();
  }

  /** Child order is draw order: map, HUD, contextual footer, panels, toast. Widgets size everything to the canvas. */
  private buildViews(): void {
    this.art.shopFont = this.hud.level.font;
    // The scene owns the map and HUD. Bind their existing nodes so Editor changes survive Play.
    this.map.setup({
      ui: this.ui,
      art: this.art,
      getGame: () => this.game,
      cropPrefab: this.cropPlotPrefab!,
      inset: MAP_INSET,
      getSpeed: () => this.session.speed,
      canAnimate: () => this.session.canAct && !this.session.hidden,
      bubbles: {
        harvest: id => this.act({ type: 'harvest', plot: id }, 'Chon sp', () => this.closeCell()),
        unlock: id => this.open('improve', { improveId: id }),
        finish: id => this.act({ type: 'boost', plot: id }),
        cancel: id => this.act({ type: 'cancel', plot: id }, 'Cuoc dat', () => this.closeCell()),
      },
      callbacks: {
        onPlot: id => this.clickPlot(id),
        onMachine: id => this.open('factory', { machineId: id }),
        onFacility: view => this.openByName(view),
        onLongPress: () => this.enterArrangement(true),
        onMoveEnd: cancelled => this.dropBuilding(cancelled),
        isBlocked: () => !!this.panels?.view,
      },
    });
    this.map.model.motion = this.motion;
    this.map.focusHome();
    this.hud.setup(this.ui, { pause: () => this.open('pause'), open: view => this.open(view) });
    this.footer = new ContextualFooter(this, this.root);
    const overlay = this.ui.fill(this.root, 'Panels');
    this.panels = overlay.addComponent(PanelHost);
    this.panels.setup(this, this.shopPrefab!);
    const toastNode = this.ui.box(this.root, 'Toast', 0, 0, 640, 42, new Color(41, 79, 62, 238), 10);
    this.toastView = toastNode.addComponent(ToastView);
    this.toastView.setup(this.ui, this.session.runtime.ui.toastSeconds);
    this.root.on(Node.EventType.SIZE_CHANGED, this.onRootResize, this);
    this.map.update();
    this.refresh();
  }

  private onCanvasResize(): void {
    applyDesignResolution();
  }

  /** Widgets already moved the HUD; only the code-sized footer and toast need a second pass, done in update(). */
  private onRootResize(): void {
    this.layoutDirty = true;
  }

  toast(message: string): void {
    if (!this.toastView?.isValid) return;
    this.toastView.show(message, this.width);
    this.hud.setHint('');
    this.placeToast();
  }

  placeToast(): void {
    if (!this.toastView) return;
    if (this.panels?.view === 'shop') {
      // Follow the responsive drawer so purchase feedback leaves its cards and prices clear.
      const back = this.ui.controls.get('shop-production-return');
      const top = back?.activeInHierarchy ? back : this.ui.controls.get('shop-tab-animals');
      if (top) {
        const bounds = top.getComponent(UITransform)!.getBoundingBoxToWorld();
        const rootTransform = this.root.getComponent(UITransform)!;
        const bottom =
          this.root.worldPosition.y - rootTransform.height * rootTransform.anchorY * this.root.worldScale.y;
        this.toastView.placeAt(Math.min(this.height - 32, (bounds.yMax - bottom) / this.root.worldScale.y + 32));
        return;
      }
    }
    this.toastView.placeAt(
      this.panels?.view ? TOAST_ABOVE_PANEL : this.footer?.occupied ? TOAST_ABOVE_FOOTER : TOAST_ABOVE_NAVIGATION
    );
  }

  act(action: FarmAction, sound = 'Click 1', after?: () => void): boolean {
    if (!this.session.canDispatch(action)) {
      this.toast(this.session.blockedMessage);
      return false;
    }
    const { ok, result } = this.session.dispatch(action);
    if (result.error) {
      this.toast(result.error);
      this.audio.sfx('Canh bao button');
      return false;
    }
    if (!ok) {
      this.refresh();
      this.panels.refresh(true);
      return false;
    }
    if (action.type === 'plant' && result.plot) {
      // Unity's StartPlanting feedback is the seed cost rising from the selected plot.
      this.toastView.hide();
      this.map.effect('-' + (this.game.farm(result.plot.crop!)?.price ?? 0), result.plot.id);
    } else if (result.message) this.toast(result.message);
    if (result.plot && result.amount) this.map.effect(`+${result.amount}`, result.plot.id);
    this.audio.sfx(sound);
    after?.();
    this.refresh();
    this.panels.refresh(true);
    return true;
  }

  private clickPlot(id: number | null): void {
    this.audio.startMusic();
    if (id === null) this.closeCell();
    else this.tapPlot(id);
  }

  /** One routing for map taps and plot-list rows: ripe beds harvest, resident pens open the herd, locked slots offer the upgrade. */
  tapPlot(id: number): void {
    if (!this.session.canAct) {
      this.toast(this.session.blockedMessage);
      return;
    }
    const p = this.game.state.plots.find(plot => plot.id === id);
    if (!p || !this.game.isActivePlot(p)) return;
    // Only the first unowned crop is offered on the map and in the plot list.
    if (this.game.simple && p.group === 'crop' && !p.unlocked && this.game.nextLockedCrop()?.id !== id) return;
    const pen = penDefinition(this.game.catalog, p);
    if (pen) {
      if (!p.residents) {
        this.open('shop', { shopTab: 'animals', shopItem: 'shop-animal-' + id, penId: id });
        return;
      }
      if (this.map.cameraState().mode !== 'manual') this.map.focusBuilding(penBuildingId(pen));
      // A constructed pen opens its management panel directly; the map quick bar duplicated it.
      this.open('livestock', { penId: id });
      return;
    }
    if (this.game.isReady(p)) {
      this.act({ type: 'harvest', plot: id }, 'Chon sp', () => this.closeCell());
      return;
    }
    if (!p.unlocked) {
      this.open('improve', { improveId: id });
      return;
    }
    this.panels.hide();
    this.selected = id;
    this.map.selected = id;
    this.map.selectedMachine = null;
    this.footer.render();
  }

  /** Deselect the plot and drop whatever strip described it. */
  closeCell(): void {
    this.selected = null;
    if (this.map) {
      this.map.selected = null;
      this.map.selectedMachine = null;
    }
    this.footer?.clear();
    this.hud?.setNavigationVisible(true);
    this.placeToast();
  }

  /** Drop the seed picker without clearing the selection: the plot keeps its bubble on the map. */
  clearCell(): void {
    this.footer.clear();
    this.hud.setNavigationVisible(true);
    this.placeToast();
  }

  /** Map facilities name their panel as a string, optionally with a machine type: `industry:3`. */
  private openByName(name: string): void {
    const [view, argument] = name.split(':');
    if (!isPanelView(view)) {
      this.toast('Mục này chưa có trong nông trại hiện tại.');
      return;
    }
    this.open(view, argument === undefined ? {} : { machineType: Number(argument) });
  }

  open(view: PanelView, options: OpenOptions = {}): void {
    if (view === 'factory' && !this.game.state.machines.length) {
      // No machine yet: the factory entry points lead to the shop's building tab instead.
      view = 'shop';
      options = { ...options, shopTab: 'buildings' };
    }
    if (this.map.movement.active) this.finishArrangement();
    this.panels.prepare(options);
    this.map.cancelGesture();
    this.closeCell();
    this.audio.sfx();
    if (view === 'pause') this.session.enterMenu();
    this.panels.show(view);
    if (view === 'factory')
      this.map.selectedMachine = this.game.state.machines.find(m => m.id === this.panels.machineId)?.buildingId ?? null;
    else if (view === 'industry') {
      const type = this.game.machineTypes.find(t => t.id === this.panels.machineTypeId);
      this.map.selectedMachine = type ? (machineSites(type)[0] ?? null) : null;
    }
    this.refresh();
  }

  close(): void {
    if (this.map.movement.active) {
      this.finishArrangement();
      return;
    }
    this.closeCell();
    this.panels.close(() => {
      this.session.leaveMenu();
      this.audio.startMusic();
      this.refresh();
    });
  }

  focusHome(): void {
    this.map.focusHome();
  }
  focusBuilding(id: string): void {
    this.map.focusBuilding(id);
  }
  canFocusBuilding(id: string | null): boolean {
    return this.map.hasAnchor(id);
  }

  beginArrangement(): void {
    this.enterArrangement();
  }

  private enterArrangement(preserveGesture = false): boolean {
    if (!this.session.beginLayout()) return false;
    this.panels.hide();
    this.closeCell();
    if (!preserveGesture) this.map.cancelGesture();
    this.directArrangement = preserveGesture;
    this.map.movement.start();
    this.toastView.hide();
    this.footer.render();
    this.refresh();
    return true;
  }

  finishArrangement(preserveGesture = false): void {
    if (!this.map?.movement.active) return;
    this.map.movement.finish();
    if (!preserveGesture) this.map.cancelGesture();
    this.directArrangement = false;
    this.session.endLayout();
    this.closeCell();
    this.refresh();
  }

  private dropBuilding(cancelled: boolean): void {
    const movement = this.map.movement;
    if (!movement.active) return;
    if (!cancelled && movement.changed) {
      if (movement.error) this.toast(movement.error);
      else if (movement.canPlace)
        this.act({ type: 'moveBuilding', building: movement.selected!, position: { ...movement.candidate! } });
    }
    // End a direct hold immediately, including invalid drops. Keep both pinch pointers alive.
    if (this.directArrangement) this.finishArrangement(true);
    else movement.cancel();
  }

  restart(): void {
    if (!this.session.restart()) return;
    this.panels.resetProductionNavigation();
    this.panels.hide();
    this.closeCell();
    this.map.focusHome();
    this.refresh();
    this.audio.startMusic();
  }

  setSpeed(speed: number): void {
    if (this.session.setSpeed(speed)) this.panels.refresh(true);
  }

  toggleAudio(kind: AudioKind): void {
    const on = this.session.toggleAudio(kind);
    if (kind === 'music' && !on) this.audio.stopMusic();
    this.audio.sfx();
    this.panels.refresh(true);
  }

  retrySave(): void {
    if (this.session.retrySave()) {
      this.refresh();
      this.panels.refresh(true);
    }
  }

  save(): void {
    this.session.save();
  }

  exportSave(kind: SaveExport = 'current'): void {
    const text = this.session.exportSource(kind);
    if (!text) {
      this.toast('Chưa có dữ liệu này để xuất.');
      return;
    }
    if (downloadJson(text, `ola-farm-${kind}-save.json`)) this.toast('Đã xuất bản lưu.');
    else this.open('save-text', { saveText: text });
  }

  importSave(): void {
    const opened = pickJsonFile(
      text => this.importText(text),
      () => this.toast('File quá lớn.')
    );
    if (!opened) this.open('save-text', { saveText: '' });
  }

  importText(text: string): void {
    try {
      this.session.importText(text);
      this.audio.stopMusic();
      this.close();
      this.map.focusHome();
      this.toast('Đã khôi phục nông trại.');
    } catch (error) {
      this.toast(`Không thể nhập: ${(error as Error).message}`);
    }
  }

  private hintFor(p: Plot | undefined): string {
    if (!p) return 'Chạm ô đất để chọn giống';
    if (penDefinition(this.game.catalog, p))
      return p.residents ? 'Chạm chuồng để xem thông tin đàn' : 'Chạm để xem điều kiện xây chuồng';
    if (p.crop) {
      const name = this.game.farm(p.crop)?.name ?? '';
      const status = this.game.isReady(p)
        ? 'Chạm để thu hoạch'
        : countdown(remainingSeconds(p.ready, this.game.state.time, this.session.speed));
      return `${name} · ${status}`;
    }
    return p.unlocked ? 'Chạm ô để chọn giống' : 'Chạm ô để cải tạo';
  }

  refresh(): void {
    if (!this.initialized) return;
    this.hud.refresh(this.session);
    const hovered = this.game.state.plots.find(p => p.id === this.map.hovered);
    const busy = this.map.movement.active || this.panels.view || this.selected !== null || this.toastView.visible;
    this.hud.setHint(busy ? '' : this.hintFor(hovered));
    this.placeToast();
    this.footer.render();
  }

  update(dt: number): void {
    if (!this.initialized || this.session.hidden) return;
    if (this.skipDelta) {
      this.skipDelta = false;
      return;
    }
    this.session.tick(dt);
    if (this.layoutDirty) {
      this.layoutDirty = false;
      this.footer.invalidate();
      this.placeToast();
    }
    this.footer.render();
    this.toastView.tick(dt);
    this.elapsed += dt;
    if (this.elapsed >= this.session.runtime.ui.refreshSeconds) {
      this.elapsed = 0;
      this.refresh();
      this.panels.refresh();
      // Some browsers resize without a view event; the check is a cheap string compare.
      applyDesignResolution();
    }
  }

  /** The tab can be hidden while assets still load; remember it so the session starts frozen. */
  onHide(): void {
    this.tabHidden = true;
    if (!this.initialized) return;
    this.finishArrangement();
    this.session.suspend();
    this.map.cancelGesture();
    this.audio.pauseMusic();
  }

  onShow(): void {
    this.tabHidden = false;
    if (!this.initialized) return;
    this.session.resume();
    this.skipDelta = true;
    this.audio.startMusic();
    this.refresh();
    this.panels.refresh();
  }

  private keyDown(e: EventKeyboard): void {
    if (!this.initialized || this.panels?.view === 'save-text') return;
    if (e.keyCode === KeyCode.ESCAPE) this.map.cancelGesture();
    if (this.map.movement.active) {
      if (e.keyCode === KeyCode.ESCAPE) {
        if (this.map.movement.selected) {
          this.map.cancelGesture();
          this.map.movement.cancel();
        } else this.finishArrangement();
      }
      return;
    }
    if (e.keyCode === KeyCode.ESCAPE) {
      if (this.panels.view === 'restart-confirm') this.open('pause');
      else this.close();
      return;
    }
    if (e.keyCode === KeyCode.SPACE && !this.session.realTime && !this.panels.view && !this.session.storageFailed) {
      this.session.togglePause();
      this.refresh();
    }
  }

  onDestroy(): void {
    this.session?.save();
    cocosGame.off(CocosGame.EVENT_HIDE, this.onHide, this);
    cocosGame.off(CocosGame.EVENT_SHOW, this.onShow, this);
    input.off(Input.EventType.KEY_DOWN, this.keyDown, this);
    view.off('canvas-resize', this.onCanvasResize, this);
    this.session?.removeAllListeners();
    this.art?.dispose();
    if (DEBUG) uninstallDebugApi();
  }
}
