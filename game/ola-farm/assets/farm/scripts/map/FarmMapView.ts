import type { ScreenPoint, MapTarget, BuildingTarget, MapCallbacks, MapSetup } from './types/FarmMapView.types';
import { FIELD_COUNT, LIVESTOCK_CELLS, LIVESTOCK_FIRST_CELL } from './constants/MapLayout.constants';
import { GRASS_TILE, GRASS_TEXTURE, MAX_MARGIN_TREES, MAX_MARGIN_ROCKS } from './constants/FarmMapView.constants';
import { runtimeConfig } from '../core/FarmRuntime';
import { penDefinition, penBuildingId, penPlotId } from '../core/FarmCatalog';
import {
  _decorator,
  Component,
  Node,
  Mask,
  UITransform,
  EventTouch,
  EventMouse,
  Vec2,
  Vec3,
  Rect,
  Graphics,
  Color,
  Sprite,
  tween,
  UIOpacity,
  Prefab,
  instantiate,
  director,
} from 'cc';
import { Art } from '../render/Art';
import { Ui } from '../render/Ui';
import { herdBarTop } from '../render/Metrics';
import { FarmGame } from '../core/FarmGame';
import { machineSites } from '../core/FarmCatalog';
import { FarmModel } from './FarmModel';
import { FarmItemLibrary } from './assets/FarmItemLibrary';
import { FarmMapLayout } from './layout/FarmMapLayout';
import { FacilityTrigger } from './buildings/FacilityTrigger';
import { FarmItems } from './FarmItems';
import { PlotBubbles } from './crops/PlotBubbles';

import { FarmTownViews } from './buildings/FarmTownViews';
import { herdHitBox } from './buildings/HerdPresentation';
import { MapCamera } from './camera/MapCamera';
import type { CameraState } from './camera/MapCamera.types';
import type { CellGeometry, DrawWidget, MapBounds } from '../render/types/MapTypes';
import type { ForestConfig } from './layout/ForestLayout.types';
import { forestPlacements, rockPlacements, insideBounds } from './layout/ForestLayout';
import { BuildingMoveController } from './buildings/BuildingMoveController';
import { FARM_LAYOUT, canMoveBuilding, layoutKey } from '../core/BuildingPlacement';
import { EMPTY_LAYOUT } from '../core/constants/PlacementDefaults';
import { translated } from '../core/BuildingGeometry';

const { ccclass, property } = _decorator;

const dispose = (node: Node): void => {
  node.active = false;
  node.destroy();
};
const linkedPrefab = (node: Node | undefined): boolean =>
  !!(node as unknown as { prefab?: { asset?: unknown } } | undefined)?.prefab?.asset;

/**
 * The scrollable farm: an authored Farm prefab, live crops/animals/buildings drawn over it and a gesture camera.
 * The node is sized by its Widget; a size change recomputes the fit instead of rebuilding the scene.
 */
@ccclass('FarmMapView')
export class FarmMapView extends Component {
  @property(Node) world: Node = null!;
  @property(Node) authoredMap: Node = null!;
  model!: FarmModel;
  camera!: MapCamera;
  selected: number | null = null;
  selectedMachine: string | null = null;
  hovered: number | null = null;

  private ui!: Ui;
  private art!: Art;
  private getGame!: () => FarmGame;
  private getSpeed: () => number = () => 1;
  private canAnimate: () => boolean = () => true;
  private presentationTime = 0;
  private callbacks!: MapCallbacks;
  private inset = { top: 0, bottom: 0 };
  private layout!: FarmMapLayout;
  private staticRoot!: Node;
  private liveRoot!: Node;
  private selection!: Node;
  private itemRenderer!: FarmItems;
  /** Golden Island's plot bubbles; they live above every crop and animal in the same world node. */
  bubbles!: PlotBubbles;
  /** Farm Town buildings, yards and resident animals; exposed for diagnostics and tests. */
  town!: FarmTownViews;
  movement!: BuildingMoveController;
  private placementKey = '';
  private movableFacilities: { node: Node; bounds: Rect; depth: number }[] = [];
  private standingScenery: { node: Node; depth: number }[] = [];
  private placementOutline!: Node;
  private facilities: FacilityTrigger[] = [];
  private touches = new Map<number, Vec2>();
  private startPoint = new Vec2();
  private moved = false;
  private pendingLongPress: { pointer: number; building: string } | null = null;
  private commands: DrawWidget[] = [];
  private sceneryCamera = '';
  private marginScenery: Node[] = [];
  private decor: { node: Node; bounds: Rect; depth: number }[] = [];
  /** Source visibility is independent of camera culling after the Editor region parents are flattened. */
  private hiddenDecor = new Set<Node>();
  private groundDecor: { node: Node; bounds: Rect }[] = [];
  private grassTiles: Node[] = [];
  /** Set by SIZE_CHANGED; applied in update() so node creation and disposal happen inside the update phase. */
  private resizePending = false;
  /** A browser hiding its URL bar fires a burst of sizes; one rebuild after the last one is enough. */
  private resizeDelay = 0;

  private get runtime() {
    return runtimeConfig(this.getGame?.().catalog);
  }
  get width(): number {
    return this.getComponent(UITransform)!.width;
  }
  get height(): number {
    return this.getComponent(UITransform)!.height;
  }
  get zoom(): number {
    return this.camera.zoom;
  }
  get minZoom(): number {
    return this.camera.minZoom;
  }
  get scale(): number {
    return this.camera.scale;
  }
  get pan(): Vec2 {
    return this.camera.pan;
  }
  private get worldTransform(): UITransform {
    return this.world.getComponent(UITransform)!;
  }

