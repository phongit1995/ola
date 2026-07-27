import { useEffect, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import type { LeaderboardPeriod } from '../../../src/sdk';
import { assetBg, assetSrc } from '../../assets';
import { handleDialogKeyDown, useDialogFocus } from '../../helpers/dialog';
import { useCaro } from '../../store/useCaro';
import { LeaderboardPager } from './components/LeaderboardPager';
import { LeaderboardRow } from './components/LeaderboardRow';
import { useLeaderboard } from './useLeaderboard';

const PAGE_SIZE = 10;

export function LeaderboardScreen() {
  const dialogRef = useRef<HTMLDivElement>(null);
  const visible = useCaro((s) => s.leaderboardVisible);
  const close = useCaro((s) => s.hideLeaderboard);
  const leaderboards = useCaro((s) => s.leaderboards);
  const leaderboardLoading = useCaro((s) => s.leaderboardLoading);
  const leaderboardErrors = useCaro((s) => s.leaderboardErrors);
  const loadLeaderboard = useCaro((s) => s.loadLeaderboard);
  const { period, page, setPeriod, setPage } = useLeaderboard(
    useShallow((state) => ({
      period: state.period,
      page: state.page,
      setPeriod: state.setPeriod,
      setPage: state.setPage,
    })),
  );
  const players = leaderboards[period] ?? [];
  const loading = leaderboardLoading[period];
  const error = leaderboardErrors[period];
  const pageCount = Math.max(1, Math.ceil(players.length / PAGE_SIZE));
  const visiblePlayers = players.slice(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE);
  useDialogFocus(visible, dialogRef);

  useEffect(() => {
    if (visible) loadLeaderboard(period);
  }, [loadLeaderboard, period, visible]);

  useEffect(() => {
    setPage((current) => Math.min(current, pageCount - 1));
  }, [pageCount, setPage]);

  const changePeriod = (next: LeaderboardPeriod): void => {
    setPeriod(next);
  };

  return (
    <div
      id="leaderboard"
      className={visible ? '' : 'hidden'}
      role="dialog"
      aria-modal="true"
      aria-labelledby="leaderboard-title-text"
      onClick={(event) => event.target === event.currentTarget && close()}
      onKeyDown={(event) => handleDialogKeyDown(event, dialogRef, close)}
    >
      <div ref={dialogRef} id="leaderboard-inner" style={assetBg('leaderboardPanel')}>
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
              <span title="Thắng / Thua — tiêu chí xếp hạng mặc định">W/L ↓</span>
              <span>Ken thắng</span>
            </div>
            <div className="leaderboard-rows" aria-busy={loading}>
              {visiblePlayers.map((player) => (
                <LeaderboardRow key={player.userId} player={player} />
              ))}
              {players.length > 0 && error && !loading && (
                <div className="leaderboard-state compact" role="alert">
                  <span>{error}</span>
                  <button type="button" onClick={() => loadLeaderboard(period)}>
                    Thử lại
                  </button>
                </div>
              )}
              {players.length === 0 && (
                <div className="leaderboard-state" role={error ? 'alert' : 'status'}>
                  <span>{loading ? 'Đang tải bảng xếp hạng...' : error ?? 'Chưa có người chơi xếp hạng.'}</span>
                  {error && !loading && (
                    <button type="button" onClick={() => loadLeaderboard(period)}>
                      Thử lại
                    </button>
                  )}
                </div>
              )}
            </div>
          </section>

          <LeaderboardPager page={page} pageCount={pageCount} onChange={setPage} />
        </div>
      </div>
    </div>
  );
}
