import type { BuildingView, YardView, AnimalView, Site, HerdBadge, MachineBadge } from './FarmTownViews.types';
import { YARD_PREFABS, HERD_STYLE } from './FarmTownViews.constants';
import { PEN_CAPACITY_LIMIT } from '../../core/constants/HusbandryDefaults';
import { penDefinition, machineSites } from '../../core/FarmCatalog';
import { Node, instantiate, Color, UIOpacity, UITransform } from 'cc';
import { Art } from '../../render/Art';
import { Ui } from '../../render/Ui';
import { FarmGame } from '../../core/FarmGame';

import { FarmTownMotion } from './FarmTownMotion';
import type { DrawEntry } from '../types/FarmItems.types';
import type { MapBounds, PlotPosition } from '../../render/types/MapTypes';
import { herdDisplayScale, herdResidentScale } from './HerdPresentation';
import { machineArtBounds, machineDisplayScale } from './MachinePresentation';
import { t } from '../../core/i18n/I18n';
import { contentName } from '../../core/i18n/LocalizeContent';
const dispose = (node: Node): void => {
  node.active = false;
  node.destroy();
};

/** Separate yard front fences and stable residents share the map's ground-based painter order. */
export class FarmTownViews {
  private buildings = new Map<string, BuildingView>();
  private yards = new Map<number, YardView>();
  private badges: HerdBadge[] = [];
  private machineBadges: MachineBadge[] = [];
  private presentationTime = 0;
  readonly animals = new Map<number, AnimalView>();

  constructor(
    private parent: Node,
    private overlay: Node,
    private art: Art,
    private ui: Ui,
    readonly anchors: Map<string, Node>,
    private position: (id: string) => { x: number; y: number }
  ) {}

  private sites(game: FarmGame): Site[] {
    const sites: Site[] = [];
    for (const type of game.machineTypes)
      for (const key of machineSites(type)) {
        if (!type.prefab) throw Error('Xưởng Farm Town thiếu prefab: ' + type.name);
        const machine = game.state.machines.find(machine => machine.buildingId === key);
        if (machine) sites.push({ key, prefab: type.prefab, name: game.machineName(machine), machine });
      }
    return sites;
  }

