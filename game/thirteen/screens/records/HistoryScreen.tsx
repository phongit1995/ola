import { useState } from 'react';
import type { MatchHistoryEntry } from '../../../src/sdk';
import kenIcon from '../../assets/icons/ken.png';
import { PlayerAvatar } from '../../components/PlayerAvatar';
import { PlayerName } from '../../components/PlayerName';
import {
  formatPlayedAt,
  formatSignedKen,
  historyKenDelta,
  historyPlace,
  historyPlayerCount,
  historyTablemates,
} from '../../helpers/history';
import { medalTone, placeLabel } from '../../helpers/seats';
import { useThirteen } from '../../store/useThirteen';
import { RecordScreen, RecordStatus } from './RecordScreen';

const MAX_MATE_AVATARS = 3;

function HistoryRow({
  item,
  selfId,
  now,
  open,
  onToggle,
}: {
  item: MatchHistoryEntry;
  selfId: string;
  now: number;
  open: boolean;
  onToggle: () => void;
}) {
  const place = historyPlace(item);
  const total = historyPlayerCount(item);
  const mates = historyTablemates(item, selfId);
  const delta = historyKenDelta(item);
  const ranking = item.players ?? [];
  const expandable = ranking.length > 0;
  const panelId = `tl-history-${item.id}`;

  return (
    <li className={'tl-history-item' + (open ? ' open' : '')} data-tone={place.tone}>
      <button
        type="button"
        className="tl-history-row"
        aria-expanded={expandable ? open : undefined}
        aria-controls={expandable ? panelId : undefined}
        disabled={!expandable}
        onClick={onToggle}
      >
        <span className={`tl-result-medal ${place.tone}`} aria-hidden="true">
          {place.place ?? '–'}
        </span>
        <span className="tl-history-main">
          <span className="tl-history-title">{place.place ? `Về ${place.label}` : place.label}</span>
          <span className="tl-history-meta">
            <span>
              <span className="tl-history-meta-prefix">Bàn </span>
              {total} người
            </span>
            <span className="tl-history-mates" aria-hidden="true">
              {mates.slice(0, MAX_MATE_AVATARS).map((mate) => (
                <PlayerAvatar key={mate.userId} name={mate.username} vipType={mate.vipType} size="sm" />
              ))}
              {mates.length > MAX_MATE_AVATARS && <i>+{mates.length - MAX_MATE_AVATARS}</i>}
            </span>
          </span>
        </span>
        <span className="tl-history-side">
          {item.bet > 0 ? (
            <span className={'tl-history-ken' + (delta > 0 ? ' up' : delta < 0 ? ' down' : '')}>
              {item.outcome === 'draw' ? 'Hoàn cược' : formatSignedKen(delta)}
              <img src={kenIcon} alt="Ken" />
            </span>
          ) : (
            <span className="tl-history-free">Không cược</span>
          )}
          <span className="tl-history-time">{formatPlayedAt(item.playedAt, now)}</span>
        </span>
      </button>
      {expandable && open && (
        <ol id={panelId} className="tl-history-ranking" aria-label="Thứ hạng ván này">
          {ranking.map((player) => {
            const self = player.userId === selfId;
            const rank = player.place ?? 0;
            return (
              <li key={player.userId} className={self ? 'self' : undefined}>
                <span className={`tl-result-medal ${rank ? medalTone(rank, total) : 'plain'}`} aria-hidden="true">
                  {rank || '–'}
                </span>
                <PlayerAvatar name={player.username} vipType={player.vipType} size="sm" />
                <span className="tl-history-rank-name">
                  <PlayerName name={player.username} self={self} />
                </span>
                <span className="tl-history-rank-label">{rank ? placeLabel(rank, total) : 'Thua'}</span>
              </li>
            );
          })}
        </ol>
      )}
    </li>
  );
}

export function HistoryScreen() {
  const selfId = useThirteen((s) => s.user?.id ?? '');
  const history = useThirteen((s) => s.history);
  const retryHistory = useThirteen((s) => s.retryHistory);
  const closeOverlay = useThirteen((s) => s.closeOverlay);
  const [openId, setOpenId] = useState<string | null>(null);
  const [now] = useState(Date.now);
  const ready = !history.loading && !history.error;

  return (
    <RecordScreen title="Lịch sử chơi" titleId="tl-history-title" onClose={closeOverlay}>
      <div className="tl-records-body">
        <RecordStatus
          loading={history.loading}
          error={history.error}
          empty={ready && history.items.length === 0}
          errorTitle="Không tải được lịch sử"
          emptyText="Chưa có ván online nào. Ván tập với máy không lưu ở đây."
          onRetry={retryHistory}
        />
        {ready && history.items.length > 0 && (
          <>
            <ul className="tl-records-list" aria-label="Các ván đã chơi">
              {history.items.map((item) => (
                <HistoryRow
                  key={item.id}
                  item={item}
                  selfId={selfId}
                  now={now}
                  open={openId === item.id}
                  onToggle={() => setOpenId((current) => (current === item.id ? null : item.id))}
                />
              ))}
            </ul>
            <p className="tl-records-note">Hiện tối đa 100 ván gần nhất.</p>
          </>
        )}
      </div>
    </RecordScreen>
  );
}
