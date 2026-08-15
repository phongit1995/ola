import type { Graphics, Sprite, Texture } from 'pixi.js';

// Lòng khung avatar-frame.webp (texture 500x349, đo từ asset): ellipse rộng 312
// cao 257, tâm thấp hơn tâm texture 27.5px vì viên ngọc chiếm phần đỉnh khung.
const FRAME_TEX_W = 500;
const INNER_RX = 156;
const INNER_RY = 128.5;
const INNER_DY = 27.5;
// Icon VIP thường dồn mặt về nửa dưới texture: thu bớt và nhấc tâm lên một
// chút thì nhìn mới cân giữa lòng khung.
const ICON_FILL = 0.86;
const ICON_LIFT = 15;

export interface AvatarFrameFit {
  innerW: number;
  innerH: number;
  centerDy: number;
  iconDy: number;
}

export function avatarFrameFit(frameWidth: number): AvatarFrameFit {
  const s = frameWidth / FRAME_TEX_W;
  return {
    innerW: INNER_RX * 2 * s,
    innerH: INNER_RY * 2 * s,
    centerDy: INNER_DY * s,
    iconDy: (INNER_DY - ICON_LIFT) * s,
  };
}

export function fitAvatarIcon(icon: Sprite, texture: Texture, fit: AvatarFrameFit): void {
  icon.texture = texture;
  icon.scale.set(Math.min(fit.innerW / texture.width, fit.innerH / texture.height) * ICON_FILL);
}

export function drawAvatarFrameMask(
  mask: Graphics,
  cx: number,
  frameCy: number,
  fit: AvatarFrameFit,
): void {
  mask
    .clear()
    .ellipse(cx, frameCy + fit.centerDy, fit.innerW / 2, fit.innerH / 2)
    .fill(0xffffff);
}
