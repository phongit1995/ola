import type { ArtFonts, ArtLoadProgress } from './types/Art.types';
import { TOWN_UI_PREFIX, PLOT_UI_PREFIX, ISLAND_UI_PREFIX } from './constants/Art.constants';
import {
  resources,
  assetManager,
  AssetManager,
  Prefab,
  JsonAsset,
  Texture2D,
  SpriteFrame,
  Rect,
  Sprite,
  Node,
  UITransform,
  Layers,
  Font,
  TTFFont,
  BitmapFont,
  AudioClip,
} from 'cc';
import type { ArtData, TownManifest, TownUiManifest } from './types/ArtData';
import { withFarmGameplay } from '../core/FarmGameplay';
import { withFarmRuntime, runtimeConfig } from '../core/FarmRuntime';
import { withFarmTiming } from '../core/FarmTiming';
import type { FarmContentSource } from '../core/types/EconomyTypes';
import { withFarmEconomy } from '../core/FarmEconomy';

/** Registry of every dynamically loaded texture, clip, font and Farm Town prefab. Editor-linked assets bypass it. */
export class Art {
  data!: ArtData;
  index: Record<string, string> = {};
  textures = new Map<string, Texture2D>();
  audio = new Map<string, AudioClip>();
  frames = new Map<string, SpriteFrame>();
  font: TTFFont | null = null;
  /** The authored HUD links Golden Island's Poetsen One; Shop reuses that exact font. */
  shopFont: Font | null = null;
  plotFont!: BitmapFont;
  walletFont!: BitmapFont;
  errors: string[] = [];
  prefabs = new Map<string, Prefab>();
  townManifest!: TownManifest;
  townUi!: TownUiManifest;
  plotUi!: TownUiManifest;
  islandUi!: TownUiManifest;

  static load<T>(resource: string, type: unknown): Promise<T> {
    return new Promise((resolve, reject) =>
      resources.load(resource, type as never, (e: Error | null, a: unknown) => (e ? reject(e) : resolve(a as T)))
    );
  }
  private static bundle(name: string): Promise<AssetManager.Bundle> {
    return new Promise((resolve, reject) => assetManager.loadBundle(name, (e, b) => (e ? reject(e) : resolve(b))));
  }
  private static fromBundle<T>(bundle: AssetManager.Bundle, path: string, type: unknown): Promise<T> {
    return new Promise((resolve, reject) =>
      bundle.load(path, type as never, (e: Error | null, a: unknown) => (e ? reject(e) : resolve(a as T)))
    );
  }

  async initialize(fonts: ArtFonts, progress: (progress: ArtLoadProgress) => void): Promise<void> {
    this.plotFont = fonts.plot;
    this.walletFont = fonts.wallet;
    progress({ phase: 'data' });
    const [game, index] = await Promise.all([
      Art.load<JsonAsset>('ported/game', JsonAsset),
      Art.load<JsonAsset>('ported/asset-index', JsonAsset),
    ]);
    this.data = game.json as ArtData;
    this.index = index.json as Record<string, string>;
    progress({ phase: 'town' });
    await this.loadTown();
    await this.loadPorted(progress);
    progress({ phase: 'town-ui' });
    this.townUi = await this.loadSkin('farm-town-ui', TOWN_UI_PREFIX);
    progress({ phase: 'plot-ui' });
    this.plotUi = await this.loadSkin('farm-plot-ui', PLOT_UI_PREFIX);
    progress({ phase: 'island-ui' });
    this.islandUi = await this.loadSkin('golden-island-ui', ISLAND_UI_PREFIX);
    progress({ phase: 'ready' });
  }

  /** Limit concurrent loads on mobile while keeping one copy of each source texture. */
  private async loadPorted(progress: (progress: ArtLoadProgress) => void): Promise<void> {
    const entries = Object.entries(this.index);
    let done = 0,
      cursor = 0;
    progress({ phase: 'ported', done, total: entries.length });
    await Promise.all(
      Array.from({ length: runtimeConfig(this.data.data).assets.loadConcurrency }, async () => {
        while (cursor < entries.length) {
          const [source, resource] = entries[cursor++];
          try {
            if (source.endsWith('.png'))
              this.textures.set(source, await Art.load<Texture2D>(resource + '/texture', Texture2D));
            else if (source.endsWith('.wav')) this.audio.set(source, await Art.load<AudioClip>(resource, AudioClip));
            else if (source.endsWith('.ttf')) this.font = await Art.load<TTFFont>(resource, TTFFont);
          } catch (error) {
            this.errors.push(`${source}: ${String(error)}`);
          }
          progress({ phase: 'ported', done: ++done, total: entries.length });
        }
      })
    );
    if (this.errors.length) throw Error(this.errors.join('\n'));
  }

