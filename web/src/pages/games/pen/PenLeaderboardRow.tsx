import { Avatar } from '@components';
import { colorForName, formatKen } from '@lib';
import type { PenLeaderboardEntry } from '@app-types';
import { penAssets, penLeaderboardAssets } from './penAssets';

const GRID_COLS = '0.7fr 2fr 1.3fr';

interface PenLeaderboardRowProps {
  entry: PenLeaderboardEntry;
}

export function PenLeaderboardRow({ entry }: PenLeaderboardRowProps) {
  const name = entry.user.username;
  const medal = entry.rank <= 3 ? penLeaderboardAssets.medals[entry.rank - 1] : null;

  return (
    <li
      className="grid items-center gap-2 border-b border-white/8 px-3 py-2"
      style={{ gridTemplateColumns: GRID_COLS }}
    >
      <span className="flex justify-center">
        {medal ? (
          <img src={medal} alt={`#${entry.rank}`} className="h-8 w-8 object-contain" />
        ) : (
          <span className="text-lg font-extrabold text-white/90">{entry.rank}</span>
        )}
      </span>
      <span className="flex min-w-0 items-center gap-2">
        <Avatar name={name} color={colorForName(name)} src={entry.user.avatar} size={36} />
        <span className="truncate text-sm font-medium text-white/90">@{name}</span>
      </span>
      <span className="flex items-center justify-end gap-1.5 text-sm font-extrabold text-[#ffd54f]">
        <img src={penAssets.kenIcon} alt="" className="h-4 w-4 shrink-0" />
        {formatKen(entry.profit)}
      </span>
    </li>
  );
}
