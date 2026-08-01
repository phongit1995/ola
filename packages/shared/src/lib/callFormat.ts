import type { CallerBrief } from '../types/client/call.type';

export function formatCallDuration(seconds: number): string {
  const safe = Math.max(0, Math.floor(seconds));
  const minutes = Math.floor(safe / 60);
  const rest = safe % 60;
  return `${minutes}:${rest.toString().padStart(2, '0')}`;
}

export function peerDisplayName(peer: CallerBrief, fallback: string): string {
  return peer.fullName ?? peer.username ?? fallback;
}
