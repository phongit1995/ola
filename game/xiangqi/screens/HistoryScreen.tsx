import { useShallow } from 'zustand/react/shallow';
import type { MatchHistoryEntry } from '../../src/sdk';
import { XqIcon } from '../components/XqIcon';
import { useDialogFocus } from '../components/useDialogFocus';
import { formatHistoryTime, formatKen } from '../helpers/format';
import { PodAvatar } from '../components/PodAvatar';
import { useXiangqi } from '../store/useXiangqi';

const OUTCOME_LABEL = { win: 'Thắng', lose: 'Thua', draw: 'Hòa' } as const;

function historyKenDelta(item: MatchHistoryEntry): number {
  if (Number.isFinite(item.kenDelta)) return item.kenDelta;
  return item.outcome === 'lose' ? -item.bet : 0;
}

export function HistoryScreen() {
  const { historyItems, historyLoading, historyError, retryHistory, closeHistory } = useXiangqi(
    useShallow((s) => ({
      historyItems: s.historyItems,
      historyLoading: s.historyLoading,
      historyError: s.historyError,
      retryHistory: s.retryHistory,
      closeHistory: s.closeHistory,
    })),
  );
  const screenRef = useDialogFocus<HTMLDivElement>({ onEscape: closeHistory });

  return (
    <div
      ref={screenRef}
      className="xq-screen xq-list-screen"
      role="dialog"
      aria-modal="true"
      aria-labelledby="xq-history-title"
      tabIndex={-1}
    >
      <div className="xq-screen-header">
        <button type="button" className="xq-icon-btn" onClick={closeHistory} aria-label="Quay lại" data-dialog-initial-focus>
          <XqIcon name="arrow-left" size={22} />
        </button>
        <h1 id="xq-history-title">Lịch sử đấu</h1>
        <span />
      </div>
      <div className="xq-list" tabIndex={0} aria-label="Danh sách lịch sử đấu">
        {historyLoading ? <div className="xq-empty xq-empty-loading" role="status" aria-live="polite">Đang tải...</div> : null}
        {!historyLoading && historyError ? (
          <div className="xq-empty xq-empty-error" role="alert">
            <XqIcon name="warning" size={28} />
            <strong>Không tải được lịch sử</strong>
            <span>{historyError}</span>
            <button type="button" className="xq-btn xq-btn-paper" onClick={retryHistory}>
              <XqIcon name="refresh" size={18} />
              Thử lại
            </button>
          </div>
        ) : null}
        {!historyLoading && !historyError && historyItems.length === 0 ? <div className="xq-empty xq-empty-state">Chưa có ván nào</div> : null}
        {!historyLoading && !historyError ? historyItems.map((item) => {
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
        }) : null}
      </div>
    </div>
  );
}