  setup(options: MapSetup): void {
    if (!this.world || !this.authoredMap) throw Error('FarmMapView thiếu World hoặc instance Farm trong scene.');
    this.ui = options.ui;
    this.art = options.art;
    this.getGame = options.getGame;
    this.callbacks = options.callbacks;
    this.inset = options.inset;
    this.getSpeed = options.getSpeed;
    this.canAnimate = options.canAnimate;
    if (!this.getComponent(Mask)) this.addComponent(Mask);
    this.staticRoot = this.ui.node(this.world, 'Scenery', 0, 0, 1, 1);
    this.liveRoot = this.ui.node(this.world, 'PlantsAndAnimals', 0, 0, 1, 1);
    this.selection = this.ui.node(this.world, 'SelectedPlot', 0, 0, 1, 1);
    this.placementOutline = this.ui.node(this.world, 'BuildingFootprints', 0, 0, 1, 1);
    // Added last so a bubble always draws over the crops and animals below it.
    this.bubbles = new PlotBubbles(
      this.ui.node(this.world, 'PlotBubbles', 0, 0, 1, 1),
      this.ui,
      this.art,
      options.bubbles
    );
    this.movement = new BuildingMoveController(() => this.getGame().state);
    this.staticRoot.addChild(this.authoredMap);
    const layout = this.authoredMap.getComponent(FarmMapLayout),
      library = this.authoredMap.getComponent(FarmItemLibrary);
    if (!layout || !library) throw Error('scenes.prefab thiếu component FarmMapLayout hoặc FarmItemLibrary.');
    if (
      layout.fields.length !== FIELD_COUNT ||
      layout.livestock.length !== LIVESTOCK_CELLS ||
      layout.additionalPens.length !== 4 ||
      !layout.buildings ||
      !layout.scenery ||
      !layout.grass ||
      !layout.decor ||
      !layout.groundDecor
    ) {
      throw Error('FarmMapLayout chưa liên kết đủ anchor; chạy node tools/link-prefab-components.cjs.');
    }
    this.layout = layout;
    const forest = library.forestConfig?.json as ForestConfig | undefined;
    if (!forest || forest.species.length !== library.scenery.length)
      throw Error('FarmItemLibrary thiếu cấu hình hoặc prefab loài cây.');
    if (!forest.rocks || forest.rocks.types.length !== library.rocks.length || library.rocks.some(p => !p))
      throw Error('FarmItemLibrary thiếu prefab đá; chạy node tools/plant-forest.cjs.');
    if (library.roads.length !== 16 || library.roads.some(p => !p))
      throw Error('FarmItemLibrary thiếu 16 prefab đường; chạy node tools/farm-layout.cjs.');
    // Shared parent lets front fences/trees occlude a crop or animal correctly instead of always sitting behind it.
    const regions = new Set(layout.decorRegions);
    if (regions.size !== layout.decorRegions.length || layout.decorRegions.some(node => node.parent !== layout.decor)) {
      throw Error('FarmMapLayout decorRegions phải liên kết các vùng riêng trong Decor.');
    }
    const placements = [
      ...layout.decor.children.filter(node => !regions.has(node)),
      ...layout.decorRegions.flatMap(region => [...region.children]),
    ];
    for (const node of placements) {
      for (let parent: Node | null = node; parent && parent !== this.world; parent = parent.parent) {
        if (!parent.active) {
          this.hiddenDecor.add(node);
          break;
        }
      }
      node.setParent(this.liveRoot, true);
      if (this.hiddenDecor.has(node)) node.active = false;
    }
    // Region prefabs are Editor boundaries. Restore the same global ground order after flattening their holders.
    placements.sort((a, b) => b.position.y - a.position.y || a.position.x - b.position.x);
    for (const node of placements) {
      this.decor.push({
        node,
        bounds: node.getComponent(UITransform)!.getBoundingBox(),
        depth: 1000 - node.position.y,
      });
    }
    this.groundDecor = layout.groundDecor.children.map(node => ({
      node,
      bounds: node.getComponent(UITransform)!.getBoundingBox(),
    }));
    this.itemRenderer = new FarmItems(this.liveRoot, options.cropPrefab, library, this.art.prefabs);
    const townOverlay = this.ui.node(this.world, 'HerdBubbles', 0, 0, 1, 1);
    this.town = new FarmTownViews(
      this.liveRoot,
      townOverlay,
      this.art,
      this.ui,
      new Map(layout.buildings.children.map(n => [n.name, n])),
      id => this.movement.position(id)
    );
    this.facilities = this.authoredMap.getComponentsInChildren(FacilityTrigger);
    for (const trigger of this.facilities) {
      trigger.node.setParent(this.liveRoot, true);
      this.movableFacilities.push({
        node: trigger.node,
        bounds: trigger.node.getComponent(UITransform)!.getBoundingBox(),
        depth: 1000 - trigger.node.position.y,
      });
    }
    // Fixed standing objects still occlude a moved building behind them; the pond remains on the ground layer.
    for (const id of ['MainObject-gieng', 'MainObject-xay gio', 'MainObject-chuong cho']) {
      const node = layout.scenery.getChildByName(id),
        ground = FARM_LAYOUT.obstacles.find(o => o.id === id);
      if (!node || !ground) throw Error('Thiếu cảnh đứng cố định: ' + id);
      node.setParent(this.liveRoot, true);
      this.standingScenery.push({
        node,
        depth: 1000 - ground.polygon.reduce((sum, p) => sum + p.y, 0) / ground.polygon.length,
      });
    }
    const size = this.authoredMap.getComponent(UITransform)!,
      center = layout.grass.position;
    const bounds: MapBounds = {
      left: center.x - size.width / 2,
      right: center.x + size.width / 2,
      bottom: center.y - size.height / 2,
      top: center.y + size.height / 2,
    };
    this.model = new FarmModel(
      this.art.data.scene,
      this.art.data.runtime,
      this.getGame,
      this.readCells(layout),
      bounds,
      id => this.movement.position(id)
    );
    // Anchors retain all 40 soils for editing. Runtime ownership is drawn by FarmItems only.
    for (const field of layout.fields) field.active = false;
    this.camera = new MapCamera(this.world, this.model.center, this.runtime.camera);
    this.buildScenery();
    this.focusHome();
    this.bindGestures();
    this.node.on(Node.EventType.SIZE_CHANGED, this.onResize, this);
  }

