import type { PenShotView } from '../types/api/pen.type';
import type {
  PenAllHistoryRowView,
  PenHistoryRowView,
  PenHistorySection,
  PenRowOutcome,
} from '../types/client/penHistory.type';

export type {
  PenAllHistoryRowView,
  PenHistoryRowView,
  PenRowOutcome,
} from '../types/client/penHistory.type';

function pad(value: number): string {
  return String(value).padStart(2, '0');
}

function formatPenDateTime(iso: string, withSeconds: boolean): { date: string; time: string } {
  const at = new Date(iso);
  if (Number.isNaN(at.getTime())) return { date: '', time: '' };
  const hm = `${pad(at.getHours())}:${pad(at.getMinutes())}`;
  return {
    date: `${pad(at.getDate())}/${pad(at.getMonth() + 1)}/${pad(at.getFullYear() % 100)}`,
    time: withSeconds ? `${hm}:${pad(at.getSeconds())}` : hm,
  };
}

function resolveOutcome(shot: PenShotView, userId?: string): PenRowOutcome {
  if (shot.status === 'open') return 'pending';
  if (shot.status === 'cancelled') return 'cancelled';
  return shot.winnerId != null && shot.winnerId === userId ? 'win' : 'lose';
}

function resolveAmount(shot: PenShotView, outcome: PenRowOutcome): number {
  if (outcome === 'win') return (shot.payout ?? shot.betAmount * 2) - shot.betAmount;
  if (outcome === 'lose') return -shot.betAmount;
  return 0;
}

export function toAllHistoryRow(shot: PenShotView): PenAllHistoryRowView {
  const { date, time } = formatPenDateTime(shot.createdAt, false);
  return {
    id: shot.id,
    shooter: shot.shooter,
    keeper: shot.keeper,
    winnerId: shot.winnerId,
    bet: shot.betAmount,
    date,
    time,
  };
}

export function toHistoryRow(
  shot: PenShotView,
  section: PenHistorySection,
  userId?: string,
): PenHistoryRowView {
  const isShoot = section === 'shoot';
  const outcome = resolveOutcome(shot, userId);
  const { date, time } = formatPenDateTime(shot.createdAt, true);
  return {
    id: shot.id,
    opponent: isShoot ? shot.keeper : shot.shooter,
    side: isShoot ? shot.keeperSide : shot.shooterSide,
    bet: shot.betAmount,
    date,
    time,
    outcome,
    amount: resolveAmount(shot, outcome),
  };
}
