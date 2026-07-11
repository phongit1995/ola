import { activeVipTypeId } from '../lib';
import type { PenShotView, PenUserBrief } from '../types';

export function withPenVip(user?: PenUserBrief): PenUserBrief | undefined {
  if (user == null) return user;
  return { ...user, vipTypeId: activeVipTypeId(user.vipUsed, user.vipEndTime) };
}

export function mapPenShot(shot: PenShotView): PenShotView {
  return { ...shot, shooter: withPenVip(shot.shooter), keeper: withPenVip(shot.keeper) };
}