  update(
    game: FarmGame,
    positions: PlotPosition[],
    motion: boolean,
    displayScale: number,
    presentationTime: number,
    selected: number | null,
    arranging: boolean,
    viewport: MapBounds,
    selectedMachine: string | null = null
  ): DrawEntry[] {
    this.presentationTime = presentationTime;
    this.badges = [];
    this.machineBadges = [];
    const draw: DrawEntry[] = [],
      used = new Set<string>(),
      animalIds = new Set<number>(),
      yardIds = new Set<number>(),
      time = game.state.time;
    const badgeDraw: { node: Node; ground: number; selected: boolean }[] = [];
    for (const site of this.sites(game)) {
      const anchor = this.anchors.get(site.key);
      if (!anchor) continue;
      used.add(site.key);
      let view = this.buildings.get(site.key);
      if (view && view.visualKey !== site.prefab) {
        this.disposeBuilding(view);
        this.buildings.delete(site.key);
        view = undefined;
      }
      if (!view) view = this.createBuilding(site, anchor);
      const p = this.position(site.key),
        expanded = selectedMachine === site.key;
      const bounds = this.machineBounds(site.prefab, p, displayScale, expanded);
      const inView =
        bounds.right >= viewport.left &&
        bounds.left <= viewport.right &&
        bounds.top >= viewport.bottom &&
        bounds.bottom <= viewport.top;
      const size = machineDisplayScale(site.prefab),
        m = site.machine;
      view.node.setPosition(p.x, p.y);
      view.node.setScale(size, size, 1);
      view.node.active = inView;
      view.opacity.opacity = 255;
      // A machine can run a new batch while finished batches remain in its tray.
      if (inView) view.motion.sample(m.job ? 'working' : 'idle', presentationTime, motion);
      const status = m.tray.length
        ? t('map.machineTray', { count: m.tray.length, state: t(m.job ? 'map.trayWorking' : 'map.trayReady') })
        : m.job
          ? t('map.machineWorking')
          : t('map.machineTapOpen');
      view.label.string = expanded
        ? `${contentName(site.name)}\n${status}`
        : m.tray.length
          ? `✓ ${m.tray.length}`
          : m.job
            ? '…'
            : t('map.machineOpen');
      const badge = this.machineBadgeMetrics(this.machineArtBounds(site.prefab, p), displayScale, expanded);
      view.badge.getComponent(UITransform)!.setContentSize(badge.w, badge.h);
      view.label.node.getComponent(UITransform)!.setContentSize(badge.w - 14, badge.h - 12);
      view.label.fontSize = expanded ? 20 : 22;
      view.badge.setScale(badge.scale, badge.scale, 1);
      view.badge.setPosition(badge.x, badge.y);
      view.badge.active = inView && !arranging;
      if (view.badge.active) {
        this.machineBadges.push({
          node: view.badge,
          building: site.key,
          x: badge.x,
          y: badge.y,
          w: badge.w * badge.scale,
          h: Math.max(60, badge.h) * badge.scale,
          ground: p.y,
          selected: expanded,
        });
        badgeDraw.push({ node: view.badge, ground: p.y, selected: expanded });
      }
      draw.push({ node: view.node, depth: 1000 - p.y });
    }
    for (const p of positions) {
      const spec = penDefinition(game.catalog, p.plot);
      if (!spec || !p.plot.unlocked || !p.plot.residents) continue;
      const pen = p.plot.residents,
        type = game.catalog.livestock?.find(t => t.key === spec.species);
      if (!type) throw Error('Loài vật nuôi không có trong catalog: ' + spec.species);
      yardIds.add(p.plot.id);
      const key = YARD_PREFABS[spec.species],
        style = HERD_STYLE[spec.species],
        size = herdDisplayScale(spec.species),
        residentSize = herdResidentScale(spec.species);
      const bounds = this.penBounds(spec.species, p, displayScale, selected === p.plot.id);
      const inView =
        bounds.right >= viewport.left &&
        bounds.left <= viewport.right &&
        bounds.top >= viewport.bottom &&
        bounds.bottom <= viewport.top;
      let yard = this.yards.get(p.plot.id);
      if (yard && yard.key !== key) {
        this.disposeYard(yard);
        yard = undefined;
      }
      if (!yard) {
        yard = this.createYard(key, p.plot.id);
        this.yards.set(p.plot.id, yard);
      }
      yard.node.setPosition(p.x, p.y);
      yard.front.setPosition(p.x, p.y);
      yard.node.setScale(size, size, 1);
      yard.front.setScale(size, size, 1);
      yard.node.active = yard.front.active = inView;
      yard.opacity.opacity = yard.frontOpacity.opacity = 255;
      draw.push(
        { node: yard.node, depth: 1000 - p.y - 25 * size },
        { node: yard.front, depth: 1000 - p.y + 34 * size }
      );
      const residents = pen.animals,
        residentIds = new Set(residents.map(a => a.id));
      for (const id of yard.slots.keys()) if (!residentIds.has(id)) yard.slots.delete(id);
      for (const animal of residents) {
        animalIds.add(animal.id);
        // The saved slot, rather than array order, keeps a sold animal's gap stable across reloads.
        const slot = animal.slot ?? residents.indexOf(animal);
        if (!Number.isInteger(slot) || slot < 0 || slot >= style.slots.length)
          throw Error('Vị trí vật nuôi không hợp lệ: ' + slot);
        yard.slots.set(animal.id, slot);
        let view = this.animals.get(animal.id);
        if (view && view.prefab !== type.prefab) {
          dispose(view.node);
          this.animals.delete(animal.id);
          view = undefined;
        }
        if (!view) {
          const node = this.ui.node(this.parent, 'Resident-' + animal.id, 0, 0, 70, 65),
            visual = instantiate(this.prefab(type.prefab));
          node.addChild(visual);
          visual.setScale(style.scale, style.scale, 1);
          const model = visual.getChildByName('Model'),
            source = this.art.townManifest.provenance[type.prefab];
          // Imported poses have a common bottom of -30; normalize from real bounds rather than a guessed center.
          const bottom =
            model && source?.bounds && source.scale ? model.position.y + source.bounds[1] * source.scale : -30;
          visual.setPosition(0, -bottom * style.scale, 0);
          const label = this.ui.text(node, 'AnimalState', '', 0, 50, 60, 25, 17, new Color(76, 58, 30));
          view = {
            node,
            label,
            visual,
            motion: new FarmTownMotion(visual, 'animal', spec.species),
            prefab: type.prefab,
            slot,
            pen: p.plot.id,
            walking: false,
          };
          this.animals.set(animal.id, view);
        }
        view.slot = slot;
        view.pen = p.plot.id;
        const ready = !!animal.job && animal.job.ready <= time,
          phase = animal.id * 1.73,
          phaseTime = presentationTime + phase;
        const walking = motion && !animal.job && phaseTime % 10 < 4;
        // Each ID has a small separate walking area. Selling one animal never reindexes the remaining slots.
        const walkPhase = (Math.min(phaseTime % 10, 4) / 4) * Math.PI * 2;
        const dx = motion && !animal.job ? 5 * Math.sin(walkPhase) : 0;
        const dy = motion && !animal.job ? 2.5 * (1 - Math.cos(walkPhase)) : 0;
        const offset = style.slots[slot];
        view.node.setScale(residentSize, residentSize, 1);
        view.node.setPosition(p.x + (offset[0] + dx) * size, p.y + (offset[1] + dy) * size);
        view.walking = walking;
        view.label.string = ready ? '✓' : animal.job ? '…' : t('map.animalFeed');
        view.label.node.setScale(1 / residentSize, 1 / residentSize, 1);
        view.label.node.active = selected === p.plot.id && !arranging;
        view.node.active = inView;
        if (view.node.active)
          view.motion.sample(ready ? 'ready' : animal.job ? 'working' : 'idle', phaseTime, motion, walking);
        draw.push({ node: view.node, depth: 1000 - view.node.position.y + 0.1 });
      }
      const hungry = residents.filter(a => !a.job).length,
        ready = residents.filter(a => a.job && a.job.ready <= time).length;
      const busy = residents.length - hungry - ready;
      const expanded = selected === p.plot.id;
      yard.label.string = expanded
        ? ready
          ? t('map.penReady', { count: ready, hungry: hungry ? ' · ' + t('herd.hungryShort', { count: hungry }) : '' })
          : hungry
            ? t('herd.hungryShort', { count: hungry })
            : busy
              ? t('map.penBusy', { count: busy })
              : t('herd.empty')
        : ready
          ? `✓ ${ready}`
          : hungry
            ? t('map.hungryBadge', { count: hungry })
            : busy
              ? `… ${busy}`
              : '+';
      const { scale, w: badgeW, h: badgeH, y: badgeY } = this.badgeMetrics(yard.bounds, size, expanded, displayScale);
      yard.badge.getComponent(UITransform)!.setContentSize(badgeW, badgeH);
      yard.label.node.getComponent(UITransform)!.setContentSize(badgeW - 10, badgeH - 8);
      yard.label.fontSize = expanded ? 20 : 22;
      yard.badge.setScale(scale, scale, 1);
      yard.badge.setPosition(p.x, p.y + badgeY);
      yard.badge.active = inView && !arranging;
      if (yard.badge.active) {
        this.badges.push({
          node: yard.badge,
          plot: p.plot.id,
          x: p.x,
          y: yard.badge.position.y,
          w: badgeW * scale,
          h: Math.max(60, badgeH) * scale,
          ground: p.y,
          selected: expanded,
        });
        badgeDraw.push({ node: yard.badge, ground: p.y, selected: expanded });
      }
    }
    for (const [id, v] of this.yards)
      if (!yardIds.has(id)) {
        this.disposeYard(v);
        this.yards.delete(id);
      }
    for (const [id, v] of this.buildings)
      if (!used.has(id)) {
        this.disposeBuilding(v);
        this.buildings.delete(id);
      }
    for (const [id, v] of this.animals)
      if (!animalIds.has(id)) {
        dispose(v.node);
        this.animals.delete(id);
      }
    const order = (a: { selected: boolean; ground: number }, b: { selected: boolean; ground: number }) =>
      Number(a.selected) - Number(b.selected) || b.ground - a.ground;
    this.badges.sort(order);
    this.machineBadges.sort(order);
    badgeDraw.sort(order);
    const ordered = [
      ...this.overlay.children.filter(node => !node.activeInHierarchy),
      ...badgeDraw.map(badge => badge.node),
    ];
    ordered.forEach((node, index) => {
      if (node.getSiblingIndex() !== index) node.setSiblingIndex(index);
    });
    return draw;
  }

