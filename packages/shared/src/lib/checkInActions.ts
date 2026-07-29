import { CHECK_IN_ACTIONS } from './checkInActions.constants';

export * from './checkInActions.constants';
export type { CheckInAction } from '../types/client/checkIn.type';

export function findActionIcon(text: string): string {
  return CHECK_IN_ACTIONS.find((action) => action.text === text)?.icon ?? '';
}
