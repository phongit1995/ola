import { RESULT_ASSETS } from './assets';

export interface ResultDeps {
  onClose(): void;
}

const el = {
  box: document.getElementById('result')!,
  cup: document.getElementById('result-cup') as HTMLImageElement,
  brush: document.getElementById('result-brush')!,
  verdict: document.getElementById('result-verdict')!,
  ken: document.getElementById('result-ken')!,
  kenText: document.getElementById('result-ken-text')!,
  close: document.getElementById('result-close')!,
};

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function showResult(win: boolean, kenDelta?: number | null): void {
  el.box.classList.toggle('lose', !win);
  el.cup.src = win ? RESULT_ASSETS.resultCupWin : RESULT_ASSETS.resultCupLose;
  el.brush.style.backgroundImage = `url('${win ? RESULT_ASSETS.resultBrushWin : RESULT_ASSETS.resultBrushLose}')`;
  el.verdict.textContent = win ? 'Thắng' : 'Thua';

  if (kenDelta == null || kenDelta === 0) {
    el.ken.classList.add('hidden');
  } else {
    el.ken.classList.remove('hidden');
    const sign = kenDelta > 0 ? '+' : '-';
    el.kenText.textContent = `${sign}${formatKen(Math.abs(kenDelta))} KEN`;
  }

  el.box.classList.remove('hidden');
}

export function hideResult(): void {
  el.box.classList.add('hidden');
}

export function buildResult(deps: ResultDeps): void {
  el.close.addEventListener('click', () => {
    hideResult();
    deps.onClose();
  });
}