  /** Resolve overlapping labels in the same order that their shared overlay is drawn. */
  topBadgeTarget(p: { x: number; y: number }): { plot: number } | { building: string } | null {
    const hit = [...this.badges, ...this.machineBadges]
      .filter(b => Math.abs(b.x - p.x) <= b.w / 2 && Math.abs(b.y - p.y) <= b.h / 2)
      .sort((a, b) => b.node.getSiblingIndex() - a.node.getSiblingIndex())[0];
    return hit ? ('plot' in hit ? { plot: hit.plot } : { building: hit.building }) : null;
  }

  /** Full prefab bounds, without a status badge, shared with map hit testing. */
  machineArtBounds(prefab: string, p: { x: number; y: number }): MapBounds {
    return machineArtBounds(prefab, p);
  }

  /** Works before instantiation and includes the independently sized status badge. */
  machineBounds(prefab: string, p: { x: number; y: number }, displayScale = 1, expanded = false): MapBounds {
    const bounds = this.machineArtBounds(prefab, p),
      badge = this.machineBadgeMetrics(bounds, displayScale, expanded);
    return {
      left: Math.min(bounds.left, badge.x - (badge.w * badge.scale) / 2),
      right: Math.max(bounds.right, badge.x + (badge.w * badge.scale) / 2),
      bottom: bounds.bottom,
      top: Math.max(bounds.top, badge.y + (badge.h * badge.scale) / 2),
    };
  }

