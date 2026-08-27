import { useEffect, useState } from 'react';
import { levelProgress, type LevelProgress } from './progression';

const EXP_DELAY_MS = 520;
const EXP_FILL_MS = 650;
const EXP_LEVELUP_HOLD_MS = 260;

export interface ExpTimeline {
  before: LevelProgress;
  after: LevelProgress;
  leveledUp: boolean;
}

export interface ExpStage {
  ratio: number;
  level: number;
  current: number;
  required: number;
  leveledUp: boolean;
}

export function expTimeline(expBefore: number, expGained: number): ExpTimeline {
  const before = levelProgress(expBefore);
  const after = levelProgress(expBefore + expGained);
  return { before, after, leveledUp: after.level > before.level };
}

function easeOut(t: number): number {
  const k = Math.min(1, Math.max(0, t));
  return 1 - (1 - k) * (1 - k);
}

export function stageOf(progress: LevelProgress, ratio: number, leveledUp: boolean): ExpStage {
  const capped = progress.required > 0 ? ratio : 1;
  return {
    ratio: capped,
    level: progress.level,
    current: Math.round(capped * progress.required),
    required: progress.required,
    leveledUp,
  };
}

export function initialExpStage(exp: ExpTimeline | null): ExpStage | null {
  if (!exp) return null;
  return stageOf(exp.before, exp.before.required > 0 ? exp.before.ratio : 1, false);
}

export function useExpAnimation(exp: ExpTimeline | null, active: boolean): ExpStage | null {
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
