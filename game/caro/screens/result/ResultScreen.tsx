import { useEffect, useMemo, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { expTimeline, initialExpStage, useExpAnimation, type ExpTimeline } from '../../../src/sdk/exp-animation';
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
  const exp = useMemo<ExpTimeline | null>(() => {
    if (result == null || result.expGained == null) return null;
    return expTimeline(result.expBefore, result.expGained);
  }, [result]);
  const animatedStage = useExpAnimation(exp, !pending);
  const expStage = animatedStage ?? initialExpStage(exp);

  return (
    <div
      id="result"
      className={
        result
          ? [
              lose ? 'lose' : draw ? 'draw' : '',
              pending ? 'pending' : 'revealed',
              exp ? 'has-exp' : '',
            ]
              .filter(Boolean)
              .join(' ')
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
        {expStage && (
          <div id="result-exp">
            <div className="result-exp-row">
              <span className="result-exp-gain">+{expGained} EXP</span>
              {expStage.leveledUp && <span className="result-levelup">LÊN CẤP!</span>}
              <span className="result-exp-level">
                {`Lv.${expStage.level}`}
                <span className="result-exp-count">
                  {expStage.required > 0 ? ` · ${expStage.current}/${expStage.required}` : ' · MAX'}
                </span>
              </span>
            </div>
            <div
              className="result-exp-bar"
              role="progressbar"
              aria-label="Kinh nghiệm"
              aria-valuemin={0}
              aria-valuemax={expStage.required || 1}
              aria-valuenow={expStage.required > 0 ? expStage.current : 1}
            >
              <div className="result-exp-fill" style={{ width: `${expStage.ratio * 100}%` }} />
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
