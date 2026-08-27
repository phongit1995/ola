import type { LeaderboardEntry } from '../../../../src/sdk';
import { assetBg, assetSrc, type AssetKey } from '../../../assets';
import { formatKen } from '../../../helpers/format';
import { avatarIconSrc } from '../../../helpers/player';

const RANK_ASSETS: Partial<Record<number, AssetKey>> = {
  1: 'leaderboardRank1',
  2: 'leaderboardRank2',
  3: 'leaderboardRank3',
  4: 'leaderboardRank4',
  5: 'leaderboardRank5',
  6: 'leaderboardRank6',
  7: 'leaderboardRank7',
  8: 'leaderboardRank8',
  9: 'leaderboardRank9',
  10: 'leaderboardRank10',
};

export function LeaderboardRow({ player }: { player: LeaderboardEntry }) {
  const medal = RANK_ASSETS[player.rank];
  const wins = player.wins ?? 0;
  const losses = player.losses ?? 0;

  return (
    <div className="leaderboard-row">
      <div className="leaderboard-rank">
        {medal ? <img src={assetSrc(medal)} alt={`Hạng ${player.rank}`} /> : <span>{player.rank}</span>}
      </div>
      <div className="leaderboard-player">
        <img src={avatarIconSrc(player.vipType)} alt="" />
        <span>@{player.username}</span>
        {player.level != null && player.level > 0 && (
          <span className="leaderboard-level" aria-label={`Cấp ${player.level}`}>
            {player.level}
          </span>
        )}
      </div>
      <div className="leaderboard-record" aria-label={`${wins} thắng, ${losses} thua`}>
        <span className="wins">{wins}</span>
        <span aria-hidden="true">/</span>
        <span className="losses">{losses}</span>
      </div>
      <div className="leaderboard-ken">
        <span>{formatKen(player.ken)}</span>
        <img src={assetSrc('leaderboardKen')} alt="Ken" />
      </div>
      <div className="leaderboard-divider" style={assetBg('leaderboardDivider')} />
    </div>
  );
}
