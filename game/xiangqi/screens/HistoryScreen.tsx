import { useShallow } from 'zustand/react/shallow';
import type { MatchHistoryEntry } from '../../src/sdk';
import { XqIcon } from '../components/XqIcon';
import { formatHistoryTime, formatKen } from '../helpers/format';
import { PodAvatar } from '../components/PodAvatar';
import { useXiangqi } from '../store/useXiangqi';

const OUTCOME_LABEL = { win: 'Thắng', lose: 'Thua', draw: 'Hòa' } as const;

function historyKenDelta(item: MatchHistoryEntry): number {
  if (Number.isFinite(item.kenDelta)) return item.kenDelta;
  return item.outcome === 'lose' ? -item.bet : 0;
}

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
          <XqIcon name="arrow-left" size={22} />
        </button>
        <h1>Lịch sử đấu</h1>
        <span />
      </div>
      <div className="xq-list">
        {historyLoading ? <div className="xq-empty xq-empty-loading">Đang tải...</div> : null}
        {!historyLoading && historyItems.length === 0 ? <div className="xq-empty xq-empty-state">Chưa có ván nào</div> : null}
        {historyItems.map((item) => {
          const kenDelta = historyKenDelta(item);
          return (
            <div key={item.id} className="xq-list-row">
              <PodAvatar vipType={item.opponentVipType} tone="black" />
              <div className="xq-list-main">
                <span className="xq-list-name">@{item.opponentName}</span>
                <span className="xq-list-sub">{formatHistoryTime(item.playedAt)}</span>
              </div>
              <div className="xq-list-right">
                <span className={`xq-chip xq-chip-${item.outcome}`}>{OUTCOME_LABEL[item.outcome]}</span>
                {item.bet > 0 ? (
                  <span className={`xq-list-ken ${kenDelta > 0 ? 'xq-pos' : kenDelta < 0 ? 'xq-neg' : ''}`}>
                    {item.outcome === 'draw'
                      ? 'Hoàn cược'
                      : `${kenDelta < 0 ? '−' : '+'}${formatKen(Math.abs(kenDelta))}`}
                  </span>
                ) : null}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
