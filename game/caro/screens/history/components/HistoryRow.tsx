import { assetSrc } from '../../../assets';
import { formatHistoryTime, formatKen } from '../../../helpers/format';
import type { HistoryEntry } from '../../../store/types';

const OUTCOME_LABEL: Record<HistoryEntry['outcome'], string> = {
  win: 'Thắng',
  lose: 'Thua',
  draw: 'Hòa',
};

function OutcomeIcon({ outcome }: { outcome: HistoryEntry['outcome'] }) {
  return (
    <span
      className={`history-outcome-icon ${outcome}`}
      role="img"
      aria-label={OUTCOME_LABEL[outcome]}
      title={OUTCOME_LABEL[outcome]}
    >
      <svg viewBox="0 0 24 24" aria-hidden="true">
        {outcome === 'win' && <path d="m6.5 12.5 3.2 3.2 7.8-8.1" />}
        {outcome === 'lose' && <path d="m7.5 7.5 9 9m0-9-9 9" />}
        {outcome === 'draw' && <path d="M7 12h10" />}
      </svg>
    </span>
  );
}

export function HistoryRow({ entry }: { entry: HistoryEntry }) {
  const { time, date } = formatHistoryTime(entry.playedAt);

  return (
    <>
      <div className="history-cell history-time">
        <span>{time}</span>
        <span className="history-date">{date}</span>
      </div>
      <div className="history-cell history-opponent">
        <span>{entry.opponentId === 'bot' ? entry.opponentName : `@${entry.opponentName}`}</span>
      </div>
      <div className="history-cell history-ken">
        <span>{formatKen(entry.bet)}</span>
        <img src={assetSrc('historyKen')} alt="Ken" />
      </div>
      <div className={`history-cell history-outcome ${entry.outcome}`}>
        <OutcomeIcon outcome={entry.outcome} />
      </div>
    </>
  );
}
