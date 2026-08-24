import { useEffect, useId, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { useDialogFocus } from '../components/useDialogFocus';
import { formatKen } from '../helpers/format';
import { useXiangqi } from '../store/useXiangqi';

// The store already holds the modal back until the closing move is on the board,
// so this only needs to swallow a stray tap landing on the fresh buttons.
const REVEAL_MS = 350;

export function ResultScreen() {
  const { result, roomWaiting, gameMode, bet, closeResult, playAgain } = useXiangqi(
    useShallow((s) => ({
      result: s.result,
      roomWaiting: s.roomWaiting,
      gameMode: s.gameMode,
      bet: s.bet,
      closeResult: s.closeResult,
      playAgain: s.playAgain,
    })),
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
  const title = result.outcome === 'win' ? 'THẮNG' : result.outcome === 'lose' ? 'THUA' : 'HÒA';
  return (
    <div className="xq-backdrop xq-result-backdrop">
      <div
        ref={resultRef}
        className={`xq-modal xq-result xq-result-${result.outcome}`}
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={reasonId}
        tabIndex={-1}
      >
        <div className="xq-result-hero">
          <span className="xq-result-kicker">{gameMode === 'bot' ? 'Kết quả đấu máy' : 'Kết quả ván cờ'}</span>
          <div className="xq-result-glyphs" aria-hidden="true">
            <span className="xq-logo-piece xq-piece-red">帥</span>
            <span className="xq-logo-piece xq-piece-black">將</span>
          </div>
          <h2 className="xq-result-title" id={titleId}>{title}</h2>
        </div>
        <div className="xq-result-summary">
          <p className="xq-result-reason" id={reasonId}>{result.reasonText}</p>
          <p className="xq-result-ken">
            {gameMode === 'bot'
              ? 'Luyện tập · Không tính KEN'
              : result.outcome === 'draw' && bet > 0
                ? 'Hòa — hoàn cược'
                : result.kenDelta == null || result.kenDelta === 0
                ? 'Ván giao hữu'
                : result.kenDelta > 0
                  ? `+${formatKen(result.kenDelta)} KEN`
                  : `−${formatKen(Math.abs(result.kenDelta))} KEN`}
          </p>
        </div>
        <div className="xq-modal-actions">
          {roomWaiting || gameMode === 'bot' ? (
            <button
              type="button"
              className="xq-btn xq-btn-gold"
              disabled={pending}
              aria-busy={pending}
              onClick={playAgain}
              data-dialog-initial-focus
            >
              Chơi lại
            </button>
          ) : null}
          <button
            type="button"
            className="xq-btn xq-btn-paper"
            disabled={pending}
            onClick={closeResult}
            data-dialog-initial-focus={roomWaiting || gameMode === 'bot' ? undefined : ''}
          >
            Đóng
          </button>
        </div>
      </div>
    </div>
  );
}
