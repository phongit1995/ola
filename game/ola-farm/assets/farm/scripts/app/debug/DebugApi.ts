import { GLOBAL } from './DebugApi.constants';
import { Label, UITransform, view } from 'cc';
import type { GameApp } from '../bootstrap/GameApp';
import { Ui } from '../../render/Ui';

/** Read-only inspection surface for browser tests and manual debugging; only installed in debug builds. */
export function installDebugApi(app: GameApp): void {
  const normalize = (x: number, y: number): { x: number; y: number } => {
    const viewport = view.getViewportRect(),
      canvas = view.getCanvasSize();
    return {
      x: (viewport.x + x * view.getScaleX()) / canvas.width,
      y: 1 - (viewport.y + y * view.getScaleY()) / canvas.height,
    };
  };
  (globalThis as Record<string, unknown>)[GLOBAL] = Object.freeze({
    snapshot: () => JSON.parse(JSON.stringify(app.game.state)),
    pack: () => JSON.parse(app.session.exportText()),
    ui: () => ({
      fullBleed: true,
      viewport: { ...view.getViewportRect() },
      canvas: { ...view.getCanvasSize() },
      view: app.panels.view,
      selected: app.selected,
      paused: app.session.paused,
      layoutEditing: app.session.layoutEditing,
      speed: app.session.speed,
      storageFailed: app.session.storageFailed,
      width: app.width,
      height: app.height,
      animating: false,
    }),
    controls: () =>
      Array.from(app.ui.controls)
        .filter(([, n]) => n.isValid && n.activeInHierarchy)
        .map(([id, n]) => {
          const p = n.worldPosition,
            s = n.worldScale,
            t = n.getComponent(UITransform)!;
          return { id, enabled: Ui.isEnabled(n), ...normalize(p.x, p.y), w: t.width * s.x, h: t.height * s.y };
        }),
    targets: () => app.map.targets().map(t => ({ ...t, screen: normalize(t.screen.x, t.screen.y) })),
    buildings: () => app.map.buildingTargets().map(t => ({ ...t, screen: normalize(t.screen.x, t.screen.y) })),
    map: () => app.map.diagnostics(),
    assets: () => ({
      files: Object.keys(app.art.index).length,
      townImages: Object.keys(app.art.townManifest.images).length,
      townPrefabs: app.art.prefabs.size,
      errors: app.art.errors,
    }),
    audio: () => ({ sound: app.session.settings.sound, music: app.session.settings.music, playing: app.audio.playing }),
    labels: () =>
      app.root
        .getComponentsInChildren(Label)
        .filter(l => l.node.activeInHierarchy)
        .map(l => ({
          text: l.string,
          size: l.fontSize,
          actual: l.actualFontSize,
          width: l.node.getComponent(UITransform)!.width,
          height: l.node.getComponent(UITransform)!.height,
        })),
  });
}

export function uninstallDebugApi(): void {
  delete (globalThis as Record<string, unknown>)[GLOBAL];
}
