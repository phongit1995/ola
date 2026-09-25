import type { BuildingLayout } from '../types/BuildingTypes';

export const EMPTY_LAYOUT: BuildingLayout = { version: 6, positions: {} };

export const TOWN_SITES = new Set(['pen:14', 'pen:15', 'industry-loom']);

export const FIELD_CLEARANCE = 24,
  ROAD_CLEARANCE = 8;
