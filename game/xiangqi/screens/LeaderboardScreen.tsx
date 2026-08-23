import { useShallow } from 'zustand/react/shallow';
import type { LeaderboardPeriod } from '../../src/sdk';
import { XqIcon } from '../components/XqIcon';
import { formatKen } from '../helpers/format';
import { PodAvatar } from '../components/PodAvatar';
import { useXiangqi } from '../store/useXiangqi';

const PERIODS: Array<{ key: LeaderboardPeriod; label: string }> = [
  { key: 'day', label: 'Hôm nay' },
  { key: 'week', label: 'Tuần này' },
];

export function LeaderboardScreen() {
  const { leaderboardItems, leaderboardPeriod, leaderboardLoading, setLeaderboardPeriod, closeLeaderboard } = useXiangqi(
    useShallow((s) => ({
      leaderboardItems: s.leaderboardItems,
      leaderboardPeriod: s.leaderboardPeriod,
      leaderboardLoading: s.leaderboardLoading,
      setLeaderboardPeriod: s.setLeaderboardPeriod,
      closeLeaderboard: s.closeLeaderboard,
    })),
  );

  return (
    <div className="xq-screen xq-list-screen">
      <div className="xq-screen-header">
        <button type="button" className="xq-icon-btn" onClick={closeLeaderboard} aria-label="Quay lại">
          <XqIcon name="arrow-left" size={22} />
        </button>
        <h1>Bảng xếp hạng</h1>
        <span />
      </div>
      <div className="xq-tabs" role="tablist">
        {PERIODS.map((period) => (
          <button
            key={period.key}
            type="button"
            role="tab"
            aria-selected={leaderboardPeriod === period.key}
            className={`xq-tab ${leaderboardPeriod === period.key ? 'xq-tab-active' : ''}`}
            onClick={() => setLeaderboardPeriod(period.key)}
          >
            {period.label}
          </button>
        ))}
      </div>
      <div className="xq-list" key={leaderboardPeriod}>
        {leaderboardLoading ? <div className="xq-empty xq-empty-loading">Đang tải...</div> : null}
        {!leaderboardLoading && leaderboardItems.length === 0 ? <div className="xq-empty xq-empty-state">Chưa có dữ liệu</div> : null}
        {leaderboardItems.map((item) => (
          <div key={item.userId} className="xq-list-row">
            <span className={`xq-rank ${item.rank <= 3 ? `xq-rank-${item.rank}` : ''}`}>{item.rank}</span>
            <PodAvatar vipType={item.vipType} tone="red" />
            <div className="xq-list-main">
              <span className="xq-list-name">@{item.username}</span>
              {item.wins != null ? (
                <span className="xq-list-sub">
                  {item.wins} thắng — {item.losses ?? 0} thua
                </span>
              ) : null}
            </div>
            <span className="xq-list-ken xq-pos">+{formatKen(item.ken)}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
