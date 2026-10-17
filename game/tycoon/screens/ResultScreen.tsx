import { useEffect, useId, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { PodAvatar } from '../components/PodAvatar';
import { TileGlyph } from '../components/TileGlyph';
import { useDialogFocus } from '../components/useDialogFocus';
import { formatMoney } from '../helpers/format';
import { placeLabel, SEAT_SOFT_COLORS, seatColor } from '../helpers/player';
import { useTycoon, type RankRow } from '../store/useTycoon';

const REVEAL_MS = 350;
const PODIUM_ORDER = [1, 0, 2];

export function ResultScreen() {
  const { result, you, players, closeResult, playAgain } = useTycoon(
    useShallow((s) => ({ result: s.result, you: s.you, players: s.players, closeResult: s.closeResult, playAgain: s.playAgain })),
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
  const title = placeLabel(result.myPlace, result.rows.length);
  const nameOf = (row: RankRow) => (row.seat === you ? 'Bạn' : row.name);
  const podium = PODIUM_ORDER.map((i) => result.rows[i]).filter(Boolean);
  const rest = result.rows.slice(3);
  return (
    <div className="ty-backdrop ty-result-backdrop">
      <div ref={resultRef} className={`ty-modal ty-result ty-result-place-${result.myPlace}`} role="dialog" aria-modal="true" aria-labelledby={titleId} aria-describedby={reasonId} tabIndex={-1}>
        <div className="ty-result-hero">
          <span className="ty-result-kicker">Kết quả ván chơi</span>
          <h2 className="ty-result-title" id={titleId}>
            {result.myPlace === 1 ? <TileGlyph name="crown" size={28} /> : null}
            {title}
          </h2>
          <p className="ty-result-reason" id={reasonId}>
            {result.reasonText}
          </p>
        </div>
        <ol className="ty-podium" aria-label="Bảng xếp hạng">
          {podium.map((row) => (
            <li
              key={row.seat}
              className={`ty-podium-col ty-podium-${row.place} ${row.seat === you ? 'ty-podium-mine' : ''} ${row.bankrupt ? 'ty-podium-bankrupt' : ''}`}
              style={{ '--seat': seatColor(row.seat), '--seat-soft': SEAT_SOFT_COLORS[row.seat] } as React.CSSProperties}
            >
              <span className="ty-podium-avatar">
                {row.place === 1 ? (
                  <span className="ty-podium-crown" aria-hidden="true">
                    <TileGlyph name="crown" size={22} />
                  </span>
                ) : null}
                <PodAvatar src={players[row.seat]?.avatar} seat={row.seat} size={row.place === 1 ? 52 : 42} />
              </span>
              <span className="ty-podium-name">{nameOf(row)}</span>
              <span className="ty-podium-worth">{row.bankrupt ? 'Phá sản' : formatMoney(row.worth)}</span>
              <span className="ty-podium-block">
                <b>{row.place}</b>
              </span>
            </li>
          ))}
        </ol>
        {rest.length > 0 ? (
          <ol className="ty-result-rows" start={4}>
            {rest.map((row) => (
              <li key={row.seat} className={`ty-result-row ${row.seat === you ? 'ty-result-row-mine' : ''}`} style={{ '--seat': seatColor(row.seat) } as React.CSSProperties}>
                <span className="ty-rank">{row.place}</span>
                <PodAvatar src={players[row.seat]?.avatar} seat={row.seat} size={26} />
                <span className="ty-result-name">{nameOf(row)}</span>
                <span className="ty-result-worth">{row.bankrupt ? 'Phá sản' : formatMoney(row.worth)}</span>
              </li>
            ))}
          </ol>
        ) : null}
        <p className="ty-result-note">Tổng tài sản = tiền mặt + giá đất + giá nhà</p>
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
