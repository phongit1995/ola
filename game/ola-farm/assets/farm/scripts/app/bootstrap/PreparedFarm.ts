import type { PreparedFarm } from './PreparedFarm.types';
import type { Art } from '../../render/Art';

let pending: PreparedFarm | null = null;

export function stagePreparedFarm(prepared: PreparedFarm): void {
  pending = prepared;
}

export function claimPreparedFarm(): PreparedFarm | null {
  const prepared = pending;
  pending = null;
  return prepared;
}

export function clearPreparedFarm(art: Art): void {
  if (pending?.art === art) pending = null;
}