  /** Authored anchors become runtime cells: the exported geometry with the prefab's position, size and scale. */
  private readCells(layout: FarmMapLayout): CellGeometry[] {
    const anchors = [...layout.fields, ...layout.livestock, ...layout.additionalPens];
    return anchors.map((anchor, i) => {
      const source =
        this.art.data.scene.cells[
          i < FIELD_COUNT
            ? 0
            : i < FIELD_COUNT + LIVESTOCK_CELLS
              ? i - FIELD_COUNT + LIVESTOCK_FIRST_CELL
              : LIVESTOCK_FIRST_CELL
        ];
      const transform = anchor.getComponent(UITransform)!;
      const origin = this.worldTransform.convertToNodeSpaceAR(anchor.worldPosition);
      // Cells live in World coordinates; the Editor preview/camera scale must not be baked into their size.
      const sx = anchor.worldScale.x / this.world.worldScale.x,
        sy = anchor.worldScale.y / this.world.worldScale.y;
      return {
        ...source,
        plotId:
          i >= FIELD_COUNT + LIVESTOCK_CELLS
            ? penPlotId(
                this.getGame().catalog.residentPens!.filter(p => penPlotId(p) >= 50)[i - FIELD_COUNT - LIVESTOCK_CELLS]
              )
            : undefined,
        widget: { ...source.widget, width: transform.width, height: transform.height },
        matrix: [sx, 0, 0, sy, origin.x, origin.y],
        collider: i < FIELD_COUNT ? { center: [0, 0], size: [transform.width, transform.height] } : source.collider,
      };
    });
  }

  private bindGestures(): void {
    this.node.on(Node.EventType.TOUCH_START, (e: EventTouch) => {
      if (this.callbacks.isBlocked()) return;
      const id = e.getID();
      if (id === null) return;
      if (!this.touches.size) {
        this.cancelLongPress();
        this.startPoint.set(e.getUILocation());
        this.moved = false;
      }
      this.touches.set(id, e.getUILocation().clone());
      if (this.touches.size > 1) {
        this.cancelLongPress();
        this.moved = true;
        this.endBuildingDrag(true);
      } else if (this.movement.active) {
        const p = this.toWorld(e.getUILocation()),
          hit = this.moveTarget(p);
        if (hit) {
          if (hit !== this.movement.selected) this.movement.select(hit);
          this.movement.grab(p);
        }
      } else {
        const point = this.toWorld(e.getUILocation());
        const hit = this.town.topBadgeTarget(point) === null ? this.moveTarget(point) : undefined;
        if (hit) {
          this.pendingLongPress = { pointer: id, building: hit };
          this.scheduleOnce(this.activateLongPress, this.runtime.input.longPressSeconds);
        }
      }
    });
    this.node.on(Node.EventType.TOUCH_MOVE, (e: EventTouch) => {
      if (this.callbacks.isBlocked()) {
        this.cancelGesture();
        return;
      }
      const id = e.getID()!,
        prev = this.touches.get(id);
      if (!prev) return;
      const point = e.getUILocation();
      if (this.touches.size >= 2) {
        const other = Array.from(this.touches).find(([k]) => k !== id)![1],
          d = Vec2.distance(prev, other);
        if (d > 1) this.camera.setZoom((this.camera.zoom * Vec2.distance(point, other)) / d);
        this.moved = true;
      } else {
        if (Vec2.distance(this.startPoint, point) > this.runtime.input.mapDragSlop) {
          this.cancelLongPress();
          this.moved = true;
        }
        if (this.moved) {
          if (this.movement.dragging) this.movement.drag(this.toWorld(point));
          else this.camera.panBy(point.x - prev.x, point.y - prev.y);
        }
      }
      this.touches.set(id, point.clone());
    });
    this.node.on(Node.EventType.TOUCH_END, (e: EventTouch) => {
      if (this.callbacks.isBlocked()) {
        this.cancelGesture();
        return;
      }
      if (!this.touches.has(e.getID()!)) return;
      this.cancelLongPress();
      const click = !this.moved && this.touches.size === 1;
      this.touches.delete(e.getID()!);
      if (this.movement.dragging && Vec2.distance(this.startPoint, e.getUILocation()) > this.runtime.input.mapDragSlop)
        this.movement.drag(this.toWorld(e.getUILocation()));
      this.endBuildingDrag(false);
      if (click) this.tap(e.getUILocation());
    });
    this.node.on(Node.EventType.TOUCH_CANCEL, () => this.cancelGesture());
    this.node.on(Node.EventType.MOUSE_WHEEL, (e: EventMouse) => {
      if (this.callbacks.isBlocked()) return;
      this.cancelGesture();
      this.camera.setZoom(
        this.camera.zoom *
          (e.getScrollY() > 0 ? this.runtime.input.wheelZoomStep : 1 / this.runtime.input.wheelZoomStep)
      );
    });
    this.node.on(Node.EventType.MOUSE_MOVE, (e: EventMouse) => {
      const world = this.toWorld(e.getUILocation());
      this.hovered = this.plotTarget(world)?.id ?? null;
    });
    this.node.on(Node.EventType.MOUSE_LEAVE, () => {
      this.hovered = null;
      if (this.pendingLongPress) this.cancelGesture();
    });
  }

