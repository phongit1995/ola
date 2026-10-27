import medalBronzeUrl from '../assets/leaderboard/medal-bronze.webp';
import medalGoldUrl from '../assets/leaderboard/medal-gold.webp';
import medalSilverUrl from '../assets/leaderboard/medal-silver.webp';

export const MEDAL_RANKS = 3;

const MEDALS = [medalGoldUrl, medalSilverUrl, medalBronzeUrl];

export function RankMedal({ rank, className }: { rank: number; className?: string }) {
  if (rank > MEDAL_RANKS) return <span className={className}>{rank}</span>;
  return (
    <span className="ty-medal" data-rank={rank} role="img" aria-label={`Hạng ${rank}`}>
      <img src={MEDALS[rank - 1]} alt="" draggable={false} />
      <b aria-hidden="true">{rank}</b>
    </span>
  );
}
