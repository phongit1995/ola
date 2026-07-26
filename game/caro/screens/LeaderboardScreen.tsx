import { useEffect, useState } from 'react';
import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import type { LeaderboardPeriod } from '../../src/sdk';
import { assetBg, assetSrc, VIP_DEFAULT_ICON, type AssetKey } from '../assets';
import { useCaroStore } from '../store';

const PAGE_SIZE = 10;

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

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

function rankAsset(rank: number): AssetKey | null {
  return RANK_ASSETS[rank] ?? null;
}

export function LeaderboardScreen() {
  const visible = useCaroStore((s) => s.leaderboardVisible);
  const close = useCaroStore((s) => s.hideLeaderboard);
  const leaderboards = useCaroStore((s) => s.leaderboards);
  const leaderboardLoading = useCaroStore((s) => s.leaderboardLoading);
  const leaderboardErrors = useCaroStore((s) => s.leaderboardErrors);
  const loadLeaderboard = useCaroStore((s) => s.loadLeaderboard);
  const [period, setPeriod] = useState<LeaderboardPeriod>('day');
  const [page, setPage] = useState(0);
  const players = leaderboards[period] ?? [];
  const loading = leaderboardLoading[period];
  const error = leaderboardErrors[period];
  const pageCount = Math.max(1, Math.ceil(players.length / PAGE_SIZE));
  const visiblePlayers = players.slice(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE);

  useEffect(() => {
    if (visible) loadLeaderboard(period);
  }, [loadLeaderboard, period, visible]);

  useEffect(() => {
    setPage((current) => Math.min(current, pageCount - 1));
  }, [pageCount]);

  useEffect(() => {
    if (!visible) return;
    const onKeyDown = (event: KeyboardEvent): void => {
      if (event.key === 'Escape') close();
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [close, visible]);

  const changePeriod = (next: LeaderboardPeriod): void => {
    setPeriod(next);
    setPage(0);
  };

  return (
    <div
      id="leaderboard"
      className={visible ? '' : 'hidden'}
      role="dialog"
      aria-modal="true"
      aria-labelledby="leaderboard-title-text"
      onClick={(event) => event.target === event.currentTarget && close()}
    >
      <div id="leaderboard-inner" style={assetBg('leaderboardPanel')}>
        <div className="leaderboard-title" style={assetBg('leaderboardTitleFrame')}>
          <img src={assetSrc('leaderboardCup')} alt="" />
          <span id="leaderboard-title-text">Bảng xếp hạng</span>
        </div>

        <button
          type="button"
          id="leaderboard-close"
          style={assetBg('leaderboardCloseFrame')}
          aria-label="Đóng bảng xếp hạng"
          onClick={close}
        >
          <img src={assetSrc('leaderboardCloseX')} alt="" />
        </button>

        <div className="leaderboard-body">
          <div className="leaderboard-tabs" role="tablist" aria-label="Thời gian xếp hạng">
            <button
              type="button"
              role="tab"
              aria-selected={period === 'day'}
              className={period === 'day' ? 'active' : ''}
              style={assetBg(period === 'day' ? 'leaderboardTabActive' : 'leaderboardTabInactive')}
              onClick={() => changePeriod('day')}
            >
              Top ngày
            </button>
            <button
              type="button"
              role="tab"
              aria-selected={period === 'week'}
              className={period === 'week' ? 'active' : ''}
              style={assetBg(period === 'week' ? 'leaderboardTabActive' : 'leaderboardTabInactive')}
              onClick={() => changePeriod('week')}
            >
              Top tuần
            </button>
          </div>

          <section className="leaderboard-table" aria-label={period === 'day' ? 'Top ngày' : 'Top tuần'}>
            <div className="leaderboard-head">
              <span>Hạng</span>
              <span>Người chơi</span>
              <span>Ken thắng</span>
            </div>
            <div className="leaderboard-rows" aria-busy={loading}>
              {visiblePlayers.map((player) => {
                const medal = rankAsset(player.rank);
                const vipId = parseVipTypeId(player.vipType);
                return (
                  <div className="leaderboard-row" key={player.userId}>
                    <div className="leaderboard-rank">
                      {medal ? (
                        <img src={assetSrc(medal)} alt={`Hạng ${player.rank}`} />
                      ) : (
                        <span>{player.rank}</span>
                      )}
                    </div>
                    <div className="leaderboard-player">
                      <img src={vipId != null ? vipIconUrl(vipId) : VIP_DEFAULT_ICON} alt="" />
                      <span>@{player.username}</span>
                    </div>
                    <div className="leaderboard-ken">
                      <span>{formatKen(player.ken)}</span>
                      <img src={assetSrc('leaderboardKen')} alt="Ken" />
                    </div>
                    <div className="leaderboard-divider" style={assetBg('leaderboardDivider')} />
                  </div>
                );
              })}
              {players.length === 0 && (
                <div className="leaderboard-state" role={error ? 'alert' : 'status'}>
                  <span>{loading ? 'Đang tải bảng xếp hạng...' : error ?? 'Chưa có người chơi thắng Ken.'}</span>
                  {error && !loading && (
                    <button type="button" onClick={() => loadLeaderboard(period)}>
                      Thử lại
                    </button>
                  )}
                </div>
              )}
            </div>
          </section>

          <nav className="leaderboard-pager" aria-label="Phân trang bảng xếp hạng">
            <button
              type="button"
              className="leaderboard-page-arrow"
              style={assetBg('leaderboardPageArrow')}
              disabled={page === 0}
              aria-label="Trang trước"
              onClick={() => setPage((current) => Math.max(0, current - 1))}
            >
              &lt;
            </button>
            <span className="leaderboard-page-number" style={assetBg('leaderboardPageNumber')}>
              {page + 1}
            </span>
            <button
              type="button"
              className="leaderboard-page-arrow"
              style={assetBg('leaderboardPageArrow')}
              disabled={page >= pageCount - 1}
              aria-label="Trang sau"
              onClick={() => setPage((current) => Math.min(pageCount - 1, current + 1))}
            >
              &gt;
            </button>
          </nav>
        </div>
      </div>
    </div>
  );
}
