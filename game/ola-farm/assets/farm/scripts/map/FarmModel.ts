import { PEN_ANIMAL_DEPTHS, ANIMAL_ORDER } from './constants/FarmModel.constants';
import { LIVESTOCK_FIRST_CELL, FIELD_COUNT } from './constants/MapLayout.constants';
import { penDefinition, penBuildingId } from '../core/FarmCatalog';
import { FarmGame, orderedCrops } from '../core/FarmGame';
import type { Plot } from '../core/types/PlotTypes';
import type {
  CellGeometry,
  DrawWidget,
  MapBounds,
  PlotPosition,
  RuntimeData,
  SceneData,
} from '../render/types/MapTypes';
import { herdHitBox } from './buildings/HerdPresentation';

// Geometry and animation sampling owned by the Farm prefab renderer. Engine-free so Node tests can drive it.
const matrix = (position: number[], scale: number[], rotation: number[]): number[] => {
  const z = 2 * Math.atan2(rotation[2], rotation[3]),
    c = Math.cos(z),
    s = Math.sin(z);
  return [c * scale[0], s * scale[0], -s * scale[1], c * scale[1], position[0], position[1]];
};
const multiply = (p: number[], m: number[]): number[] => [
  p[0] * m[0] + p[2] * m[1],
  p[1] * m[0] + p[3] * m[1],
  p[0] * m[2] + p[2] * m[3],
  p[1] * m[2] + p[3] * m[3],
  p[0] * m[4] + p[2] * m[5] + p[4],
  p[1] * m[4] + p[3] * m[5] + p[5],
];
/** Piecewise cubic sampling of an exported Unity curve: each key is [time, a, b, c, d]. */
const sample = (keys: number[][], t: number): number => {
  let lo = 0,
    hi = keys.length - 1;
  while (lo < hi) {
    const mid = Math.ceil((lo + hi) / 2);
    if (keys[mid][0] <= t) lo = mid;
    else hi = mid - 1;
  }
  const k = keys[lo],
    dt = Math.max(0, t - k[0]);
  return ((k[1] * dt + k[2]) * dt + k[3]) * dt + k[4];
};

export class FarmModel {
  readonly scene: SceneData;
  readonly center: { x: number; y: number };
  motion = true;

  constructor(
    scene: SceneData,
    readonly runtime: RuntimeData,
    readonly getGame: () => FarmGame,
    cells: CellGeometry[],
    readonly bounds: MapBounds,
    private buildingPosition?: (id: string) => { x: number; y: number }
  ) {
    this.scene = { ...scene, cells };
    this.center = { x: (bounds.left + bounds.right) / 2, y: (bounds.bottom + bounds.top) / 2 };
  }

  plotPositions(): PlotPosition[] {
    const state = this.getGame().state,
      crops = orderedCrops(state.plots);
    return state.plots.map(plot => {
      let cell =
        plot.group === 'crop'
          ? this.scene.cells[crops.indexOf(plot)]
          : plot.cell === null
            ? (this.scene.cells.find(cell => cell.plotId === plot.id) ?? this.scene.cells[FIELD_COUNT])
            : this.scene.cells[FIELD_COUNT + plot.cell - LIVESTOCK_FIRST_CELL];
      const pen = penDefinition(this.getGame().catalog, plot);
      if (pen && this.buildingPosition) {
        const p = this.buildingPosition(penBuildingId(pen));
        const hit = herdHitBox(pen.species);
        cell = {
          ...cell,
          matrix: [...cell.matrix.slice(0, 4), p.x, p.y],
          collider: { center: [0, hit.y], size: [hit.w, hit.h] },
        };
      }
      return {
        plot,
        cell,
        x: cell.matrix[4],
        y: cell.matrix[5],
        w: cell.widget.width * Math.abs(cell.matrix[0]),
        h: cell.widget.height * Math.abs(cell.matrix[3]),
      };
    });
  }

  /** Reveal one crop purchase at a time; future pens remain in the shop until constructed. */
  isVisiblePlot(plot: Plot): boolean {
    const game = this.getGame();
    if (!game.isActivePlot(plot)) return false;
    if (plot.group === 'crop') return !game.simple || plot.unlocked || game.nextLockedCrop()?.id === plot.id;
    return !penDefinition(game.catalog, plot) || (plot.unlocked && !!plot.residents);
  }