  private cancelLongPress(): void {
    this.pendingLongPress = null;
    this.unschedule(this.activateLongPress);
  }

  private activateLongPress(): void {
    const hold = this.pendingLongPress;
    this.pendingLongPress = null;
    if (
      !hold ||
      !this.enabledInHierarchy ||
      this.moved ||
      this.touches.size !== 1 ||
      this.movement.active ||
      this.callbacks.isBlocked()
    )
      return;
    const point = this.touches.get(hold.pointer);
    if (!point || !canMoveBuilding(this.getGame().state, hold.building) || !this.callbacks.onLongPress()) return;
    this.movement.select(hold.building);
    this.movement.grab(this.toWorld(point));
    // Swallow the eventual release, even if the player holds still after activation.
    this.moved = true;
  }

  onDisable(): void {
    this.cancelGesture();
  }

  private toWorld(p: Vec2): Vec3 {
    return this.worldTransform.convertToNodeSpaceAR(new Vec3(p.x, p.y));
  }

  private tap(point: Vec2): void {
    const world = this.toWorld(point);
    if (this.movement.active) return;
    const badge = this.town.topBadgeTarget(world);
    if (badge !== null) {
      if ('plot' in badge) {
        this.callbacks.onPlot(badge.plot);
        return;
      }
      const target = this.buildingTargets().find(t => t.buildingId === badge.building);
      if (target) {
        this.activateBuilding(target);
        return;
      }
    }
    const building = this.buildingTargets()
      .sort((a, b) => this.buildingGroundY(a.buildingId) - this.buildingGroundY(b.buildingId))
      .find(t => Math.abs(world.x - t.x) <= t.w / 2 && Math.abs(world.y - t.y) <= t.h / 2);
    const target = this.plotTarget(world);
    const plotGround = penDefinition(this.getGame().catalog, target)
      ? this.movement.position('pen:' + target!.id).y
      : target?.y;
    if (building && (plotGround === undefined || this.buildingGroundY(building.buildingId) <= plotGround)) {
      this.activateBuilding(building);
      return;
    }
    this.callbacks.onPlot(target?.id ?? null);
  }

  private activateBuilding(building: BuildingTarget): void {
    const machine = FARM_LAYOUT.buildings.find(b => b.id === building.buildingId)?.kind === 'machine';
    if (machine && this.camera.mode !== 'manual') this.focusBuilding(building.buildingId);
    if (building.view) this.callbacks.onFacility(building.view);
    else if (typeof building.id === 'number') this.callbacks.onMachine(building.id);
    this.selectedMachine = machine ? building.buildingId : null;
  }

  private buildingGroundY(id: string): number {
    return this.movement.position(id).y + FARM_LAYOUT.buildings.find(b => b.id === id)!.depthOffset;
  }

  /** Beds are tapped as diamonds, pens and ponds as rectangles. */
  private contains(t: MapTarget, p: Vec3): boolean {
    return this.getGame().state.plots.find(plot => plot.id === t.id)?.group === 'crop'
      ? Math.abs(p.x - t.x) / (t.w / 2) + Math.abs(p.y - t.y) / (t.h / 2) <= 1
      : Math.abs(p.x - t.x) <= t.w / 2 && Math.abs(p.y - t.y) <= t.h / 2;
  }

  private plotTarget(point: Vec3): MapTarget | undefined {
    const hits = this.targets()
        .reverse()
        .filter(t => this.contains(t, point)),
      first = hits[0];
    const pens = new Set(this.getGame().catalog.residentPens?.map(penPlotId));
    if (!first || !pens.has(first.id)) return first;
    // Enlarged pen rectangles can overlap: choose the front yard, as holding to move already does.
    return hits
      .filter(t => pens.has(t.id))
      .sort((a, b) => this.movement.position('pen:' + a.id).y - this.movement.position('pen:' + b.id).y)[0];
  }

  private endBuildingDrag(cancelled: boolean): void {
    if (!this.movement?.dragging) return;
    this.movement.release();
    this.callbacks.onMoveEnd(cancelled);
  }

  cancelGesture(): void {
    this.cancelLongPress();
    this.touches.clear();
    this.moved = true;
    this.endBuildingDrag(true);
  }

  private moveTarget(p: Vec3): string | undefined {
    const state = this.getGame().state;
    const candidates = this.buildingTargets()
      .filter(t => canMoveBuilding(state, t.buildingId))
      .map(t => ({ id: t.buildingId, x: t.x, y: t.y, w: t.w, h: t.h, depth: this.buildingGroundY(t.buildingId) }));
    for (const b of FARM_LAYOUT.buildings.filter(b => b.kind === 'pen' && canMoveBuilding(state, b.id))) {
      const q = this.movement.position(b.id);
      const pen = this.getGame().catalog.residentPens?.find(spec => penBuildingId(spec) === b.id),
        hit = herdHitBox(pen?.species);
      candidates.push({ id: b.id, x: q.x, y: q.y + hit.y, w: hit.w, h: hit.h, depth: q.y });
    }
    return candidates
      .sort((a, b) => a.depth - b.depth)
      .find(t => Math.abs(p.x - t.x) <= t.w / 2 && Math.abs(p.y - t.y) <= t.h / 2)?.id;
  }

  /** Widgets resize this node during the engine's after-update phase; rebuilding there races the engine's own sibling sort. */
  private onResize(): void {
    this.cancelGesture();
    this.resizePending = true;
    this.resizeDelay = this.runtime.input.resizeSettleSeconds;
  }

