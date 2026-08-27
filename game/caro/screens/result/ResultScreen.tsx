import { useEffect, useMemo, useRef, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { levelProgress, type LevelProgress } from '../../../src/sdk';
import { assetBg, assetSrc } from '../../assets';
import { formatKen } from '../../helpers/format';
import { handleDialogKeyDown, useDialogFocus } from '../../helpers/dialog';
import { useCaro } from '../../store/useCaro';
import { useResult } from './useResult';

const EXP_DELAY_MS = 520;
const EXP_FILL_MS = 650;
const EXP_LEVELUP_HOLD_MS = 260;

interface ExpTimeline {
  before: LevelProgress;
  after: LevelProgress;
  leveledUp: boolean;
}

interface ExpStage {
  ratio: number;
  level: number;
  current: number;
  required: number;
  leveledUp: boolean;
}

function easeOut(t: number): number {
  const k = Math.min(1, Math.max(0, t));
  return 1 - (1 - k) * (1 - k);
}

function stageOf(progress: LevelProgress, ratio: number, leveledUp: boolean): ExpStage {
  const capped = progress.required > 0 ? ratio : 1;
  return {
    ratio: capped,
    level: progress.level,
    current: Math.round(capped * progress.required),
    required: progress.required,
    leveledUp,
  };
}

function useExpAnimation(exp: ExpTimeline | null, active: boolean): ExpStage | null {
  const [stage, setStage] = useState<ExpStage | null>(null);

  useEffect(() => {
    if (!exp || !active) {
      setStage(null);
      return;
    }
    const final = stageOf(exp.after, exp.after.ratio, exp.leveledUp);
    if (window.matchMedia?.('(prefers-reduced-motion: reduce)').matches) {
      setStage(final);
      return;
    }

    const startRatio = exp.before.required > 0 ? exp.before.ratio : 1;
    const fillTarget = exp.leveledUp ? 1 : final.ratio;
    const holdStart = EXP_DELAY_MS + EXP_FILL_MS;
    const pourStart = holdStart + EXP_LEVELUP_HOLD_MS;
    setStage(stageOf(exp.before, startRatio, false));

    let raf = 0;
    const startedAt = performance.now();
    const step = (now: number): void => {
      const elapsed = now - startedAt;
      if (elapsed < EXP_DELAY_MS) {
        raf = requestAnimationFrame(step);
        return;
      }
      if (elapsed < holdStart) {
        const ratio = startRatio + (fillTarget - startRatio) * easeOut((elapsed - EXP_DELAY_MS) / EXP_FILL_MS);
        setStage(stageOf(exp.before, ratio, false));
        raf = requestAnimationFrame(step);
        return;
      }
      if (!exp.leveledUp) {
        setStage(final);
        return;
      }
      if (elapsed < pourStart) {
        setStage(stageOf(exp.before, 1, true));
        raf = requestAnimationFrame(step);
        return;
      }
      const poured = easeOut((elapsed - pourStart) / EXP_FILL_MS);
      setStage(stageOf(exp.after, final.ratio * poured, true));
      if (poured < 1) raf = requestAnimationFrame(step);
    };
    raf = requestAnimationFrame(step);
    return () => cancelAnimationFrame(raf);
  }, [exp, active]);

  return stage;
}

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
    const before = levelProgress(result.expBefore);
    const after = levelProgress(result.expBefore + result.expGained);
    return { before, after, leveledUp: after.level > before.level };
  }, [result]);
  const animatedStage = useExpAnimation(exp, !pending);
  const expStage =
    animatedStage ?? (exp ? stageOf(exp.before, exp.before.required > 0 ? exp.before.ratio : 1, false) : null);

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
