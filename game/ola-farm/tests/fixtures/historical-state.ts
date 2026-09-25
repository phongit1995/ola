import assert from 'node:assert/strict';
import type { FarmState } from '../../assets/farm/scripts/core/types/StateTypes';

/** Project current starter fixtures onto the shipped 50-plot schema, without dropping assets. */
export function historicalState(state: FarmState): FarmState {
  const old: FarmState = JSON.parse(JSON.stringify(state));
  for (const plot of old.plots.filter(p => p.id >= 50)) {
    assert.equal(plot.unlocked, false);
    assert.equal(plot.residents, null);
    assert.equal(plot.crop, null);
  }
  assert.ok(old.machines.every(m => !m.buildingId?.endsWith('-2')));
  old.plots = old.plots.filter(p => p.id < 50);
  old.version = 6;
  if (old.buildingLayout?.version === 6) old.buildingLayout.version = 5;
  return old;
}
