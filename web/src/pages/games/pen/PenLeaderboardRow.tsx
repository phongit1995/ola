import { VipBadge } from '@components';
import { formatKen } from '@lib';
import type { PenLeaderboardEntry } from '@app-types';
import { penAssets, penLeaderboardAssets } from './penAssets';

const GRID_COLS = '0.7fr 2fr 1.3fr';

const RANK_GRADIENTS = [
  'from-[#ffe14d] to-[#f08a00]',
  'from-[#5cd6ff] to-[#0e6fc0]',
  'from-[#8ff04d] to-[#1f9410]',
  'from-[#ff7ec0] to-[#d01670]',
  'from-[#b47bff] to-[#6a1fd0]',
  'from-[#ffa04d] to-[#e0400f]',
  'from-[#4fe9bd] to-[#129070]',
];

interface PenLeaderboardRowProps {
  entry: PenLeaderboardEntry;
}

export function PenLeaderboardRow({ entry }: PenLeaderboardRowProps) {
  const name = entry.user.username;
  const medal = entry.rank <= 3 ? penLeaderboardAssets.medals[entry.rank - 1] : null;

  return (
    <li
      className="grid h-11 items-center gap-2 border-b border-white/8 px-3"
      style={{ gridTemplateColumns: GRID_COLS }}
    >
      <span className="flex justify-center">
        {medal ? (
          <img src={medal} alt={`#${entry.rank}`} className="h-8 w-8 object-contain" />
        ) : entry.rank <= 10 ? (
          <span
            className={`bg-linear-to-b ${RANK_GRADIENTS[entry.rank - 4]} bg-clip-text text-lg font-extrabold text-transparent`}
          >
            {entry.rank}
          </span>
        ) : (
          <span className="text-lg font-extrabold text-white/90">{entry.rank}</span>
        )}
      </span>
      <span className="flex min-w-0 items-center gap-2">
        <VipBadge typeId={entry.user.vipTypeId} />
        <span className="truncate text-sm font-medium text-white/90">@{name}</span>
      </span>
      <span className="flex items-center justify-end gap-1.5 text-sm font-extrabold text-[#ffd54f]">
        {formatKen(entry.profit)}
        <img src={penAssets.kenIcon} alt="" className="h-4 w-4 shrink-0" />
      </span>
    </li>
  );
}
