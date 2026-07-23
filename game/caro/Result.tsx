import { assetBg, assetSrc } from './assets';
import { useCaroStore } from './store';

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function Result() {
  const result = useCaroStore((s) => s.result);
  const closeResult = useCaroStore((s) => s.closeResult);
  const again = useCaroStore((s) => s.again);
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
        <div id="result-actions">
          <button
            type="button"
            id="result-replay"
            className="result-btn"
            style={assetBg(win ? 'resultBtnReplayWin' : 'resultBtnReplayLose')}
            onClick={again}
          >
            <span>Chơi lại</span>
          </button>
          <button
            type="button"
            id="result-close"
            className="result-btn"
            style={assetBg(win ? 'resultBtnCloseWin' : 'resultBtnCloseLose')}
            onClick={closeResult}
          >
            <span>Đóng</span>
          </button>
        </div>
      </div>
    </div>
  );
}
