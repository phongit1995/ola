import type { Ref } from 'react';
import { useShallow } from 'zustand/react/shallow';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import logoUrl from '../assets/lobby/logo.webp';
import heroUrl from '../assets/lobby/hero-properties.webp';
import diceUrl from '../assets/lobby/ill-dice.webp';
import historyUrl from '../assets/lobby/ill-history.webp';
import leaderboardUrl from '../assets/lobby/ill-leaderboard.webp';
import rulesUrl from '../assets/lobby/ill-rules.webp';
import exitDoorUrl from '../assets/lobby/ill-exit-door.webp';
import exitArrowUrl from '../assets/lobby/ill-exit-arrow.webp';
import kenUrl from '../assets/lobby/ill-ken.webp';
import ctaRaysUrl from '../assets/lobby/decor-cta-rays.svg';
import heroRaysUrl from '../assets/lobby/decor-hero-rays.svg';
import mascotUrl from '../assets/chars/ty-idle-full.webp';
import { TyIcon } from '../components/TyIcon';
import { formatKen } from '../helpers/format';
import { avatarIconUrl } from '../helpers/player';
import { GAME_VERSION, type LobbyProfile } from '../helpers/profile';
import { useTycoon } from '../store/useTycoon';
import { useLobbyTopbarWrap } from './useLobbyTopbarWrap';

const ONLINE_SOON = 'Tính năng online đang được làm, tạm thời chơi với máy';

function ProfilePill({ profile, ref }: { profile: LobbyProfile | null; ref: Ref<HTMLDivElement> }) {
  if (!profile) {
    return (
      <div ref={ref} className="ty-lb-pill ty-lb-profile" aria-busy="true">
        <span className="ty-lb-avatar ty-lb-skeleton" />
        <span className="ty-lb-name ty-lb-skeleton-text" />
      </div>
    );
  }
  const name = `@${profile.username}`;
  return (
    <div ref={ref} className="ty-lb-pill ty-lb-profile" aria-label={name}>
      <img className="ty-lb-avatar" src={avatarIconUrl(profile.vipType)} alt="" draggable={false} />
      <span className="ty-lb-name" aria-hidden="true">
        {name}
      </span>
    </div>
  );
}

function KenPill({ ken, bodyRef }: { ken: number | null; bodyRef: Ref<HTMLSpanElement> }) {
  const amount = ken == null ? '—' : formatKen(ken);
  return (
    <div className="ty-lb-pill ty-lb-ken" aria-label={`Số dư ${amount} KEN`}>
      <span ref={bodyRef} className="ty-lb-ken-body" aria-hidden="true">
        <img src={kenUrl} alt="" draggable={false} />
        <b>{amount}</b>
        <span>KEN</span>
      </span>
    </div>
  );
}

export function LobbyScreen() {
  const { profile, soundOn, toggleSound, setSetupOpen, setRulesOpen, exitGame, showToast } = useTycoon(
    useShallow((s) => ({
      profile: s.profile,
      soundOn: s.soundOn,
      toggleSound: s.toggleSound,
      setSetupOpen: s.setSetupOpen,
      setRulesOpen: s.setRulesOpen,
      exitGame: s.exitGame,
      showToast: s.showToast,
    })),
  );
  const { topRef, profileRef, kenBodyRef, soundRef, wrap } = useLobbyTopbarWrap();

  return (
    <div className="ty-lobby" style={{ '--ty-lb-bg': `url(${bgUrl})` } as React.CSSProperties}>
      <header ref={topRef} className={wrap ? 'ty-lb-top ty-lb-top-wrap' : 'ty-lb-top'}>
        <ProfilePill profile={profile} ref={profileRef} />
        <KenPill ken={profile?.ken ?? null} bodyRef={kenBodyRef} />
        <button
          ref={soundRef}
          type="button"
          className="ty-lb-sound"
          onClick={toggleSound}
          aria-label={soundOn ? 'Tắt âm' : 'Bật âm'}
          aria-pressed={soundOn}
        >
          <TyIcon name={soundOn ? 'volume-on' : 'volume-off'} size={24} />
        </button>
      </header>

      <h1 className="ty-lb-logo">
        <img src={logoUrl} alt="Cờ Tỷ Phú" draggable={false} />
      </h1>

      <div className="ty-lb-hero" aria-hidden="true">
        <div className="ty-lb-props">
          <img src={heroRaysUrl} alt="" draggable={false} />
          <img src={heroUrl} alt="" draggable={false} />
        </div>
        <img className="ty-lb-mascot" src={mascotUrl} alt="" draggable={false} />
      </div>

      <nav className="ty-lb-menu" aria-label="Menu sảnh">
        <div className="ty-lb-cta">
          <img className="ty-lb-cta-rays" src={ctaRaysUrl} alt="" draggable={false} />
          <button type="button" className="ty-lb-btn ty-lb-btn-gold" onClick={() => setSetupOpen(true)}>
            <img src={diceUrl} alt="" draggable={false} />
            <span>Vào bàn</span>
          </button>
          <img className="ty-lb-cta-rays" src={ctaRaysUrl} alt="" draggable={false} />
        </div>
        <button type="button" className="ty-lb-btn ty-lb-btn-paper" onClick={() => showToast(ONLINE_SOON)}>
          <img src={historyUrl} alt="" draggable={false} />
          <span>Lịch sử</span>
        </button>
        <button type="button" className="ty-lb-btn ty-lb-btn-paper" onClick={() => showToast(ONLINE_SOON)}>
          <img src={leaderboardUrl} alt="" draggable={false} />
          <span>Bảng xếp hạng</span>
        </button>
        <button type="button" className="ty-lb-btn ty-lb-btn-text" onClick={() => setRulesOpen(true)}>
          <img src={rulesUrl} alt="" draggable={false} />
          <span>Luật chơi</span>
        </button>
      </nav>

      <footer className="ty-lb-footer">
        <button type="button" className="ty-lb-exit" onClick={exitGame}>
          <span className="ty-lb-exit-icon" aria-hidden="true">
            <img className="ty-lb-exit-door" src={exitDoorUrl} alt="" draggable={false} />
            <img className="ty-lb-exit-arrow" src={exitArrowUrl} alt="" draggable={false} />
          </span>
          <span>Thoát game</span>
        </button>
        <span className="ty-lb-version">{GAME_VERSION}</span>
      </footer>
    </div>
  );
}
