import { useEffect, useId, useMemo, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { expTimeline, initialExpStage, useExpAnimation, type ExpTimeline } from '../../src/sdk/exp-animation';
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

  const expGained = result?.expGained ?? null;
  const exp = useMemo<ExpTimeline | null>(() => {
    if (result == null || result.expGained == null) return null;
    return expTimeline(result.expBefore, result.expGained);
  }, [result]);
  const animatedStage = useExpAnimation(exp, !pending);
  const expStage = animatedStage ?? initialExpStage(exp);

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
          {expStage && (
            <div className="xq-result-exp">
              <div className="xq-result-exp-row">
                <span className="xq-result-exp-gain">+{expGained} EXP</span>
                {expStage.leveledUp && <span className="xq-result-levelup">LÊN CẤP!</span>}
                <span className="xq-result-exp-level">
                  {`Lv.${expStage.level}`}
                  <span className="xq-result-exp-count">
                    {expStage.required > 0 ? ` · ${expStage.current}/${expStage.required}` : ' · MAX'}
                  </span>
                </span>
              </div>
              <div
                className="xq-result-exp-bar"
                role="progressbar"
                aria-label="Kinh nghiệm"
                aria-valuemin={0}
                aria-valuemax={expStage.required || 1}
                aria-valuenow={expStage.required > 0 ? expStage.current : 1}
              >
                <div className="xq-result-exp-fill" style={{ width: `${expStage.ratio * 100}%` }} />
              </div>
            </div>
          )}
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
