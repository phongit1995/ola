import type { FarmState } from '../../core/types/StateTypes';
import type { BuildingPosition } from '../../core/types/BuildingTypes';
import {
  FARM_LAYOUT,
  buildingPosition,
  canMoveBuilding,
  checkLayout,
  movedLayout,
  snapPosition,
} from '../../core/BuildingPlacement';
import { EMPTY_LAYOUT } from '../../core/constants/PlacementDefaults';

/** A draft lives here only; production state changes exclusively through moveBuilding. */
export class BuildingMoveController {
  active = false;
  selected: string | null = null;
  candidate: BuildingPosition | null = null;
  error: string | null = null;
  private offset: BuildingPosition | null = null;
  constructor(private state: () => FarmState) {}
  position(id: string): BuildingPosition {
    return this.active && this.selected === id && this.candidate
      ? this.candidate
      : buildingPosition(id, this.state().buildingLayout ?? EMPTY_LAYOUT);
  }
  start(): void {
    this.cancel();
    this.active = true;
  }
  finish(): void {
    this.cancel();
    this.active = false;
  }
  cancel(): void {
    this.selected = null;
    this.candidate = null;
    this.offset = null;
    this.error = null;
  }
  select(id: string): boolean {
    if (!this.active || !canMoveBuilding(this.state(), id)) return false;
    this.cancel();
    this.selected = id;
    this.candidate = { ...this.position(id) };
    return true;
  }
  grab(point: BuildingPosition): void {
    if (!this.candidate) return;
    this.offset = { x: point.x - this.candidate.x, y: point.y - this.candidate.y };
  }
  release(): void {
    this.offset = null;
  }
  get dragging(): boolean {
    return this.offset !== null;
  }
  drag(point: BuildingPosition): void {
    if (!this.offset || !this.selected) return;
    const p = snapPosition({ x: point.x - this.offset.x, y: point.y - this.offset.y });
    if (p.x === this.candidate?.x && p.y === this.candidate?.y) return;
    this.candidate = p;
    const state = this.state();
    this.error = checkLayout(movedLayout(state.buildingLayout!, this.selected, p), state).error;
  }
  get changed(): boolean {
    if (!this.selected || !this.candidate) return false;
    const p = buildingPosition(this.selected, this.state().buildingLayout!);
    return p.x !== this.candidate.x || p.y !== this.candidate.y;
  }
  get canPlace(): boolean {
    return this.active && this.changed && !this.error;
  }
  get message(): string {
    if (!this.selected) return 'Chạm công trình rồi kéo đến chỗ mới. Đất giữ cố định.';
    return this.error ?? 'Kéo đến chỗ mới rồi thả để đặt.';
  }
  get title(): string {
    return FARM_LAYOUT.buildings.find(b => b.id === this.selected)?.name ?? 'Sắp xếp nông trại';
  }
}
