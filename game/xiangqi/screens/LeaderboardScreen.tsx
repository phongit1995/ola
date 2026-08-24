import type { KeyboardEvent as ReactKeyboardEvent } from 'react';
import { useShallow } from 'zustand/react/shallow';
import type { LeaderboardPeriod } from '../../src/sdk';
import { XqIcon } from '../components/XqIcon';
import { useDialogFocus } from '../components/useDialogFocus';
import { formatKen } from '../helpers/format';
import { PodAvatar } from '../components/PodAvatar';
import { useXiangqi } from '../store/useXiangqi';

const PERIODS: Array<{ key: LeaderboardPeriod; label: string }> = [
  { key: 'day', label: 'Hôm nay' },
  { key: 'week', label: 'Tuần này' },
];

export function LeaderboardScreen() {
  const {
    leaderboardItems,
    leaderboardPeriod,
    leaderboardLoading,
    leaderboardError,
    retryLeaderboard,
    setLeaderboardPeriod,
    closeLeaderboard,
  } = useXiangqi(
    useShallow((s) => ({
      leaderboardItems: s.leaderboardItems,
      leaderboardPeriod: s.leaderboardPeriod,
      leaderboardLoading: s.leaderboardLoading,
      leaderboardError: s.leaderboardError,
      retryLeaderboard: s.retryLeaderboard,
      setLeaderboardPeriod: s.setLeaderboardPeriod,
      closeLeaderboard: s.closeLeaderboard,
    })),
  );

  const moveTabFocus = (event: ReactKeyboardEvent<HTMLButtonElement>, currentIndex: number) => {
    let nextIndex: number | null = null;
    if (event.key === 'ArrowRight') nextIndex = (currentIndex + 1) % PERIODS.length;
    if (event.key === 'ArrowLeft') nextIndex = (currentIndex - 1 + PERIODS.length) % PERIODS.length;
    if (event.key === 'Home') nextIndex = 0;
    if (event.key === 'End') nextIndex = PERIODS.length - 1;
    if (nextIndex == null) return;
    event.preventDefault();
    const nextPeriod = PERIODS[nextIndex];
    setLeaderboardPeriod(nextPeriod.key);
    event.currentTarget.parentElement
      ?.querySelector<HTMLButtonElement>(`#xq-leaderboard-tab-${nextPeriod.key}`)
      ?.focus();
  };
  const screenRef = useDialogFocus<HTMLDivElement>({ onEscape: closeLeaderboard });

  return (
    <div
      ref={screenRef}
      className="xq-screen xq-list-screen"
      role="dialog"
      aria-modal="true"
      aria-labelledby="xq-leaderboard-title"
      tabIndex={-1}
    >
      <div className="xq-screen-header">
        <button type="button" className="xq-icon-btn" onClick={closeLeaderboard} aria-label="Quay lại" data-dialog-initial-focus>
          <XqIcon name="arrow-left" size={22} />
        </button>
        <h1 id="xq-leaderboard-title">Bảng xếp hạng</h1>
        <span />
      </div>
      <div className="xq-tabs" role="tablist">
        {PERIODS.map((period, index) => (
          <button
            key={period.key}
            id={`xq-leaderboard-tab-${period.key}`}
            type="button"
            role="tab"
            aria-selected={leaderboardPeriod === period.key}
            aria-controls="xq-leaderboard-panel"
            tabIndex={leaderboardPeriod === period.key ? 0 : -1}
            className={`xq-tab ${leaderboardPeriod === period.key ? 'xq-tab-active' : ''}`}
            onClick={() => setLeaderboardPeriod(period.key)}
            onKeyDown={(event) => moveTabFocus(event, index)}
          >
            {period.label}
          </button>
        ))}
      </div>
      <div
        className="xq-list"
        id="xq-leaderboard-panel"
        role="tabpanel"
        aria-labelledby={`xq-leaderboard-tab-${leaderboardPeriod}`}
        tabIndex={0}
        key={leaderboardPeriod}
      >
        {leaderboardLoading ? <div className="xq-empty xq-empty-loading" role="status" aria-live="polite">Đang tải...</div> : null}
        {!leaderboardLoading && leaderboardError ? (
          <div className="xq-empty xq-empty-error" role="alert">
            <XqIcon name="warning" size={28} />
            <strong>Không tải được bảng xếp hạng</strong>
            <span>{leaderboardError}</span>
            <button type="button" className="xq-btn xq-btn-paper" onClick={retryLeaderboard}>
              <XqIcon name="refresh" size={18} />
              Thử lại
            </button>
          </div>
        ) : null}
        {!leaderboardLoading && !leaderboardError && leaderboardItems.length === 0 ? (
          <div className="xq-empty xq-empty-state">Chưa có dữ liệu</div>
        ) : null}
        {!leaderboardLoading && !leaderboardError ? leaderboardItems.map((item) => (
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
        )) : null}
      </div>
    </div>
  );
}
