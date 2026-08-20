import { useEffect, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { formatKen } from '../helpers/format';
import { useXiangqi } from '../store/useXiangqi';

const REVEAL_MS = 900;

export function ResultScreen() {
  const { result, roomWaiting, closeResult, playAgain } = useXiangqi(
    useShallow((s) => ({
      result: s.result,
      roomWaiting: s.roomWaiting,
      closeResult: s.closeResult,
      playAgain: s.playAgain,
    })),
  );
  const [pending, setPending] = useState(true);

  useEffect(() => {
    setPending(true);
    const timer = setTimeout(() => setPending(false), REVEAL_MS);
    return () => clearTimeout(timer);
  }, [result?.matchId]);

  if (!result) return null;
  const title = result.outcome === 'win' ? 'THẮNG' : result.outcome === 'lose' ? 'THUA' : 'HÒA';
  return (
    <div className="xq-backdrop xq-result-backdrop">
      <div className={`xq-modal xq-result xq-result-${result.outcome}`} role="dialog" aria-modal="true" aria-label="Kết quả">
        <div className="xq-result-glyphs">
          <span className="xq-logo-piece xq-piece-red">帥</span>
          <span className="xq-logo-piece xq-piece-black">將</span>
        </div>
        <h2 className="xq-result-title">{title}</h2>
        <p className="xq-result-reason">{result.reasonText}</p>
        <p className="xq-result-ken">
          {result.kenDelta == null
            ? 'Hòa — hoàn cược'
            : result.kenDelta === 0
              ? 'Ván giao hữu'
              : result.kenDelta > 0
                ? `+${formatKen(result.kenDelta)} KEN`
                : `−${formatKen(Math.abs(result.kenDelta))} KEN`}
        </p>
        <div className="xq-modal-actions">
          {roomWaiting ? (
            <button type="button" className="xq-btn xq-btn-gold" disabled={pending} onClick={playAgain}>
              Chơi lại
            </button>
          ) : null}
          <button type="button" className="xq-btn xq-btn-paper" disabled={pending} onClick={closeResult}>
            Đóng
          </button>
        </div>
      </div>
    </div>
  );
}