  private machineBadgeMetrics(bounds: MapBounds, displayScale: number, expanded: boolean) {
    const scale = expanded ? Math.min(1.8, Math.max(0.8, 0.9 / displayScale)) : 1;
    const w = expanded ? 220 : 74,
      h = expanded ? 78 : 42;
    return { scale, w, h, x: (bounds.left + bounds.right) / 2, y: bounds.top + (h * scale) / 2 + 8 };
  }

  private badgeMetrics(bounds: MapBounds, size: number, expanded: boolean, displayScale: number) {
    const scale = expanded ? Math.min(1.8, Math.max(0.8, 0.9 / displayScale)) : 1;
    const w = expanded ? 160 : 74,
      h = expanded ? 66 : 42;
    const y = Math.max((expanded ? 110 : 105) * size, bounds.top * size + (h * scale) / 2 + 8);
    return { scale, w, h, y };
  }

  /** Source bounds also work during the opening camera fit, before yards are instantiated. */
  penBounds(species: string, p: { x: number; y: number }, displayScale = 1, expanded = false): MapBounds {
    const bounds = this.sourceBounds(YARD_PREFABS[species]),
      size = herdDisplayScale(species);
    const badge = this.badgeMetrics(bounds, size, expanded, displayScale);
    return {
      left: p.x + Math.min(bounds.left * size, (-badge.w * badge.scale) / 2),
      right: p.x + Math.max(bounds.right * size, (badge.w * badge.scale) / 2),
      bottom: p.y + bounds.bottom * size,
      top: p.y + Math.max(bounds.top * size, badge.y + (badge.h * badge.scale) / 2),
    };
  }

