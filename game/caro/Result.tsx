import { assetBg, assetSrc } from './assets';
import type { CaroGame } from './useCaroGame';

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function Result({ game }: { game: CaroGame }) {
  const result = game.result;
  const win = result?.win ?? true;
  const delta = result?.kenDelta ?? null;
  const showKen = delta != null && delta !== 0;

  return (
    <div id="result" className={result ? (win ? '' : 'lose') : 'hidden'}>
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
          <span id="result-ken-text">
            {showKen ? `${delta > 0 ? '+' : '-'}${formatKen(Math.abs(delta))} KEN` : ''}
          </span>
        </div>
        <button type="button" id="result-close" style={assetBg('resultBtnClose')} onClick={game.closeResult}>
          <span>Đóng</span>
        </button>
      </div>
    </div>
  );
}
