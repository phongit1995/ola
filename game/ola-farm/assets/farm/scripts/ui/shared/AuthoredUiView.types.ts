import type { Color, SpriteFrame, Vec4 } from 'cc';

export interface Pose {
  rect: Vec4;
  scaleX: number;
  scaleY: number;
  font: number;
  lineRatio: number;
  color: Color | null;
  frame: SpriteFrame | null;
}
