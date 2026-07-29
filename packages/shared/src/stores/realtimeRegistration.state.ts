import type { RealtimeRegistration } from '../types/realtime/socket.type';

const registrations = new Set<RealtimeRegistration>();

export function claimRealtimeRegistration(registration: RealtimeRegistration): boolean {
  if (registrations.has(registration)) return false;
  registrations.add(registration);
  return true;
}
