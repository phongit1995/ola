import { useEffect, useRef, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { levelFromExp, levelProgress } from '../../../src/sdk';
import { assetBg, assetSrc } from '../../assets';
import { formatKen } from '../../helpers/format';
import { handleDialogKeyDown, useDialogFocus } from '../../helpers/dialog';
import { useCaro } from '../../store/useCaro';
import { useResult } from './useResult';

export function ResultScreen() {
  const cardRef = useRef<HTMLDivElement>(null);
  const result = useCaro((s) => s.result);
  const replayVisible = useCaro((s) => s.replayVisible);
  const closeResult = useCaro((s) => s.closeResult);
  const again = useCaro((s) => s.again);
  const { revealedResult, setRevealedResult } = useResult(
    useShallow((state) => ({
      revealedResult: state.revealedResult,
      setRevealedResult: state.setRevealedResult,
    })),
  );
  const outcome = result?.outcome ?? 'win';
  const win = outcome === 'win';
  const lose = outcome === 'lose';
  const draw = outcome === 'draw';
  const delta = result?.kenDelta ?? null;
  const showKen = delta != null;
  const kenText =
    delta == null
      ? ''
      : delta === 0
        ? '0 KEN'
        : `${delta > 0 ? '+ ' : '- '}${formatKen(Math.abs(delta))} KEN`;
  const pending = result != null && result.revealDelayMs > 0 && revealedResult !== result;
  useDialogFocus(result != null && !pending, cardRef);

  useEffect(() => {
    if (!result) {
      setRevealedResult(null);
      return;
    }
    if (result.revealDelayMs <= 0) return;
    const timer = window.setTimeout(() => setRevealedResult(result), result.revealDelayMs);
    return () => window.clearTimeout(timer);
  }, [result, setRevealedResult]);

  const expGained = result?.expGained ?? null;
  const expInfo =
    result != null && expGained != null
      ? (() => {
          const after = result.expBefore + expGained;
          const progress = levelProgress(after);
          const leveledUp = progress.level > levelFromExp(result.expBefore);
          const startRatio = leveledUp ? 0 : levelProgress(result.expBefore).ratio;
          return { ...progress, leveledUp, startRatio };
        })()
      : null;
  const [expFilled, setExpFilled] = useState(false);
  useEffect(() => {
    setExpFilled(false);
    if (!result || result.expGained == null || pending) return;
    const timer = window.setTimeout(() => setExpFilled(true), 400);
    return () => window.clearTimeout(timer);
  }, [result, pending]);

  return (
    <div
      id="result"
      className={
        result
          ? [lose ? 'lose' : draw ? 'draw' : '', pending ? 'pending' : 'revealed'].filter(Boolean).join(' ')
          : 'hidden'
      }
      role="dialog"
      aria-modal="true"
      aria-labelledby="result-verdict"
      aria-hidden={result == null || pending}
      aria-busy={pending}
      onKeyDown={(event) => {
        if (!pending) handleDialogKeyDown(event, cardRef, closeResult);
      }}
    >
      <div ref={cardRef} id="result-card" style={assetBg('resultBg')}>
        <div className="result-title" style={assetBg('resultTitleFrame')}>
          <span>Kết quả</span>
        </div>
        <img id="result-cup" src={assetSrc(lose ? 'resultCupLose' : 'resultCupWin')} alt="" />
        <div id="result-brush" style={assetBg(lose ? 'resultBrushLose' : 'resultBrushWin')}>
          <span id="result-verdict">{draw ? 'Hòa' : win ? 'Thắng' : 'Thua'}</span>
        </div>
        <div id="result-ken" className={showKen ? '' : 'hidden'} style={assetBg('resultKenFrame')}>
          <img src={assetSrc('resultIcKen')} alt="" />
          <span id="result-ken-text">{kenText}</span>
        </div>
        {expInfo && (
          <div id="result-exp">
            <div className="result-exp-row">
              <span className="result-exp-gain">+{expGained} EXP</span>
              {expInfo.leveledUp && <span className="result-levelup">LÊN CẤP!</span>}
            </div>
            <div className="result-exp-bar" role="progressbar" aria-label="Kinh nghiệm">
              <div
                className="result-exp-fill"
                style={{ width: `${(expFilled ? expInfo.ratio : expInfo.startRatio) * 100}%` }}
              />
            </div>
            <div className="result-exp-level">
              <span>Lv.{expInfo.level}</span>
              <span>{expInfo.required > 0 ? `${expInfo.current}/${expInfo.required}` : 'MAX'}</span>
            </div>
          </div>
        )}
        <div id="result-actions">
          {replayVisible && (
            <button
              type="button"
              id="result-replay"
              className="result-btn"
              style={assetBg(lose ? 'resultBtnReplayLose' : 'resultBtnReplayWin')}
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
            style={assetBg(lose ? 'resultBtnCloseLose' : 'resultBtnCloseWin')}
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
