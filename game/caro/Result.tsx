import { useEffect, useState } from 'react';
import { assetBg, assetSrc } from './assets';
import { useCaroStore, type MatchResultState } from './store';

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function Result() {
  const result = useCaroStore((s) => s.result);
  const replayVisible = useCaroStore((s) => s.replayVisible);
  const closeResult = useCaroStore((s) => s.closeResult);
  const again = useCaroStore((s) => s.again);
  const [revealedResult, setRevealedResult] = useState<MatchResultState | null>(null);
  const win = result?.win ?? true;
  const delta = result?.kenDelta ?? null;
  const showKen = delta != null;
  const kenText =
    delta == null
      ? ''
      : delta === 0
        ? '0 KEN'
        : `${delta > 0 ? '+ ' : '- '}${formatKen(Math.abs(delta))} KEN`;
  const pending = result != null && result.revealDelayMs > 0 && revealedResult !== result;

  useEffect(() => {
    if (!result || result.revealDelayMs <= 0) return;
    const timer = window.setTimeout(() => setRevealedResult(result), result.revealDelayMs);
    return () => window.clearTimeout(timer);
  }, [result]);

  return (
    <div
      id="result"
      className={
        result
          ? [win ? '' : 'lose', pending ? 'pending' : 'revealed'].filter(Boolean).join(' ')
          : 'hidden'
      }
      aria-hidden={result == null || pending}
      aria-busy={pending}
    >
      <div id="result-card" style={assetBg('resultBg')}>
        <div className="result-title" style={assetBg('resultTitleFrame')}>
          <span>Kết quả</span>
        </div>
        <img id="result-cup" src={assetSrc(win ? 'resultCupWin' : 'resultCupLose')} alt="" />
        <div id="result-brush" style={assetBg(win ? 'resultBrushWin' : 'resultBrushLose')}>
          <span id="result-verdict">{win ? 'Thắng' : 'Thua'}</span>
        </div>
        <div id="result-ken" className={showKen ? '' : 'hidden'} style={assetBg('resultKenFrame')}>
          <img src={assetSrc('resultIcKen')} alt="" />
          <span id="result-ken-text">{kenText}</span>
        </div>
        <div id="result-actions">
          {replayVisible && (
            <button
              type="button"
              id="result-replay"
              className="result-btn"
              style={assetBg(win ? 'resultBtnReplayWin' : 'resultBtnReplayLose')}
              disabled={pending}
              onClick={again}
            >
              <span>Chơi lại</span>
            </button>
          )}
          <button
            type="button"
            id="result-close"
            className="result-btn"
            style={assetBg(win ? 'resultBtnCloseWin' : 'resultBtnCloseLose')}
            disabled={pending}
            onClick={closeResult}
          >
            <span>Đóng</span>
          </button>
        </div>
      </div>
    </div>
  );
}
