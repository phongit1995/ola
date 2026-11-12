import { useEffect, useId, useState, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { pawnArt } from '../components/art';
import { KenBadge, UiAvatar, UiButton } from '../components/Ui';
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
  const winner = result.rows[0];
  const title = result.spectator ? `@${winner?.name ?? '?'} thắng` : placeLabel(result.myPlace, result.rows.length);
  const nameOf = (row: RankRow) => (row.seat === you ? 'Bạn' : row.name);
  const podium = PODIUM_ORDER.map((i) => result.rows[i]).filter(Boolean);
  const rest = result.rows.slice(3);
  return (
    <div className="ui-modal-layer ty-result-layer">
      <div className="ui-scrim" aria-hidden="true" />
      <div ref={resultRef} className={`ui-panel ui-modal ty-result ty-result-place-${result.myPlace}`} role="dialog" aria-modal="true" aria-labelledby={titleId} aria-describedby={reasonId} tabIndex={-1}>
        <div className="ty-result-hero">
          <span className="ui-kicker">Kết quả ván chơi</span>
          <h2 className="ty-result-title" id={titleId}>
            {title}
          </h2>
          <p className="ty-result-reason" id={reasonId}>
            {result.reasonText}
          </p>
          {result.kenDelta != null || result.exp != null ? (
            <p className="ty-result-gain">
              {result.kenDelta != null ? <KenBadge amount={result.kenDelta} signed className={`ui-chip ${result.kenDelta >= 0 ? 'ty-result-ken-up' : 'ty-result-ken-down'}`} /> : null}
              {result.exp != null ? <span className="ui-chip">+{result.exp} EXP</span> : null}
            </p>
          ) : null}
        </div>
        <ol className="ty-podium" aria-label="Bảng xếp hạng">
          {podium.map((row) => (
            <li
              key={row.seat}
              className={`ty-podium-col ty-podium-${row.place} ${row.seat === you ? 'ty-podium-mine' : ''} ${row.bankrupt ? 'ty-podium-bankrupt' : ''}`}
              style={{ '--seat': seatColor(row.seat), '--seat-soft': SEAT_SOFT_COLORS[row.seat] } as CSSProperties}
            >
              <img className="ty-podium-pawn " src={pawnArt(row.seat)} alt="" draggable={false} />
              <span className="ty-podium-name">
                <UiAvatar src={players[row.seat]?.avatar} size={18} ring={seatColor(row.seat)} />
                {nameOf(row)}
              </span>
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
              <li key={row.seat} className={`ty-result-row ${row.seat === you ? 'ty-result-row-mine' : ''}`} style={{ '--seat': seatColor(row.seat) } as CSSProperties}>
                <span className="ty-rank">{row.place}</span>
                <UiAvatar src={players[row.seat]?.avatar} size={22} ring={seatColor(row.seat)} />
                <span className="ty-result-name">{nameOf(row)}</span>
                <span className="ty-result-worth">{row.bankrupt ? 'Phá sản' : formatMoney(row.worth)}</span>
              </li>
            ))}
          </ol>
        ) : null}
        <div className="ui-actions">
          <UiButton tone={result.spectator ? 'gold' : undefined} disabled={pending} onClick={closeResult}>
            {result.spectator ? 'Về danh sách bàn' : 'Về sảnh'}
          </UiButton>
          {result.spectator ? null : (
            <UiButton tone="gold" disabled={pending} aria-busy={pending} onClick={playAgain} data-dialog-initial-focus>
              Chơi lại
            </UiButton>
          )}
        </div>
      </div>
    </div>
  );
}