  private async loadTown(): Promise<void> {
    const bundle = await Art.bundle('farm-town');
    const [manifest, catalog, timing, economy, gameplay, runtime] = await Promise.all([
      Art.fromBundle<JsonAsset>(bundle, 'manifest', JsonAsset),
      Art.fromBundle<JsonAsset>(bundle, 'catalog', JsonAsset),
      Art.fromBundle<JsonAsset>(bundle, 'timing', JsonAsset),
      Art.fromBundle<JsonAsset>(bundle, 'economy', JsonAsset),
      Art.fromBundle<JsonAsset>(bundle, 'gameplay', JsonAsset),
      Art.fromBundle<JsonAsset>(bundle, 'runtime', JsonAsset),
    ]);
    this.townManifest = manifest.json as TownManifest;
    const extension = withFarmRuntime(
      withFarmGameplay(
        withFarmTiming(withFarmEconomy(catalog.json as FarmContentSource, economy.json), timing.json),
        gameplay.json
      ),
      runtime.json
    );
    this.data = { ...this.data, data: extension };
    // Prefabs load their own image dependencies. Only item icons enter the UI texture registry.
    const definitions = [
      ...extension.farm,
      ...extension.products,
      ...(extension.items ?? []),
      ...(extension.machineTypes ?? []),
      ...(extension.livestock ?? []),
    ];
    const icons = new Set(
      definitions
        .map(i => i.image)
        .filter((image): image is string => !!image && image.startsWith('farm-town/'))
        .map(image => image.slice(10))
    );
    await Promise.all(
      Array.from(icons).map(async key => {
        const info = this.townManifest.images[key];
        if (!info) throw Error(`Manifest Farm Town thiếu icon ${key}; keys=${Object.keys(this.townManifest.images)}`);
        this.textures.set(
          `assets/sprites/farm-town/${key}.png`,
          await Art.fromBundle<Texture2D>(bundle, info.resource + '/texture', Texture2D)
        );
      })
    );
    await Promise.all(
      Object.entries(this.townManifest.prefabs).map(async ([key, p]) =>
        this.prefabs.set(key, await Art.fromBundle<Prefab>(bundle, p.resource, Prefab))
      )
    );
  }

  /** A skin bundle is a manifest of nine-sliced UI images the runtime draws itself, unlike the editor-linked scene art. */
  private async loadSkin(bundleName: string, prefix: string): Promise<TownUiManifest> {
    const skin = await Art.bundle(bundleName);
    const manifest = (await Art.fromBundle<JsonAsset>(skin, 'manifest', JsonAsset)).json as TownUiManifest;
    await Promise.all(
      Object.entries(manifest.images).map(async ([key, info]) => {
        this.textures.set(prefix + key, await Art.fromBundle<Texture2D>(skin, info.resource + '/texture', Texture2D));
        const frame = this.frame(prefix + key),
          [left, bottom, right, top] = info.border;
        frame.insetLeft = left;
        frame.insetBottom = bottom;
        frame.insetRight = right;
        frame.insetTop = top;
      })
    );
    return manifest;
  }

  frame(source: string, rect?: number[]): SpriteFrame {
    const key = source + (rect ? ':' + rect.join(',') : '');
    let frame = this.frames.get(key);
    if (!frame) {
      const texture = this.textures.get(source);
      if (!texture) throw Error(`Thiếu ảnh: ${source}`);
      frame = new SpriteFrame();
      frame.texture = texture;
      frame.rect = rect ? new Rect(rect[0], rect[1], rect[2], rect[3]) : new Rect(0, 0, texture.width, texture.height);
      this.frames.set(key, frame);
    }
    return frame;
  }

  image(parent: Node, source: string, x: number, y: number, width: number, height: number, name = 'Art'): Node {
    const n = new Node(name);
    n.layer = Layers.Enum.UI_2D;
    parent.addChild(n);
    n.setPosition(x, y);
    n.addComponent(UITransform).setContentSize(width, height);
    const s = n.addComponent(Sprite);
    s.sizeMode = Sprite.SizeMode.CUSTOM;
    s.spriteFrame = this.frame(source);
    return n;
  }

  /** Nine-slice using the source borders, corrected for Unity atlas trimming. */
  town(parent: Node, key: string, x: number, y: number, width: number, height: number, name = key): Node {
    return this.skin(this.townUi, TOWN_UI_PREFIX, parent, key, x, y, width, height, name);
  }

  /** Golden Island's plot bubble skin, drawn on the map rather than in the screen-space UI. */
  plot(parent: Node, key: string, x: number, y: number, width: number, height: number, name = key): Node {
    return this.skin(this.plotUi, PLOT_UI_PREFIX, parent, key, x, y, width, height, name);
  }

  /** Golden Island's original popup, material cards and crafting slots, with source slice borders. */
  island(parent: Node, key: string, x: number, y: number, width: number, height: number, name = key): Node {
    return this.skin(this.islandUi, ISLAND_UI_PREFIX, parent, key, x, y, width, height, name);
  }

  private skin(
    manifest: TownUiManifest,
    prefix: string,
    parent: Node,
    key: string,
    x: number,
    y: number,
    width: number,
    height: number,
    name: string
  ): Node {
    const info = manifest.images[key];
    if (!info) throw Error(`Thiếu ảnh giao diện ${prefix}${key}`);
    const node = this.image(parent, prefix + key, x, y, width, height, name);
    if (info.border.some(v => v > 0)) node.getComponent(Sprite)!.type = Sprite.Type.SLICED;
    return node;
  }

  dispose(): void {
    for (const frame of this.frames.values()) frame.destroy();
    this.frames.clear();
  }
}
