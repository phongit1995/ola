import type { DrawEntry, CropView, ItemView } from './types/FarmItems.types';
import { Node, Prefab, instantiate, UITransform, Vec3, Quat, Sprite } from 'cc';
import { FarmItemLibrary } from './assets/FarmItemLibrary';
import { FarmTownMotion } from './buildings/FarmTownMotion';
import { CropPlotView } from './crops/CropPlotView';
import { ItemParts } from './assets/ItemParts';
import { FarmModel } from './FarmModel';
import type { DrawWidget, PlotPosition, Pose } from '../render/types/MapTypes';

const dispose = (node: Node): void => {
  node.active = false;
  node.destroy();
};
const multiply = (a: number[], b: number[]): number[] => [
  a[0] * b[0] + a[2] * b[1],
  a[1] * b[0] + a[3] * b[1],
  a[0] * b[2] + a[2] * b[3],
  a[1] * b[2] + a[3] * b[3],
  a[0] * b[4] + a[2] * b[5] + a[4],
  a[1] * b[4] + a[3] * b[5] + a[5],
];
function inversePose(local: Pose | undefined): number[] {
  if (!local) return [1, 0, 0, 1, 0, 0];
  const angle = 2 * Math.atan2(local.rotation[2], local.rotation[3]),
    c = Math.cos(angle),
    s = Math.sin(angle);
  const [sx, sy] = local.scale,
    [x, y] = local.position;
  return [c / sx, -s / sy, s / sx, c / sy, -(c * x + s * y) / sx, (s * x - c * y) / sy];
}
function pose(node: Node, m: number[]): void {
  const [a, b, c, d, x, y] = m,
    sx = Math.hypot(a, b);
  node.setPosition(x, y);
  node.setRotationFromEuler(0, 0, (Math.atan2(b, a) * 180) / Math.PI);
  node.setScale(sx, sx ? (a * d - b * c) / sx : 0, 1);
}

/** Keeps authored visuals intact; separate draw parents carry animation and depth. */
export class FarmItems {
  private crops = new Map<number, CropView>();
  private items = new Map<string, ItemView>();
  /** Sibling order applied last frame; re-sorting every frame would dirty the UI batcher for nothing. */
  private lastOrder: Node[] = [];

  constructor(
    private parent: Node,
    private cropTemplate: Prefab,
    private library: FarmItemLibrary,
    private townPrefabs: Map<string, Prefab>
  ) {}

  update(
    positions: PlotPosition[],
    model: FarmModel,
    extras: DrawEntry[],
    visible: (x: number, y: number) => boolean
  ): DrawWidget[] {
    const ids = new Set<number>(),
      used = new Set<string>(),
      commands: DrawWidget[] = [],
      draw: DrawEntry[] = [...extras];
    const game = model.getGame();
    for (const p of positions) {
      if (!model.isVisiblePlot(p.plot)) continue;
      const widgets = model.plotWidgets(p);
      commands.push(...widgets);
      if (p.plot.group === 'crop') {
        ids.add(p.plot.id);
        const key = `${p.plot.unlocked}:${p.plot.level}:${p.plot.crop ?? 0}`;
        let view = this.crops.get(p.plot.id);
        if (view && view.key !== key) {
          dispose(view.root);
          this.crops.delete(p.plot.id);
          view = undefined;
        }
        if (!view) view = this.createCrop(p, key, game.farm(p.plot.crop ?? 0)?.prefab ?? null);
        view.root.setPosition(p.x, p.y);
        view.root.active = visible(p.x, p.y);
        if (view.shell.currentPlant) {
          const stage = game.growthStage(p.plot);
          view.shell.setStage(stage);
          if (view.root.active)
            view.motion?.sample(stage === 3 ? 'ready' : 'grow', game.state.time + p.plot.id * 0.1, model.motion);
        }
        draw.push({ node: view.root, depth: 1000 - p.y });
        continue;
      }
      for (const w of widgets) {
        const key = w.itemInstance!,
          prefab = this.library[w.itemType!][w.itemIndex!];
        used.add(key);
        let item = this.items.get(key);
        if (item && item.prefab !== prefab) {
          this.disposeItem(item);
          this.items.delete(key);
          item = undefined;
        }
        if (!item) item = this.createItem(key, prefab);
        const part = item.parts.get(w.itemPart!);
        if (!part) throw Error(`Prefab ${prefab.name} thiếu Part${w.itemPart}`);
        // Cancel the source bind pose, then apply the sampled animation. Designer offsets stay on children.
        pose(part, multiply(w.matrix, inversePose(w.local)));
        part.active = w.active && visible(p.x, p.y);
        draw.push({ node: part, depth: w.depth });
      }
    }
    for (const [id, view] of this.crops)
      if (!ids.has(id)) {
        dispose(view.root);
        this.crops.delete(id);
      }
    for (const [key, item] of this.items)
      if (!used.has(key)) {
        this.disposeItem(item);
        this.items.delete(key);
      }
    this.applyOrder(draw);
    return commands;
  }