  private applyResize(): void {
    const state = this.cameraState();
    this.buildScenery();
    this.restoreCamera(state);
  }

  /** The closest complete central-farm view is also the zoom-out limit; scenery fills panning margins. */
  private buildScenery(): void {
    const oldMargin = new Set(this.marginScenery);
    this.decor = this.decor.filter(entry => !oldMargin.has(entry.node));
    for (const node of this.marginScenery) dispose(node);
    for (const node of this.grassTiles) dispose(node);
    this.marginScenery = [];
    this.grassTiles = [];
    this.sceneryCamera = '';
    const b = this.model.bounds,
      camera = this.camera,
      width = this.width,
      height = this.height;
    camera.width = width;
    camera.height = height;
    camera.scale = Math.min(width / (b.right - b.left), height / (b.top - b.bottom));
    camera.minZoom = this.homeFit().zoom;
    camera.reach = { ...b };
    // Fitting above the footer may need extra pan even when the full-map zoom already fits.
    // Reserve that reach on every aspect ratio and continue the forest over any exposed edge.
    this.plantMargin();
    // Tiled grass still backs the margins so sub-pixel edges never show the canvas color.
    // Bound each tiled mesh so it fits Creator's UI vertex buffer.
    const left = b.left - width / camera.scale,
      right = b.right + width / camera.scale;
    const bottom = b.bottom - height / camera.scale,
      top = b.top + height / camera.scale;
    for (let x = left; x < right; x += GRASS_TILE)
      for (let y = bottom; y < top; y += GRASS_TILE) {
        const w = Math.min(GRASS_TILE, right - x),
          h = Math.min(GRASS_TILE, top - y);
        const grass = this.art.image(this.staticRoot, GRASS_TEXTURE, x + w / 2, y + h / 2, w, h, 'GrassMargin');
        grass.getComponent(Sprite)!.type = Sprite.Type.TILED;
        grass.setSiblingIndex(0);
        this.grassTiles.push(grass);
      }
  }

  /** Fit fields, yards, house and barn; the surrounding workshops remain reachable by panning. */
  private homeFit(): { zoom: number; bounds: MapBounds } {
    const game = this.getGame();
    const active = this.model
      .plotPositions()
      .filter(p => this.model.isVisiblePlot(p.plot))
      .map(p => {
        const pen = penDefinition(game.catalog, p.plot);
        if (!pen) return { ...p.cell.widget, matrix: p.cell.matrix };
        const b = this.town.penBounds(pen.species, p);
        return {
          width: b.right - b.left,
          height: b.top - b.bottom,
          matrix: [1, 0, 0, 1, (b.left + b.right) / 2, (b.top + b.bottom) / 2],
        };
      });
    const buildings = this.buildingTargets()
      .filter(t => FARM_LAYOUT.buildings.some(b => b.id === t.buildingId && b.kind === 'facility'))
      .map(t => ({ width: t.w, height: t.h, matrix: [1, 0, 0, 1, t.x, t.y] }));
    const b = this.model.widgetBounds([...active, ...buildings]);
    const free = this.height - this.inset.top - this.inset.bottom;
    const zoom = Math.min(
      this.camera.maxZoom,
      Math.min(
        this.width / (b.right - b.left + this.runtime.camera.homePadding),
        free / (b.top - b.bottom + this.runtime.camera.homePadding)
      ) / this.camera.scale
    );
    return { zoom, bounds: b };
  }

  /** Opening view of the central fields and yards, centered in the free area. */
  focusHome(): void {
    this.selectedMachine = null;
    // A saved pen/facility may have moved since the previous fit. Refresh its limit and reach
    // only when returning home, never while the player's held building is being dragged.
    if (Math.abs(this.homeFit().zoom - this.camera.minZoom) > 1e-8) this.buildScenery();
    const { zoom, bounds: b } = this.homeFit();
    this.camera.lookAt(
      (b.left + b.right) / 2,
      (b.top + b.bottom) / 2,
      Math.max(this.camera.minZoom, zoom),
      'home',
      (this.inset.bottom - this.inset.top) / 2
    );
  }

  focusBuilding(id: string): boolean {
    const building = FARM_LAYOUT.buildings.find(b => b.id === id);
    if (!building || !canMoveBuilding(this.getGame().state, id)) return false;
    this.selectedMachine = building.kind === 'machine' ? id : null;
    if (building.kind === 'pen' || building.kind === 'machine') {
      const bottom = building.kind === 'pen' ? Math.max(this.inset.bottom, herdBarTop(this.width)) : this.inset.bottom;
      const species = this.getGame().catalog.residentPens?.find(p => penBuildingId(p) === id)?.species;
      const prefab = this.getGame().machineTypes.find(type => machineSites(type).includes(id))?.prefab;
      const p = this.movement.position(id),
        freeWidth = this.width - 48,
        freeHeight = this.height - this.inset.top - bottom - 48;
      const boundsAt = (scale: number): MapBounds | undefined =>
        species
          ? this.town.penBounds(species, p, scale, true)
          : prefab
            ? this.town.machineBounds(prefab, p, scale, true)
            : undefined;
      // Fit the complete source model and status into the free area, even on short landscape screens.
      let lo = this.camera.minZoom * this.camera.scale,
        hi = Math.max(lo, this.runtime.camera.buildingFocusScale);
      for (let i = 0; i < 20; i++) {
        const scale = (lo + hi) / 2,
          bounds = boundsAt(scale);
        if (!bounds) break;
        if ((bounds.right - bounds.left) * scale <= freeWidth && (bounds.top - bounds.bottom) * scale <= freeHeight)
          lo = scale;
        else hi = scale;
      }
      const bounds = boundsAt(lo);
      if (bounds) {
        this.camera.lookAt(
          (bounds.left + bounds.right) / 2,
          (bounds.bottom + bounds.top) / 2,
          lo / this.camera.scale,
          'manual',
          (bottom - this.inset.top) / 2
        );
        return true;
      }
    }
    const p = this.movement.position(id);
    const facility = building.kind === 'facility';
    this.camera.lookAt(
      p.x,
      p.y + (facility ? -10 : 70),
      (facility ? this.runtime.camera.facilityFocusScale : this.runtime.camera.buildingFocusScale) / this.camera.scale,
      'manual',
      (this.inset.bottom - this.inset.top) / 2
    );
    return true;
  }

