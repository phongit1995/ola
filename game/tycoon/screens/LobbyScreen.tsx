import { useShallow } from 'zustand/react/shallow';
import { vipIconUrl } from '@ola/shared/lib/vip';
import { Skyline } from '../components/Skyline';
import { TyIcon, type TyIconName } from '../components/TyIcon';
import { MAX_ROUNDS } from '../logic/constants';
import { avatarIconUrl, seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';

const RING: Array<string | null> = [
  null, 'red', 'chance', 'red', null,
  'orange', '', '', '', 'yellow',
  'station', '', '', '', 'chest',
  'orange', '', '', '', 'green',
  null, 'sky', 'tax', 'blue', null,
];

const STEPS: Array<{ icon: TyIconName; title: string; body: string }> = [
  { icon: 'dice', title: 'Gieo xúc xắc', body: 'Đi theo tổng 2 viên' },
  { icon: 'deed', title: 'Mua đất', body: 'Gom trọn nhóm màu' },
  { icon: 'house', title: 'Xây nhà', body: 'Thu tiền thuê đậm' },
];

function IsoBoard() {
  return (
    <div className="ty-iso" aria-hidden="true">
      <div className="ty-iso-board">
        {RING.map((cell, i) => {
          const row = Math.floor(i / 5);
          const col = i % 5;
          const inner = row > 0 && row < 4 && col > 0 && col < 4;
          if (inner) return null;
          const side = row === 0 ? 'top' : row === 4 ? 'bottom' : col === 0 ? 'left' : 'right';
          return (
            <span key={i} className={`ty-iso-cell ty-iso-${side} ${cell === null ? 'ty-iso-corner' : ''}`} style={{ gridRow: row + 1, gridColumn: col + 1 }}>
              {cell && !['chance', 'chest', 'station', 'tax'].includes(cell) ? <i className={`ty-band-${cell}`} /> : null}
              {cell === 'chance' ? <b>?</b> : null}
            </span>
          );
        })}
        <span className="ty-iso-center">
          <span className="ty-iso-card ty-iso-card-a" />
          <span className="ty-iso-card ty-iso-card-b" />
        </span>
      </div>
    </div>
  );
}

function LobbyPin({ seat, className }: { seat: number; className: string }) {
  return (
    <span className={`ty-token ty-lobby-pin ${className}`} style={{ '--seat': seatColor(seat) } as React.CSSProperties} aria-hidden="true">
      <span className="ty-token-shadow" />
      <span className="ty-token-pin">
        <span className="ty-token-face">
          <img src={seat === 0 ? avatarIconUrl(null) : vipIconUrl(seat)} alt="" draggable={false} />
        </span>
      </span>
    </span>
  );
}

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
      <Skyline night className="ty-lobby-skyline" />
      <div className="ty-topbar">
        <span className="ty-chip ty-chip-paper">Bản thử · chơi với máy</span>
        <div className="ty-topbar-right">
          <button type="button" className="ty-icon-btn ty-icon-btn-dark" onClick={toggleSound} aria-label={soundOn ? 'Tắt âm' : 'Bật âm'} aria-pressed={soundOn}>
            <TyIcon name={soundOn ? 'volume-on' : 'volume-off'} size={22} />
          </button>
        </div>
      </div>

      <div className="ty-lobby-hero">
        <IsoBoard />
        <LobbyPin seat={0} className="ty-lobby-pin-a" />
        <LobbyPin seat={2} className="ty-lobby-pin-b" />
        <span className="ty-logo-die" aria-hidden="true">
          <i />
          <i />
          <i />
          <i />
          <i />
        </span>
      </div>

      <div className="ty-logo">
        <h1 className="ty-logo-title">
          CỜ <span>TỶ</span> PHÚ
        </h1>
        <p className="ty-logo-sub">Mua đất, xây nhà, thu tiền thuê — trở thành tỷ phú phố thị!</p>
      </div>

      <ul className="ty-lobby-facts" aria-label="Thông tin ván chơi">
        <li>
          <TyIcon name="dice" size={16} />
          2–4 người
        </li>
        <li>
          <TyIcon name="history" size={16} />
          {MAX_ROUNDS} vòng
        </li>
        <li>
          <TyIcon name="house" size={16} />
          22 ô đất
        </li>
      </ul>

      <ol className="ty-lobby-steps" aria-label="Chơi thế nào">
        {STEPS.map((step, i) => (
          <li key={step.title}>
            <span className="ty-step-icon">
              <TyIcon name={step.icon} size={20} />
              <i>{i + 1}</i>
            </span>
            <b>{step.title}</b>
            <small>{step.body}</small>
          </li>
        ))}
      </ol>

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
        <button type="button" className="ty-exit-link" onClick={exitGame}>
          Thoát game
        </button>
      </div>
    </div>
  );
}