  private sourceBounds(key: string): MapBounds {
    const model = this.prefab(key).data.getChildByName('Model'),
      source = this.art.townManifest.provenance[key];
    return model && source?.bounds && source.scale
      ? {
          left: model.position.x + source.bounds[0] * source.scale,
          right: model.position.x + source.bounds[2] * source.scale,
          bottom: model.position.y + source.bounds[1] * source.scale,
          top: model.position.y + source.bounds[3] * source.scale,
        }
      : { left: -95, right: 95, bottom: -30, top: 105 };
  }

  private createYard(key: string, id: number): YardView {
    const node = instantiate(this.prefab(key));
    this.parent.addChild(node);
    const front = this.ui.node(this.parent, 'YardFront-' + id, 0, 0, 200, 130);
    const model = node.getChildByName('Model');
    const bounds = this.sourceBounds(key);
    const frontNames: string[] = [];
    if (model) {
      const layer = new Node('FrontFenceModel');
      layer.layer = node.layer;
      front.addChild(layer);
      layer.setPosition(model.position);
      layer.setScale(model.scale);
      layer.setRotation(model.rotation);
      for (const part of [...model.children])
        if (/^zabor/.test(part.name) && part.position.y <= 0.05) {
          frontNames.push(part.name);
          part.setParent(layer, false);
        }
    }
    const badge = this.art.town(this.overlay, 'talk', 0, 0, 160, 66, 'HerdBadge-' + id);
    const label = this.ui.text(badge, 'HerdState', '', 0, 5, 146, 52, 20, new Color(74, 54, 27));
    return {
      node,
      front,
      key,
      slots: new Map(),
      badge,
      label,
      opacity: node.addComponent(UIOpacity),
      frontOpacity: front.addComponent(UIOpacity),
      frontNames,
      bounds,
    };
  }
  private disposeYard(yard: YardView): void {
    dispose(yard.node);
    dispose(yard.front);
    dispose(yard.badge);
  }
  private prefab(key: string) {
    const prefab = this.art.prefabs.get(key);
    if (!prefab) throw Error('Bundle farm-town thiếu prefab ' + key);
    return prefab;
  }
  private createBuilding(site: Site, anchor: Node): BuildingView {
    const node = this.ui.node(this.parent, site.key, anchor.position.x, anchor.position.y, 240, 220);
    const model = instantiate(this.prefab(site.prefab));
    node.addChild(model);
    const badge = this.art.town(this.overlay, 'talk', 0, 0, 220, 78, 'MachineBadge-' + site.key);
    const label = this.ui.text(badge, 'FactoryState', '', 0, 5, 206, 66, 20, new Color(74, 54, 27));
    const view = {
      node,
      label,
      model,
      badge,
      opacity: node.addComponent(UIOpacity),
      visualKey: site.prefab,
      motion: new FarmTownMotion(model, 'machine'),
    };
    this.buildings.set(site.key, view);
    return view;
  }
  private disposeBuilding(view: BuildingView): void {
    dispose(view.node);
    dispose(view.badge);
  }
  diagnostics(): Record<string, unknown> {
    return {
      buildings: Array.from(this.buildings.keys()),
      animals: Array.from(this.animals.keys()),
      presentationTime: this.presentationTime,
      herds: Array.from(this.yards, ([id, y]) => ({
        id,
        key: y.key,
        slotCount: PEN_CAPACITY_LIMIT,
        frontFences: y.frontNames,
        slots: Array.from(y.slots, ([animal, slot]) => ({ animal, slot })),
      })),
      residents: Array.from(this.animals, ([id, a]) => ({
        id,
        pen: a.pen,
        slot: a.slot,
        x: a.node.position.x,
        y: a.node.position.y,
        walking: a.walking,
        prefab: a.prefab,
      })),
    };
  }
}