  private createCrop(p: PlotPosition, key: string, townPrefab: string | null): CropView {
    const root = instantiate(this.cropTemplate);
    this.parent.addChild(root);
    root.name = 'Crop-' + p.plot.id;
    const shell = root.getComponent(CropPlotView);
    if (!shell) throw Error('CropPlot.prefab thiếu component CropPlotView.');
    const size = root.getComponent(UITransform)!;
    root.setScale((root.scale.x * p.w) / size.width, (root.scale.y * p.h) / size.height, 1);
    const soilLevel = p.plot.unlocked ? p.plot.level : 0;
    if (soilLevel !== 1) shell.replaceSoil(this.library.soils[soilLevel]);
    let motion: FarmTownMotion | null = null;
    if (p.plot.crop) {
      const source = townPrefab ? this.townPrefabs.get(townPrefab) : this.library.crops[p.plot.crop - 1];
      if (!source) throw Error(`Thiếu prefab cây cho giống ${p.plot.crop}.`);
      const plant = instantiate(source);
      shell.setPlant(plant);
      if (townPrefab) motion = new FarmTownMotion(plant, 'crop');
    }
    const view = { root, shell, key, unlocked: p.plot.unlocked, motion };
    this.crops.set(p.plot.id, view);
    return view;
  }

  private createItem(key: string, prefab: Prefab): ItemView {
    const root = instantiate(prefab);
    this.parent.addChild(root);
    root.name = key;
    const parts = root.getComponent(ItemParts);
    if (!parts) throw Error(`Prefab ${prefab.name} thiếu component ItemParts.`);
    const item: ItemView = { root, prefab, parts: new Map() };
    this.items.set(key, item);
    const rootPosition = root.position.clone(),
      rootScale = root.scale.clone(),
      rootRotation = root.rotation.clone();
    parts.parts.forEach((part, index) => {
      const anchor = new Node(key + '/Part' + index);
      anchor.layer = root.layer;
      this.parent.addChild(anchor);
      const authoredRoot = new Node('PrefabPose');
      authoredRoot.layer = root.layer;
      anchor.addChild(authoredRoot);
      authoredRoot.setPosition(rootPosition);
      authoredRoot.setScale(rootScale);
      authoredRoot.setRotation(rootRotation);
      part.setParent(authoredRoot);
      item.parts.set(index, anchor);
    });
    root.setPosition(Vec3.ZERO);
    root.setScale(Vec3.ONE);
    root.setRotation(Quat.IDENTITY);
    return item;
  }

  private applyOrder(draw: DrawEntry[]): void {
    draw.sort((a, b) => a.depth - b.depth);
    const order = draw.map(entry => entry.node);
    if (order.length === this.lastOrder.length && order.every((node, i) => node === this.lastOrder[i])) return;
    order.forEach((node, i) => node.setSiblingIndex(i));
    this.lastOrder = order;
  }

  private disposeItem(item: ItemView): void {
    dispose(item.root);
    for (const part of item.parts.values()) dispose(part);
  }

  diagnostics(): Record<string, unknown> {
    const prefabs: Record<string, number> = {};
    for (const item of this.items.values()) prefabs[item.prefab.name] = (prefabs[item.prefab.name] || 0) + 1;
    for (const crop of this.crops.values()) {
      const plant = crop.shell.currentPlant;
      if (plant) prefabs[plant.name] = (prefabs[plant.name] || 0) + 1;
    }
    const visuals: Record<string, unknown>[] = [];
    const parentTransform = this.parent.getComponent(UITransform)!;
    for (const [id, item] of this.items)
      for (const [part, anchor] of item.parts) {
        for (const sprite of anchor.getComponentsInChildren(Sprite)) {
          const point = parentTransform.convertToNodeSpaceAR(sprite.node.worldPosition);
          const size = sprite.node.getComponent(UITransform)!,
            relativeX = sprite.node.worldScale.x / this.parent.worldScale.x,
            relativeY = sprite.node.worldScale.y / this.parent.worldScale.y;
          visuals.push({
            id,
            part,
            active: sprite.node.activeInHierarchy,
            frame: !!sprite.spriteFrame,
            x: point.x,
            y: point.y,
            width: size.width * relativeX,
            height: size.height * relativeY,
          });
        }
      }
    const stages = Array.from(this.crops.entries()).map(([id, v]) => {
      const plant = v.shell.currentPlant,
        stage = plant?.children.find(n => n.active),
        sprite = stage?.getComponentsInChildren(Sprite)[0];
      return {
        id,
        unlocked: v.unlocked,
        soil: v.shell.soil?.children.find(node => node.active)?.name ?? null,
        active: v.root.activeInHierarchy,
        plant: plant?.name ?? null,
        stage: stage?.name ?? null,
        frame: !!sprite?.spriteFrame,
        visualX: sprite?.node.position.x ?? null,
      };
    });
    return { cropInstances: this.crops.size, itemInstances: this.items.size, prefabs, visuals, stages };
  }
}