  hasAnchor(id: string | null): boolean {
    return id !== null && this.town.anchors.has(id) && canMoveBuilding(this.getGame().state, id);
  }

  buildingTargets(): BuildingTarget[] {
    const game = this.getGame(),
      transform = this.worldTransform;
    const screen = (x: number, y: number): ScreenPoint => {
      const p = transform.convertToWorldSpaceAR(new Vec3(x, y));
      return { x: p.x, y: p.y };
    };
    const machines = game.machineTypes.flatMap(type =>
      machineSites(type).flatMap((id): BuildingTarget[] => {
        if (!this.town.anchors.has(id) || !type.prefab) return [];
        const machine = game.state.machines.find(m => m.buildingId === id);
        if (!machine) return [];
        const b = this.town.machineArtBounds(type.prefab, this.movement.position(id));
        const x = (b.left + b.right) / 2,
          y = (b.bottom + b.top) / 2;
        return [
          { id: machine.id, buildingId: id, x, y, w: b.right - b.left, h: b.top - b.bottom, screen: screen(x, y) },
        ];
      })
    );
    const facilities = this.facilities.map((trigger): BuildingTarget => {
      const p = this.movement.position(trigger.id),
        y = p.y + trigger.offsetY;
      return {
        id: trigger.id,
        buildingId: trigger.id,
        view: trigger.view,
        x: p.x,
        y,
        w: trigger.hitWidth,
        h: trigger.hitHeight,
        screen: screen(p.x, y),
      };
    });
    return [...machines, ...facilities];
  }

  /** Reserve the fitted home view's pan and continue forest beyond the authored map where needed. */
  private plantMargin(): void {
    const library = this.authoredMap.getComponent(FarmItemLibrary)!;
    const config = library.forestConfig!.json as ForestConfig;
    const camera = this.camera,
      b = this.model.bounds,
      s = camera.scale * camera.minZoom,
      cx = this.model.center.x,
      cy = this.model.center.y;
    const halfW = this.width / s / 2,
      halfH = this.height / s / 2;
    const home = this.homeFit(),
      homeScale = home.zoom * camera.scale;
    const homeX = (home.bounds.left + home.bounds.right) / 2;
    const homeY = (home.bounds.bottom + home.bounds.top) / 2 - (this.inset.bottom - this.inset.top) / (2 * homeScale);
    // Allow the fitted farm to center in the HUD's free area. A view-sized reach alone locks pan
    // on short screens, pushing the upper yard under the HUD after the neighborhood grows.
    const reachW = halfW + Math.abs(homeX - cx),
      reachH = halfH + Math.abs(homeY - cy);
    camera.reach = {
      left: Math.min(b.left, cx - reachW),
      right: Math.max(b.right, cx + reachW),
      bottom: Math.min(b.bottom, cy - reachH),
      top: Math.max(b.top, cy + reachH),
    };
    const area = {
      left: camera.reach.left - 360,
      right: camera.reach.right + 360,
      bottom: camera.reach.bottom - 360,
      top: camera.reach.top + 360,
    };
    const plant = (p: { id: string; x: number; y: number; scale: number }, prefab: Prefab): void => {
      const holder = new Node(p.id);
      holder.layer = this.liveRoot.layer;
      this.liveRoot.addChild(holder);
      const item = instantiate(prefab),
        sourceSize = item.getComponent(UITransform)!;
      holder.setPosition(p.x, p.y);
      holder.setScale(p.scale, p.scale, 1);
      holder.addChild(item);
      const size = holder.addComponent(UITransform);
      size.setContentSize(sourceSize.contentSize);
      size.setAnchorPoint(sourceSize.anchorPoint);
      this.decor.push({ node: holder, bounds: size.getBoundingBox(), depth: 1000 - p.y });
      this.marginScenery.push(holder);
    };
    let trees = 0,
      rocks = 0;
    for (const tree of forestPlacements(area, config)) {
      if (insideBounds(tree.x, tree.y, b) || trees >= MAX_MARGIN_TREES) continue;
      plant(tree, library.scenery[tree.species]);
      trees++;
    }
    for (const rock of rockPlacements(area, config)) {
      if (insideBounds(rock.x, rock.y, b) || rocks >= MAX_MARGIN_ROCKS) continue;
      plant(rock, library.rocks[rock.kind]);
      rocks++;
    }
    this.sceneryCamera = '';
  }

  cameraState(): CameraState {
    return this.camera.state();
  }

  restoreCamera(state: CameraState): void {
    if (state.mode === 'home') this.focusHome();
    else if (state.mode === 'overview') this.focusHome();
    else this.camera.restoreManual(state);
  }

