import type { KeyboardEvent } from 'react';
import type { LeaderboardEntry, LeaderboardPeriod } from '../../../src/sdk';
import kenIcon from '../../assets/icons/ken.png';
import { PlayerAvatar } from '../../components/PlayerAvatar';
import { PlayerName } from '../../components/PlayerName';
import { leaderboardGames, periodCaption } from '../../helpers/history';
import { formatKen } from '../../helpers/room';
import { useThirteen } from '../../store/useThirteen';
import { RecordScreen, RecordStatus } from './RecordScreen';

const PERIODS: Array<{ key: LeaderboardPeriod; label: string }> = [
  { key: 'day', label: 'Hôm nay' },
  { key: 'week', label: 'Tuần này' },
  { key: 'month', label: 'Tháng này' },
];

const RANK_TONES = ['gold', 'silver', 'bronze'];

function LeaderboardRow({ item, self }: { item: LeaderboardEntry; self: boolean }) {
  const games = leaderboardGames(item);
  const wins = item.wins ?? 0;
  return (
    <li className={'tl-board-row' + (self ? ' self' : '')}>
      <span className={`tl-result-medal ${RANK_TONES[item.rank - 1] ?? 'plain'} tl-board-rank`}>{item.rank}</span>
      <PlayerAvatar name={item.username} vipType={item.vipType} size="sm" />
      <span className="tl-board-main">
        <span className="tl-board-name">
          <PlayerName name={item.username} self={self} />
          {item.level ? <b className="tl-board-level">Lv {item.level}</b> : null}
        </span>
        <span className="tl-board-meta">
          <span>{games} ván</span>
          {item.ken > 0 && (
            <span className="tl-board-ken">
              +{formatKen(item.ken)}
              <img src={kenIcon} alt="Ken" />
            </span>
          )}
        </span>
      </span>
      <span className="tl-board-wins" aria-label={`${wins} lần về Nhất`}>
        <b>{wins}</b>
        <small>Nhất</small>
      </span>
    </li>
  );
}

export function LeaderboardScreen() {
  const selfId = useThirteen((s) => s.user?.id ?? '');
  const board = useThirteen((s) => s.leaderboard);
  const setLeaderboardPeriod = useThirteen((s) => s.setLeaderboardPeriod);
  const closeOverlay = useThirteen((s) => s.closeOverlay);
  const ready = !board.loading && !board.error;
  const caption = periodCaption(board.period, board.from);

  const onTabKeyDown = (event: KeyboardEvent<HTMLButtonElement>, index: number) => {
    const step = event.key === 'ArrowRight' ? 1 : event.key === 'ArrowLeft' ? -1 : 0;
    const target = event.key === 'Home' ? 0 : event.key === 'End' ? PERIODS.length - 1 : step ? (index + step + PERIODS.length) % PERIODS.length : -1;
    if (target < 0) return;
    event.preventDefault();
    const next = PERIODS[target];
    setLeaderboardPeriod(next.key);
    event.currentTarget.parentElement?.querySelector<HTMLButtonElement>(`[data-period="${next.key}"]`)?.focus();
  };

  return (
    <RecordScreen title="Bảng xếp hạng" titleId="tl-board-title" onClose={closeOverlay}>
      <div className="tl-board-tabs" role="tablist" aria-label="Kỳ xếp hạng">
        {PERIODS.map((period, index) => {
          const selected = board.period === period.key;
          return (
            <button
              key={period.key}
              type="button"
              role="tab"
              id={`tl-board-tab-${period.key}`}
              data-period={period.key}
              aria-selected={selected}
              aria-controls="tl-board-panel"
              tabIndex={selected ? 0 : -1}
              className={'tl-board-tab' + (selected ? ' active' : '')}
              onClick={() => !selected && setLeaderboardPeriod(period.key)}
              onKeyDown={(event) => onTabKeyDown(event, index)}
            >
              {period.label}
            </button>
          );
        })}
      </div>
      <p className="tl-board-caption">
        <span>{caption}</span>
        <span>Xếp theo số ván về Nhất</span>
      </p>
      <div id="tl-board-panel" className="tl-records-body" role="tabpanel" aria-labelledby={`tl-board-tab-${board.period}`}>
        <RecordStatus
          loading={board.loading}
          error={board.error}
          empty={ready && board.items.length === 0}
          errorTitle="Không tải được bảng xếp hạng"
          emptyText="Chưa ai về Nhất trong kỳ này. Vào bàn và giành hạng đầu tiên!"
          onRetry={() => setLeaderboardPeriod(board.period)}
        />
        {ready && board.items.length > 0 && (
          <>
            <ol className="tl-records-list" aria-label="Người chơi về Nhất nhiều nhất">
              {board.items.map((item) => (
                <LeaderboardRow key={item.userId} item={item} self={item.userId === selfId} />
              ))}
            </ol>
            <p className="tl-records-note">Bằng số ván Nhất thì ai ít ván thua hơn đứng trên. Hiện top 100.</p>
          </>
        )}
      </div>
    </RecordScreen>
  );
}
