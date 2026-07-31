import { VIP_CATALOG } from '@ola/shared/lib';
import { VIP_ICONS } from '@lib/vipImages';

describe('VIP_ICONS', () => {
  it('has one asset per catalog entry', () => {
    expect(VIP_ICONS).toHaveLength(VIP_CATALOG.length);
  });
});
