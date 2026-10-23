import { useEffect, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import logoUrl from '../assets/lobby/logo.webp';
import heroUrl from '../assets/lobby/hero-properties.webp';
import diceUrl from '../assets/lobby/ill-dice.webp';
import botUrl from '../assets/lobby/ill-bot.webp';
import historyUrl from '../assets/lobby/ill-history.webp';
import leaderboardUrl from '../assets/lobby/ill-leaderboard.webp';
import rulesUrl from '../assets/lobby/ill-rules.webp';
import exitDoorUrl from '../assets/lobby/ill-exit-door.webp';
import exitArrowUrl from '../assets/lobby/ill-exit-arrow.webp';
import ctaRaysUrl from '../assets/lobby/decor-cta-rays.svg';
import heroRaysUrl from '../assets/lobby/decor-hero-rays.svg';
import mascotUrl from '../assets/chars/ty-idle-full.webp';
import { DiceLoader } from '../components/loading/DiceLoader';
import { useTycoon } from '../store/useTycoon';
import { LobbyTopbar } from './LobbyTopbar';

export function LobbyScreen() {
  const { profile, lobbyFocus, setRoomsOpen, setSetupOpen, setRulesOpen, setLeaderboardOpen, setHistoryOpen, clearLobbyFocus, exitGame } = useTycoon(
    useShallow((s) => ({
      profile: s.profile,
      lobbyFocus: s.lobbyFocus,
      setRoomsOpen: s.setRoomsOpen,
      setSetupOpen: s.setSetupOpen,
      setRulesOpen: s.setRulesOpen,
      setLeaderboardOpen: s.setLeaderboardOpen,
      setHistoryOpen: s.setHistoryOpen,
      clearLobbyFocus: s.clearLobbyFocus,
      exitGame: s.exitGame,
    })),
  );
  const historyRef = useRef<HTMLButtonElement>(null);
  const leaderboardRef = useRef<HTMLButtonElement>(null);
  const loading = profile === null;

  useEffect(() => {
    if (!lobbyFocus) return;
    (lobbyFocus === 'history' ? historyRef : leaderboardRef).current?.focus();
    clearLobbyFocus();
  }, [lobbyFocus, clearLobbyFocus]);
  const art = (
    <>
      <h1 className="ty-lb-logo">
        <img src={logoUrl} alt="Cờ Tỷ Phú" draggable={false} />
      </h1>
      <div className="ty-lb-hero" aria-hidden="true">
        {!loading && (
          <div className="ty-lb-props">
            <img src={heroRaysUrl} alt="" draggable={false} />
            <img src={heroUrl} alt="" draggable={false} />
          </div>
        )}
        <img className="ty-lb-mascot" src={mascotUrl} alt="" draggable={false} />
      </div>
    </>
  );

  return (
    <div className={`ty-lobby${loading ? ' ty-lobby-loading' : ''}`} style={{ '--ty-lb-bg': `url(${bgUrl})` } as React.CSSProperties}>
      <LobbyTopbar />

      {loading ? (
        <div className="ty-lb-loading-stage">
          {art}
          <div className="ty-lb-loading-indicator">
            <DiceLoader />
          </div>
        </div>
      ) : art}

      {!loading && (
        <nav className="ty-lb-menu" aria-label="Menu sảnh">
          <div className="ty-lb-cta">
            <img className="ty-lb-cta-rays" src={ctaRaysUrl} alt="" draggable={false} />
            <button type="button" className="ty-lb-btn ty-lb-btn-gold" onClick={() => setRoomsOpen(true)}>
              <img src={diceUrl} alt="" draggable={false} />
              <span>Vào bàn</span>
            </button>
            <img className="ty-lb-cta-rays" src={ctaRaysUrl} alt="" draggable={false} />
          </div>
          <button type="button" className="ty-lb-btn ty-lb-btn-mint" onClick={() => setSetupOpen(true)}>
            <img src={botUrl} alt="" draggable={false} />
            <span>Chơi với máy</span>
          </button>
          <button ref={historyRef} type="button" className="ty-lb-btn ty-lb-btn-paper" onClick={() => setHistoryOpen(true)}>
            <img src={historyUrl} alt="" draggable={false} />
            <span>Lịch sử</span>
          </button>
          <button ref={leaderboardRef} type="button" className="ty-lb-btn ty-lb-btn-paper" onClick={() => setLeaderboardOpen(true)}>
            <img src={leaderboardUrl} alt="" draggable={false} />
            <span>Bảng xếp hạng</span>
          </button>
          <button type="button" className="ty-lb-btn ty-lb-btn-text" onClick={() => setRulesOpen(true)}>
            <img src={rulesUrl} alt="" draggable={false} />
            <span>Luật chơi</span>
          </button>
        </nav>
      )}

      <footer className="ty-lb-footer">
        <button type="button" className="ty-lb-exit" onClick={exitGame}>
          <span className="ty-lb-exit-icon" aria-hidden="true">
            <img className="ty-lb-exit-door" src={exitDoorUrl} alt="" draggable={false} />
            <img className="ty-lb-exit-arrow" src={exitArrowUrl} alt="" draggable={false} />
          </span>
          <span>Thoát game</span>
        </button>
      </footer>
    </div>
  );
}