  plotWidgets(position: PlotPosition): DrawWidget[] {
    const p = position.plot,
      game = this.getGame();
    if (p.residents || penDefinition(game.catalog, p) || !game.isActivePlot(p)) return [];
    const widgets = this.baseWidgets(position);
    if (p.group === 'crop') return widgets.map((w, i) => ({ ...w, depth: 1000 - position.y + i }));
    const type = p.group === 'pen' ? 'pens' : 'ponds',
      level = p.unlocked ? p.level : 0;
    const ground = (w: DrawWidget, part: number): void => {
      Object.assign(w, { itemType: type, itemIndex: level, itemInstance: `plot-${p.id}`, itemPart: part });
    };
    ground(widgets[0], 0);
    if (p.crop) {
      const f = game.farm(p.crop)!,
        count = Math.floor(f.yields[p.level - 1] / 2),
        parts = this.runtime.animals[f.key].widgets.length;
      const animalIndex = ANIMAL_ORDER.indexOf(f.key);
      for (let i = 0; i < count; i++)
        for (let j = 0; j < parts; j++) {
          Object.assign(widgets[1 + i * parts + j], {
            itemType: 'animals',
            itemIndex: animalIndex,
            itemInstance: `animal-${p.id}-${count - 1 - i}`,
            itemPart: j,
          });
        }
    }
    if (p.group === 'pen' && p.unlocked) ground(widgets[widgets.length - 1], 1);
    return widgets;
  }

  widgetBounds(widgets: Array<{ width: number; height: number; matrix: number[] }>): MapBounds {
    const bounds: MapBounds = { left: Infinity, right: -Infinity, bottom: Infinity, top: -Infinity };
    for (const w of widgets) {
      const [a, b, c, d, x, y] = w.matrix;
      const hw = (Math.abs(a) * w.width + Math.abs(c) * w.height) / 2,
        hh = (Math.abs(b) * w.width + Math.abs(d) * w.height) / 2;
      bounds.left = Math.min(bounds.left, x - hw);
      bounds.right = Math.max(bounds.right, x + hw);
      bounds.bottom = Math.min(bounds.bottom, y - hh);
      bounds.top = Math.max(bounds.top, y + hh);
    }
    return bounds;
  }

  animalWidgets(key: string, cell: CellGeometry, position: number[], stage: number, phase: number): DrawWidget[] {
    const rig = this.runtime.animals[key],
      clip = rig.animations[stage === 3 ? 1 : 0];
    const time = this.motion ? (this.getGame().state.time + phase) % clip.duration : 0;
    const values = new Map<string, Record<string, number[]>>();
    for (const track of clip.tracks) {
      let pose = values.get(track.path);
      if (!pose) {
        pose = {};
        values.set(track.path, pose);
      }
      pose[track.property] = track.curves.map(curve => sample(curve, time));
    }
    const rootValues = values.get('') ?? {};
    const rootMatrix = matrix(
      rootValues.position ?? [0, 0, 0],
      rootValues.scale ?? [1, 1, 1],
      rootValues.rotation ?? [0, 0, 0, 1]
    );
    const origin = multiply(cell.matrix, multiply([1, 0, 0, 1, ...position], rootMatrix));
    return rig.widgets.map(w => {
      const name = w.path.slice(key.length + 1),
        pose = values.get(name) ?? {},
        local = w.local;
      const active = pose.active ? pose.active[0] >= 0.5 : w.active;
      const m = matrix(pose.position ?? local.position, pose.scale ?? local.scale, pose.rotation ?? local.rotation);
      return { ...w, depth: w.depth ?? 0, active, matrix: multiply(origin, m) };
    });
  }

  baseWidgets({ plot: p, cell }: PlotPosition): DrawWidget[] {
    const game = this.getGame();
    const base: DrawWidget = {
      ...cell.widget,
      width: cell.widget.width,
      height: cell.widget.height,
      matrix: cell.matrix,
      active: true,
      depth: cell.widget.depth ?? 0,
    };
    const items: DrawWidget[] = [],
      locked = !p.unlocked;
    const herd = (slots: number[][]): void => {
      const f = game.farm(p.crop!)!,
        stage = game.growthStage(p),
        count = Math.floor(f.yields[p.level - 1] / 2);
      for (let i = count - 1; i >= 0; i--) {
        const parts = this.animalWidgets(f.key, cell, slots[i], stage, p.id * 0.13 + i * 0.17);
        if (p.group === 'pen') {
          const offsets = PEN_ANIMAL_DEPTHS[f.key];
          parts.forEach((w, j) => {
            w.depth = base.depth + (f.key === 'pig' && p.cell === 17 && j === 0 ? 7 : offsets[j]);
          });
        }
        items.push(...parts);
      }
    };
    if (p.group === 'crop') {
      items.push({ ...base, sprite: 'dat' + (locked ? 0 : p.level) });
      if (p.crop) {
        const stage = game.growthStage(p),
          [width, height] = this.scene.plantStageSizes[stage - 1];
        items.push({ ...base, width, height, sprite: game.farm(p.crop)!.key + stage });
      }
    } else if (p.group === 'pen') {
      items.push({ ...base, sprite: locked ? 'chuong0' : `chuong${p.level}-0` });
      if (p.crop) herd(this.runtime.animalPositions.pen);
      if (!locked) items.push({ ...base, sprite: `chuong${p.level}-1`, depth: base.depth + 5 });
    } else {
      items.push({ ...base, sprite: 'chuongca' + (locked ? 0 : p.level) });
      if (p.crop) herd(this.runtime.animalPositions.pond);
    }
    return items;
  }
}
