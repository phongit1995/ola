import { useShallow } from 'zustand/react/shallow';
import { TyIcon } from '../components/TyIcon';
import { useTycoon } from '../store/useTycoon';

export function LobbyScreen() {
  const { soundOn, toggleSound, setSetupOpen, setRulesOpen, exitGame } = useTycoon(
    useShallow((s) => ({
      soundOn: s.soundOn,
      toggleSound: s.toggleSound,
      setSetupOpen: s.setSetupOpen,
      setRulesOpen: s.setRulesOpen,
      exitGame: s.exitGame,
    })),
  );

  return (
    <div className="ty-screen ty-lobby">
      <div className="ty-topbar">
        <span className="ty-chip ty-chip-paper">Bản thử · chơi với máy</span>
        <div className="ty-topbar-right">
          <button type="button" className="ty-icon-btn ty-icon-btn-dark" onClick={toggleSound} aria-label={soundOn ? 'Tắt âm' : 'Bật âm'} aria-pressed={soundOn}>
            <TyIcon name={soundOn ? 'volume-on' : 'volume-off'} size={22} />
          </button>
        </div>
      </div>

      <div className="ty-logo">
        <div className="ty-logo-art" aria-hidden="true">
          <span className="ty-logo-tile ty-logo-tile-red" />
          <span className="ty-logo-tile ty-logo-tile-green" />
          <span className="ty-logo-tile ty-logo-tile-blue" />
          <span className="ty-logo-die">
            <i />
            <i />
            <i />
            <i />
            <i />
          </span>
        </div>
        <h1 className="ty-logo-title">CỜ TỶ PHÚ</h1>
        <p className="ty-logo-sub">2–4 người · 20 vòng · ai giàu nhất thắng</p>
      </div>

      <div className="ty-cta-stack">
        <button type="button" className="ty-btn ty-btn-gold ty-btn-big ty-lobby-action" onClick={() => setSetupOpen(true)}>
          <span className="ty-lobby-action-icon">
            <TyIcon name="dice" size={23} />
          </span>
          <span className="ty-lobby-action-copy">
            <strong>Chơi với máy</strong>
            <small>Chọn 2–4 người, máy đi tự động</small>
          </span>
          <TyIcon name="chevron-right" size={19} className="ty-lobby-action-arrow" />
        </button>
        <button type="button" className="ty-btn ty-btn-paper ty-lobby-shortcut" onClick={() => setRulesOpen(true)}>
          <TyIcon name="deed" size={20} />
          <span>Luật chơi</span>
        </button>
      </div>

      <button type="button" className="ty-exit-link" onClick={exitGame}>
        Thoát game
      </button>
    </div>
  );
}