  targets(): MapTarget[] {
    const transform = this.worldTransform;
    return this.model
      .plotPositions()
      .filter(({ plot }) => this.model.isVisiblePlot(plot))
      .map(({ plot, cell, x, y }) => {
        const centerX = x + cell.collider.center[0] * cell.matrix[0],
          centerY = y + cell.collider.center[1] * cell.matrix[3];
        const screen = transform.convertToWorldSpaceAR(new Vec3(centerX, centerY));
        return {
          id: plot.id,
          cell: plot.cell,
          locked: !plot.unlocked,
          x: centerX,
          y: centerY,
          w: cell.collider.size[0] * Math.abs(cell.matrix[0]),
          h: cell.collider.size[1] * Math.abs(cell.matrix[3]),
          screen: { x: screen.x, y: screen.y },
        };
      });
  }

  /** Floating number over a plot: seed cost when planting, yield when harvesting. */
  effect(text: string, id: number): void {
    const p = this.model.plotPositions().find(position => position.plot.id === id);
    if (!p) return;
    const scale = this.camera.displayScale;
    const label = this.ui.text(this.world, 'PlotFeedback', text, p.x, p.y + 45, 180, 65, 34);
    label.font = this.art.plotFont;
    label.color = Color.WHITE;
    // Cost and harvest feedback stays legible at the opening view as well as when zoomed in.
    label.node.setScale(1 / scale, 1 / scale, 1);
    const opacity = label.node.addComponent(UIOpacity);
    tween(opacity).to(1.5, { opacity: 0 }).start();
    tween(label.node)
      .by(1.5, { position: new Vec3(0, 68 / scale) })
      .call(() => label.node.destroy())
      .start();
  }

  /** Engine-driven per-frame render; the app ticks the farm clock in its own update, which runs first. */
  update(dt = 1 / 60): void {
    if (this.canAnimate() && this.model?.motion && !this.movement?.active)
      this.presentationTime += Math.min(Math.max(0, dt), 0.1);
    if (!this.model) return;
    this.updateBuildingLayout();
    if (this.resizePending) {
      this.resizeDelay -= dt;
      if (this.resizeDelay <= 0) {
        this.resizePending = false;
        this.applyResize();
      }
    }
    const positions = this.model.plotPositions().filter(p => this.model.isVisiblePlot(p.plot)),
      game = this.getGame();
    if (this.selectedMachine && !canMoveBuilding(game.state, this.selectedMachine)) this.selectedMachine = null;
    const s = this.camera.displayScale,
      x = this.world.position.x,
      y = this.world.position.y,
      width = this.width,
      height = this.height;
    // A generous border keeps tree canopies and tall roofs visible at the edge.
    const left = (-width / 2 - x) / s - this.runtime.camera.cullMargin,
      right = (width / 2 - x) / s + this.runtime.camera.cullMargin,
      bottom = (-height / 2 - y) / s - this.runtime.camera.cullMargin,
      top = (height / 2 - y) / s + this.runtime.camera.cullMargin;
    const visible = (px: number, py: number): boolean => px >= left && px <= right && py >= bottom && py <= top;
    const cameraKey = `${x}:${y}:${s}:${width}:${height}`;
    if (cameraKey !== this.sceneryCamera) {
      this.sceneryCamera = cameraKey;
      for (const n of this.layout.scenery!.children) n.active = visible(n.position.x, n.position.y);
      for (const e of this.standingScenery) e.node.active = visible(e.node.position.x, e.node.position.y);
      // Test the actual rendered bounds, including source pivot/trim offsets. A visible canopy survives when its root exits.
      for (const entry of [...this.decor, ...this.groundDecor, ...this.movableFacilities]) {
        const b = entry.bounds;
        entry.node.active =
          !this.hiddenDecor.has(entry.node) &&
          b.xMax >= left + this.runtime.camera.cullMargin &&
          b.xMin <= right - this.runtime.camera.cullMargin &&
          b.yMax >= bottom + this.runtime.camera.cullMargin &&
          b.yMin <= top - this.runtime.camera.cullMargin;
      }
    }
    const viewport = {
      left: left + this.runtime.camera.cullMargin,
      right: right - this.runtime.camera.cullMargin,
      bottom: bottom + this.runtime.camera.cullMargin,
      top: top - this.runtime.camera.cullMargin,
    };
    this.commands = this.itemRenderer.update(
      positions,
      this.model,
      [
        ...this.decor,
        ...this.movableFacilities,
        ...this.standingScenery,
        ...this.town.update(
          game,
          positions,
          this.model.motion,
          s,
          this.presentationTime,
          this.selected,
          this.movement.active,
          viewport,
          this.selectedMachine
        ),
      ],
      visible
    );
    this.bubbles.update(positions, game, this.movement.active ? null : this.selected, s, this.getSpeed(), visible);
    const focus = this.selected ?? this.hovered;
    const selected = focus === null ? undefined : positions.find(p => p.plot.id === focus);
    const selectedMachine = this.selectedMachine
      ? FARM_LAYOUT.buildings.find(b => b.id === this.selectedMachine)
      : undefined;
    this.selection.active = (!!selected || !!selectedMachine) && !this.movement.active;
    if (selected) {
      this.selection.setPosition(selected.x, selected.y);
      const g = this.selection.getComponent(Graphics) || this.selection.addComponent(Graphics);
      g.clear();
      g.strokeColor = new Color(255, 239, 104);
      g.lineWidth = 3 / s;
      const pen =
        selected.plot.group === 'pen' ? FARM_LAYOUT.buildings.find(b => b.id === 'pen:' + selected.plot.id) : undefined;
      if (pen)
        for (const poly of pen.footprints) {
          g.moveTo(poly[0].x, poly[0].y);
          for (const p of poly.slice(1)) g.lineTo(p.x, p.y);
          g.close();
          g.stroke();
        }
      else {
        g.moveTo(0, selected.h / 2);
        g.lineTo(selected.w / 2, 0);
        g.lineTo(0, -selected.h / 2);
        g.lineTo(-selected.w / 2, 0);
        g.close();
        g.stroke();
      }
    } else if (selectedMachine) {
      const p = this.movement.position(selectedMachine.id);
      this.selection.setPosition(p.x, p.y);
      const g = this.selection.getComponent(Graphics) || this.selection.addComponent(Graphics);
      g.clear();
      g.strokeColor = new Color(255, 239, 104);
      g.lineWidth = 3 / s;
      for (const poly of selectedMachine.footprints) {
        g.moveTo(poly[0].x, poly[0].y);
        for (const point of poly.slice(1)) g.lineTo(point.x, point.y);
        g.close();
        g.stroke();
      }
    }
    this.placementOutline.active = this.movement.active && !!this.movement.selected;
    if (this.placementOutline.active) {
      const b = FARM_LAYOUT.buildings.find(b => b.id === this.movement.selected)!,
        p = this.movement.position(b.id);
      const g = this.placementOutline.getComponent(Graphics) ?? this.placementOutline.addComponent(Graphics);
      g.clear();
      g.strokeColor = this.movement.error ? new Color(255, 90, 80) : new Color(115, 255, 135);
      g.fillColor = new Color(g.strokeColor.r, g.strokeColor.g, g.strokeColor.b, 45);
      g.lineWidth = 3 / s;
      for (const poly of b.footprints.map(f => translated(f, p))) {
        g.moveTo(poly[0].x, poly[0].y);
        for (const q of poly.slice(1)) g.lineTo(q.x, q.y);
        g.close();
        g.fill();
        g.stroke();
      }
    }
  }

