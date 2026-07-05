import type { TFunction } from 'i18next';
import { formatKen } from '@lib';
import type { SpinSegment } from './spinWheel.constants';

export function spinRewardText(t: TFunction, segment: SpinSegment): string {
  if (segment.kind === 'ken') return `${formatKen(segment.kenAmount ?? 0)} KEN`;
  if (segment.kind === 'vip') return t('wheelGame.vipDays', { n: segment.vipDays ?? 0 });
  if (segment.kind === 'item') return t('wheelGame.doll');
  return t('wheelGame.miss');
}
