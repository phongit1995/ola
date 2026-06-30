import type { PenShotView, PenSide, PenUserBrief } from '@app-types';
import type { PenHistorySection } from '@/store/penHistoryStore';

export type PenHistoryOutcome = 'win' | 'lose' | 'pending' | 'cancelled';

export interface PenHistoryRowView {
  id: string;
  opponent?: PenUserBrief;
  side?: PenSide;
  bet: number;
  date: string;
  time: string;
  outcome: PenHistoryOutcome;
  amount: number;
}

function pad(value: number): string {
  return String(value).padStart(2, '0');
}

function resolveOutcome(shot: PenShotView, userId?: string): PenHistoryOutcome {
  if (shot.status === 'open') return 'pending';
  if (shot.status === 'cancelled') return 'cancelled';
  return shot.winnerId != null && shot.winnerId === userId ? 'win' : 'lose';
}

function resolveAmount(shot: PenShotView, outcome: PenHistoryOutcome): number {
  if (outcome === 'win') return (shot.payout ?? shot.betAmount * 2) - shot.betAmount;
  if (outcome === 'lose') return -shot.betAmount;
  return 0;
}

export interface PenAllHistoryRowView {
  id: string;
  shooter?: PenUserBrief;
  keeper?: PenUserBrief;
  winnerId?: string;
  bet: number;
  date: string;
  time: string;
}

export function toAllHistoryRow(shot: PenShotView): PenAllHistoryRowView {
  const at = new Date(shot.createdAt);
  const valid = !Number.isNaN(at.getTime());
  return {
    id: shot.id,
    shooter: shot.shooter,
    keeper: shot.keeper,
    winnerId: shot.winnerId,
    bet: shot.betAmount,
    date: valid ? `${pad(at.getDate())}/${pad(at.getMonth() + 1)}/${pad(at.getFullYear() % 100)}` : '',
    time: valid ? `${pad(at.getHours())}:${pad(at.getMinutes())}` : '',
  };
}

export function toHistoryRow(
  shot: PenShotView,
  section: PenHistorySection,
  userId?: string,
): PenHistoryRowView {
  const isShoot = section === 'shoot';
  const outcome = resolveOutcome(shot, userId);
  const at = new Date(shot.createdAt);
  const valid = !Number.isNaN(at.getTime());
  return {
    id: shot.id,
    opponent: isShoot ? shot.keeper : shot.shooter,
    side: isShoot ? shot.keeperSide : shot.shooterSide,
    bet: shot.betAmount,
    date: valid ? `${pad(at.getDate())}/${pad(at.getMonth() + 1)}/${pad(at.getFullYear() % 100)}` : '',
    time: valid ? `${pad(at.getHours())}:${pad(at.getMinutes())}:${pad(at.getSeconds())}` : '',
    outcome,
    amount: resolveAmount(shot, outcome),
  };
}
