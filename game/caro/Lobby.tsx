import { useState } from 'react';
import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import { assetBg, assetSrc, VIP_DEFAULT_ICON } from './assets';
import type { BotLevel } from './bot';
import type { CaroGame } from './useCaroGame';

function formatKen(value: number): string {
  return Math.round(value).toLocaleString('vi-VN');
}

export function Lobby({ game, progress }: { game: CaroGame; progress: string }) {
  const [pickOpen, setPickOpen] = useState(false);
  const { lobbyPhase: phase, userInfo } = game;

  const cls = [
    !game.lobbyVisible && 'hidden',
    phase === 'loading' && 'loading',
    (phase === 'connecting' || phase === 'error') && 'connecting',
    phase === 'ready' && 'show',
    phase === 'ready' && game.lobbyAnimKey > 1 && 'enter',
  ]
    .filter(Boolean)
    .join(' ');

  const vipTypeId = parseVipTypeId(userInfo?.vipType);
  const vipSrc = vipTypeId != null ? vipIconUrl(vipTypeId) : VIP_DEFAULT_ICON;

  const choose = (level: BotLevel): void => {
    setPickOpen(false);
    game.playBot(level);
  };

  return (
    <div id="lobby" className={cls} data-loading={progress}>
      <div id="lobby-inner" style={assetBg('bg')}>
        <div className="lobby-top-space" />
        <div id="lobby-content">
          <div className="lobby-avatar" style={assetBg('avatarFrame')}>
            <img id="lobby-vip" className={phase === 'ready' ? '' : 'hidden'} src={vipSrc} alt="VIP" />
          </div>
          <div className="lobby-name" style={assetBg('nameFrame')}>
            <span id="lobby-name-text">{userInfo ? (userInfo.guest ? 'Khách' : `@${userInfo.username}`) : '...'}</span>
          </div>
          <div className="lobby-ken" style={assetBg('kenFrame')}>
            <img className="lobby-ken-icon" src={assetSrc('icKen')} alt="Ken" />
            <span id="lobby-ken-text">{formatKen(game.ken)}</span>
            <button type="button" id="lobby-plus" style={assetBg('btnPlus')} aria-label="Nạp Ken" onClick={() => game.showToast('Nạp Ken trong app Ola nhé!')}>
              <img src={assetSrc('icPlus')} alt="" />
            </button>
          </div>
          <button type="button" className="lobby-mode" id="lobby-bot" style={assetBg('modeFrame')} onClick={() => setPickOpen(true)}>
            <img src={assetSrc('icBot')} alt="" />
            <span>Chơi với máy</span>
          </button>
          <button type="button" className="lobby-mode" id="lobby-ranked" style={assetBg('modeFrame')} onClick={game.playRanked}>
            <img src={assetSrc('icRanked')} alt="" />
            <span>Chơi xếp hạng</span>
          </button>
        </div>
        <div id="lobby-status" className={phase === 'connecting' || phase === 'error' ? '' : 'hidden'}>
          <span id="lobby-status-text">{phase === 'error' ? 'Không kết nối được máy chủ' : 'Đang kết nối máy chủ...'}</span>
          <button type="button" id="lobby-retry" className={phase === 'error' ? '' : 'hidden'} onClick={game.retry}>
            Thử lại
          </button>
        </div>
        <div className="lobby-bottom" style={assetBg('bottomFrame')}>
          <button type="button" id="lobby-history" onClick={() => game.showToast('Tính năng đang phát triển')}>
            <img src={assetSrc('icHistory')} alt="" />
            <span>Lịch sử</span>
          </button>
          <button type="button" id="lobby-leaderboard" onClick={() => game.showToast('Tính năng đang phát triển')}>
            <img src={assetSrc('icLeaderboard')} alt="" />
            <span>Bảng xếp hạng</span>
          </button>
          <button type="button" id="lobby-exit" onClick={game.exitApp}>
            <img src={assetSrc('icExit')} alt="" />
            <span>Thoát</span>
          </button>
        </div>
        <div id="lobby-toast" className={game.toast ? 'show' : 'hidden'}>
          {game.toast}
        </div>
      </div>
      <div id="lobby-pick" className={pickOpen ? '' : 'hidden'} onClick={(e) => e.target === e.currentTarget && setPickOpen(false)}>
        <div id="lobby-pick-card" style={assetBg('pickBg')}>
          <div className="pick-body">
            <div id="lobby-pick-title" style={assetBg('pickTitle')}>
              <span>Chơi với máy</span>
            </div>
            <div id="lobby-pick-levels">
              <button type="button" data-level="easy" style={assetBg('pickLevel')} onClick={() => choose('easy')}>
                <span>Dễ</span>
              </button>
              <button type="button" data-level="normal" style={assetBg('pickLevel')} onClick={() => choose('normal')}>
                <span>Vừa</span>
              </button>
              <button type="button" data-level="hard" style={assetBg('pickLevel')} onClick={() => choose('hard')}>
                <span>Khó</span>
              </button>
            </div>
          </div>
          <button type="button" id="lobby-pick-close" style={assetBg('pickClose')} aria-label="Đóng" onClick={() => setPickOpen(false)}>
            <img src={assetSrc('pickX')} alt="Đóng" />
          </button>
        </div>
      </div>
    </div>
  );
}