  private updateBuildingLayout(): void {
    const layout = this.getGame().state.buildingLayout ?? EMPTY_LAYOUT,
      key = layoutKey(layout);
    const previewKey = key + ':' + this.movement.selected + ':' + JSON.stringify(this.movement.candidate);
    if (this.placementKey !== previewKey) {
      this.placementKey = previewKey;
      this.sceneryCamera = '';
      const move = (entry: { node: Node; bounds: Rect; depth: number }, x: number, y: number, offset = 0): void => {
        const depth = 1000 - y - offset;
        if (entry.node.position.x === x && entry.node.position.y === y && entry.depth === depth) return;
        entry.node.setPosition(x, y);
        entry.bounds = entry.node.getComponent(UITransform)!.getBoundingBox();
        entry.depth = depth;
      };
      this.facilities.forEach((trigger, i) => {
        const p = this.movement.position(trigger.id),
          b = FARM_LAYOUT.buildings.find(b => b.id === trigger.id)!;
        move(this.movableFacilities[i], p.x, p.y, b.depthOffset);
      });
    }
  }

  diagnostics(): Record<string, unknown> {
    const items = this.itemRenderer?.diagnostics() ?? null;
    const sceneryNodes = [
      ...(this.layout?.scenery?.children ?? []),
      ...this.movableFacilities.map(e => e.node),
      ...this.standingScenery.map(e => e.node),
    ];
    const sceneryItems = sceneryNodes.flatMap(n =>
      n.children.map(item => ({
        name: item.name,
        linked: linkedPrefab(item),
        visualX: item.getChildByName('Visual')?.position.x,
        frame: !!item.getComponentInChildren(Sprite)?.spriteFrame,
      }))
    );
    const textures = new Set(
      [...this.decor, ...this.groundDecor]
        .map(e => e.node.getComponentInChildren(Sprite)?.spriteFrame?.texture)
        .filter(Boolean)
    );
    return {
      prefab: this.authoredMap?.name ?? null,
      town: this.town.diagnostics(),
      cropInstances: (items?.cropInstances as number | undefined) ?? 0,
      items,
      sceneryItems,
      movement: {
        active: this.movement.active,
        selected: this.movement.selected,
        candidate: this.movement.candidate,
        error: this.movement.error,
        canPlace: this.movement.canPlace,
      },
      layout: FARM_LAYOUT.buildings.map(b => ({ id: b.id, ...this.movement.position(b.id) })),
      roads: {
        tiles: this.groundDecor
          .filter(e => e.node.name.startsWith('Road-'))
          .map(e => ({ id: e.node.name, x: e.node.position.x, y: e.node.position.y, asset: e.node.children[0]?.name })),
      },
      bounds: this.model.bounds,
      reach: this.camera.reach,
      camera: this.cameraState(),
      zoom: this.camera.zoom,
      minZoom: this.camera.minZoom,
      scale: this.camera.scale,
      pan: { x: this.camera.pan.x, y: this.camera.pan.y },
      plotWidgets: this.commands,
      decor: {
        standing: this.decor.length,
        active: this.decor.filter(e => e.node.activeInHierarchy).length,
        marginScenery: this.marginScenery.length,
        ground: this.groundDecor.length,
        species: this.authoredMap.getComponent(FarmItemLibrary)!.scenery.map(p => p.name),
        textures: Array.from(textures, texture => ({ width: texture!.width, height: texture!.height })),
        instances: this.decor.map(e => ({
          name: e.node.name,
          asset: e.node.children[0]?.name,
          x: e.node.position.x,
          y: e.node.position.y,
          active: e.node.activeInHierarchy,
          bounds: { x: e.bounds.x, y: e.bounds.y, width: e.bounds.width, height: e.bounds.height },
          order: e.node.getSiblingIndex(),
          frame: !!e.node.getComponentInChildren(Sprite)?.spriteFrame,
          linked: linkedPrefab(e.node.children[0]),
        })),
      },
      render: {
        drawCalls: director.root?.device.numDrawCalls,
        textureBytes: director.root?.device.memoryStatus.textureSize,
      },
    };
  }
}
