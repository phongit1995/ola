import { useShallow } from 'zustand/react/shallow';
import { formatHistoryTime, formatKen } from '../helpers/format';
import { useXiangqi } from '../store/useXiangqi';

const OUTCOME_LABEL = { win: 'Thắng', lose: 'Thua', draw: 'Hòa' } as const;

export function HistoryScreen() {
  const { historyItems, historyLoading, closeHistory } = useXiangqi(
    useShallow((s) => ({
      historyItems: s.historyItems,
      historyLoading: s.historyLoading,
      closeHistory: s.closeHistory,
    })),
  );

  return (
    <div className="xq-screen xq-list-screen">
      <div className="xq-screen-header">
        <button type="button" className="xq-icon-btn" onClick={closeHistory} aria-label="Quay lại">
          ←
        </button>
        <h1>Lịch sử đấu</h1>
        <span />
      </div>
      <div className="xq-list">
        {historyLoading ? <div className="xq-empty">Đang tải...</div> : null}
        {!historyLoading && historyItems.length === 0 ? <div className="xq-empty">Chưa có ván nào</div> : null}
        {historyItems.map((item) => (
          <div key={item.id} className="xq-list-row">
            <div className="xq-pod-avatar xq-pod-avatar-black">{item.opponentName.slice(0, 1).toUpperCase()}</div>
            <div className="xq-list-main">
              <span className="xq-list-name">{item.opponentName}</span>
              <span className="xq-list-sub">{formatHistoryTime(item.playedAt)}</span>
            </div>
            <div className="xq-list-right">
              <span className={`xq-chip xq-chip-${item.outcome}`}>{OUTCOME_LABEL[item.outcome]}</span>
              {item.bet > 0 ? (
                <span className={`xq-list-ken ${item.outcome === 'win' ? 'xq-pos' : item.outcome === 'lose' ? 'xq-neg' : ''}`}>
                  {item.outcome === 'draw' ? '0' : item.outcome === 'win' ? '+' : '−'}
                  {item.outcome === 'draw' ? '' : formatKen(item.bet)}
                </span>
              ) : null}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
