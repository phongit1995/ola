import { useEffect, useId, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { useDialogFocus } from '../components/useDialogFocus';
import { formatMoney } from '../helpers/format';
import { placeLabel, seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';

const REVEAL_MS = 350;

export function ResultScreen() {
  const { result, you, closeResult, playAgain } = useTycoon(
    useShallow((s) => ({ result: s.result, you: s.you, closeResult: s.closeResult, playAgain: s.playAgain })),
  );
  const [pending, setPending] = useState(true);
  const titleId = useId();
  const reasonId = useId();
  const resultRef = useDialogFocus<HTMLDivElement>({
    enabled: !!result,
    initialFocusDelayMs: REVEAL_MS + 25,
    onEscape: () => {
      if (!pending) closeResult();
    },
  });

  useEffect(() => {
    setPending(true);
    const timer = setTimeout(() => setPending(false), REVEAL_MS);
    return () => clearTimeout(timer);
  }, [result?.matchId]);

  if (!result) return null;
  const maxWorth = Math.max(1, ...result.rows.map((row) => row.worth));
  const title = placeLabel(result.myPlace, result.rows.length);
  return (
    <div className="ty-backdrop ty-result-backdrop">
      <div ref={resultRef} className={`ty-modal ty-result ty-result-place-${result.myPlace}`} role="dialog" aria-modal="true" aria-labelledby={titleId} aria-describedby={reasonId} tabIndex={-1}>
        <div className="ty-result-hero">
          <span className="ty-result-kicker">Kết quả ván chơi</span>
          <h2 className="ty-result-title" id={titleId}>
            {title}
          </h2>
          <p className="ty-result-reason" id={reasonId}>
            {result.reasonText}
          </p>
        </div>
        <ol className="ty-result-rows">
          {result.rows.map((row) => (
            <li key={row.seat} className={`ty-result-row ${row.seat === you ? 'ty-result-row-mine' : ''} ${row.bankrupt ? 'ty-result-row-bankrupt' : ''}`} style={{ '--seat': seatColor(row.seat) } as React.CSSProperties}>
              <span className={`ty-rank ty-rank-${row.place}`}>{row.place}</span>
              <span className="ty-result-name">{row.seat === you ? 'Bạn' : row.name}</span>
              <span className="ty-result-bar" aria-hidden="true">
                <i style={{ width: `${Math.max(4, (row.worth / maxWorth) * 100)}%` }} />
              </span>
              <span className="ty-result-worth">{row.bankrupt ? 'Phá sản' : formatMoney(row.worth)}</span>
            </li>
          ))}
        </ol>
        <div className="ty-modal-actions">
          <button type="button" className="ty-btn ty-btn-paper" disabled={pending} onClick={closeResult}>
            Về sảnh
          </button>
          <button type="button" className="ty-btn ty-btn-gold" disabled={pending} aria-busy={pending} onClick={playAgain} data-dialog-initial-focus>
            Chơi lại
          </button>
        </div>
      </div>
    </div>
  );
}
