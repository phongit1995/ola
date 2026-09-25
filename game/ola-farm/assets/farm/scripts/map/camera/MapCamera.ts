import type { CameraMode, CameraState } from './MapCamera.types';
import { CAMERA_MODES } from './CameraMode.enum';
import type { FarmRuntimeConfig } from '../../core/types/RuntimeTypes';
import { LEGACY_RUNTIME } from '../../core/constants/RuntimeDefaults';
import { Node, Vec2 } from 'cc';
import type { MapBounds } from '../../render/types/MapTypes';

/** Pan/zoom state of the map world node, clamped to the forested reach. Pure math; gestures live in the view. */
export class MapCamera {
  zoom = 1;
  minZoom = 1;
  /** Map units to design units at zoom 1. */
  scale = 1;
  readonly pan = new Vec2();
  mode: CameraMode = CAMERA_MODES.Overview;
  width = 0;
  height = 0;
  reach: MapBounds = { left: 0, right: 0, bottom: 0, top: 0 };

  constructor(
    private world: Node,
    readonly center: { x: number; y: number },
    private config: FarmRuntimeConfig['camera'] = LEGACY_RUNTIME.camera
  ) {}

  get maxZoom(): number {
    return Math.max(this.config.maxZoom, this.config.maxDisplayScale / this.scale);
  }
  get displayScale(): number {
    return this.scale * this.zoom;
  }

  setZoom(zoom: number): void {
    const next = Math.max(this.minZoom, Math.min(this.maxZoom, zoom));
    // Pushing against the limit must not turn the fitted home into a manual camera on resize.
    if (next === this.zoom) return;
    this.mode = CAMERA_MODES.Manual;
    this.zoom = next;
    this.place();
  }

  panBy(dx: number, dy: number): void {
    this.mode = CAMERA_MODES.Manual;
    this.pan.x += dx;
    this.pan.y += dy;
    this.place();
  }

  /** Center the view on a map point with the given zoom; `offsetY` shifts the focus in design units. */
  lookAt(x: number, y: number, zoom: number, mode: CameraMode, offsetY = 0): void {
    this.zoom = Math.max(this.minZoom, Math.min(this.maxZoom, zoom));
    const s = this.displayScale;
    this.pan.set((this.center.x - x) * s, offsetY + (this.center.y - y) * s);
    this.mode = mode;
    this.place();
  }

  place(): void {
    const b = this.reach,
      s = this.displayScale;
    const maxX = Math.max(0, ((b.right - b.left) * s) / 2 - this.width / 2);
    const minY = Math.min(0, this.height / 2 - (b.top - this.center.y) * s);
    const maxY = Math.max(0, -this.height / 2 - (b.bottom - this.center.y) * s);
    this.pan.x = Math.max(-maxX, Math.min(maxX, this.pan.x));
    this.pan.y = Math.max(minY, Math.min(maxY, this.pan.y));
    this.world.setScale(s, s, 1);
    this.world.setPosition(this.pan.x - this.center.x * s, this.pan.y - this.center.y * s);
  }

  state(): CameraState {
    const s = this.displayScale;
    return { mode: this.mode, x: this.center.x - this.pan.x / s, y: this.center.y - this.pan.y / s, displayScale: s };
  }

  /** Restore a manual camera after a resize; `home` and `overview` are recomputed by the caller. */
  restoreManual(state: CameraState): void {
    this.setZoom(state.displayScale / this.scale);
    this.mode = CAMERA_MODES.Manual;
    const s = this.displayScale;
    this.pan.set((this.center.x - state.x) * s, (this.center.y - state.y) * s);
    this.place();
  }
}
