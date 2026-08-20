import { placeLabel } from '../../helpers/seats';
import { avatarTone } from '../../helpers/avatar';
import { useThirteen } from '../../store/useThirteen';

const INSTANT_WIN_LABEL: Record<string, string> = {
  fourTwos: 'Tứ quý heo — tới trắng!',
  dragonStraight: 'Sảnh rồng — tới trắng!',
  fourPairRun: '4 đôi thông — tới trắng!',
  sixPairs: '6 đôi — tới trắng!',
};

export function ResultScreen() {
  const result = useThirteen((s) => s.result);
  const players = useThirteen((s) => s.players);
  const user = useThirteen((s) => s.user);
  const room = useThirteen((s) => s.room);
  const closeResult = useThirteen((s) => s.closeResult);

  if (!result) return null;
  const total = players.length;
  const rankings =
    result.rankings.length > 0
      ? result.rankings
      : result.winnerId
        ? [{ userId: result.winnerId, place: 1 }]
        : [];
  const nameOf = (userId: string): string => {
    if (userId === user?.id) return 'Bạn';
    return players.find((p) => p.id === userId)?.name ?? 'Người chơi';
  };

  return (
    <div className="tl-modal-backdrop tl-result-backdrop">
      <div className="tl-result-card" role="dialog" aria-modal="true" aria-labelledby="tl-result-title">
        <div id="tl-result-title" className="tl-result-banner">KẾT QUẢ</div>
        {result.instantWin && <div className="tl-result-instant">{INSTANT_WIN_LABEL[result.instantWin] ?? result.instantWin}</div>}
        {result.reason === 'disconnect' && <div className="tl-result-note">Ván kết thúc do mất kết nối</div>}
        {result.reason === 'forfeit' && <div className="tl-result-note">Ván kết thúc do có người rời bàn</div>}
        <div className="tl-result-rows">
          {rankings.map((entry) => (
            <div
              key={entry.userId}
              className={
                'tl-result-row' +
                (entry.place === 1 ? ' first' : '') +
                (entry.place === total ? ' last' : '') +
                (entry.userId === user?.id ? ' me' : '')
              }
            >
              <span className="tl-result-place">{entry.place}</span>
              <span className={`tl-avatar tl-avatar-${avatarTone(entry.userId)}`}>
                {nameOf(entry.userId).charAt(0).toUpperCase()}
              </span>
              <span className="tl-result-name">
                {nameOf(entry.userId)}
                {entry.userId === user?.id && entry.place === 1 && <i aria-label="Bạn" />}
              </span>
              <span
                className={
                  'tl-badge ' +
                  (entry.place === 1 ? 'tl-badge-gold' : entry.place === total ? 'tl-badge-red' : '')
                }
              >
                {placeLabel(entry.place, total)}
              </span>
            </div>
          ))}
          {rankings.length === 0 && <div className="tl-result-note">Ván đấu không có kết quả</div>}
        </div>
        <div className="tl-modal-actions">
          <button type="button" className="tl-btn tl-btn-ghost" onClick={() => closeResult(false)}>
            Rời bàn
          </button>
          <button type="button" className="tl-btn tl-btn-gold" onClick={() => closeResult(true)}>
            {room ? 'Chơi tiếp' : 'Về sảnh'}
          </button>
        </div>
      </div>
    </div>
  );
}
