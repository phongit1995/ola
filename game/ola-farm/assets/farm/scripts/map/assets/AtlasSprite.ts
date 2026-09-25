import { _decorator, Component, Texture2D, Rect, Sprite, SpriteFrame } from 'cc';
import { EDITOR } from 'cc/env';

const { ccclass, property, executeInEditMode } = _decorator;

/** Shows an original atlas region in both Prefab Mode and the running game. */
@ccclass('AtlasSprite')
@executeInEditMode
export class AtlasSprite extends Component {
  @property(Texture2D) texture: Texture2D | null = null;
  @property(Rect) region = new Rect();
  private frame: SpriteFrame | null = null;
  private appliedTexture: Texture2D | null = null;
  private applied = new Rect(-1, -1, 0, 0);

  onLoad(): void {
    this.refresh();
    // The region only changes through the inspector; at runtime one application is final and
    // hundreds of scenery nodes stop paying for a per-frame poll.
    if (!EDITOR) this.enabled = false;
  }
  onValidate(): void {
    this.appliedTexture = null;
  }
  update(): void {
    this.refresh();
  }
  private refresh(): void {
    if (!this.texture || this.region.width <= 0 || this.region.height <= 0) return;
    if (this.texture === this.appliedTexture && this.region.equals(this.applied)) return;
    this.appliedTexture = this.texture;
    this.applied.set(this.region);
    const sprite = this.getComponent(Sprite)!;
    const previous = this.frame;
    this.frame = new SpriteFrame();
    this.frame.texture = this.texture;
    this.frame.rect = this.region;
    sprite.sizeMode = Sprite.SizeMode.CUSTOM;
    sprite.spriteFrame = this.frame;
    previous?.destroy();
  }
  onDestroy(): void {
    this.frame?.destroy();
  }
}
