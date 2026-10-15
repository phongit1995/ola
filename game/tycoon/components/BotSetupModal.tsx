import { useId, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { ModalHeading } from './ModalHeading';
import { useDialogFocus } from './useDialogFocus';
import { useTycoon } from '../store/useTycoon';

const OPTIONS = [2, 3, 4];

export function BotSetupModal() {
  const { playerCount, startGame, setSetupOpen } = useTycoon(
    useShallow((s) => ({ playerCount: s.playerCount, startGame: s.startGame, setSetupOpen: s.setSetupOpen })),
  );
  const [count, setCount] = useState(playerCount);
  const titleId = useId();
  const close = () => setSetupOpen(false);
  const modalRef = useDialogFocus<HTMLDivElement>({ onEscape: close });
  return (
    <div className="ty-backdrop" onClick={close}>
      <div ref={modalRef} className="ty-modal ty-modal-form" role="dialog" aria-modal="true" aria-labelledby={titleId} tabIndex={-1} onClick={(event) => event.stopPropagation()}>
        <ModalHeading eyebrow="Chơi với máy" title="Mấy người chơi?" icon="dice" titleId={titleId} />
        <div className="ty-field">
          <span>Bạn và {count - 1} máy</span>
          <div className="ty-chip-row" role="radiogroup" aria-label="Số người chơi">
            {OPTIONS.map((option) => (
              <button
                key={option}
                type="button"
                role="radio"
                className={`ty-chip-btn ${count === option ? 'ty-chip-btn-active' : ''}`}
                aria-checked={count === option}
                onClick={() => setCount(option)}
                data-dialog-initial-focus={option === playerCount ? '' : undefined}
              >
                {option} người
              </button>
            ))}
          </div>
        </div>
        <p className="ty-modal-hint">Ván kéo dài tối đa 20 vòng, mỗi hành động 30 giây. Máy đi tự động.</p>
        <div className="ty-modal-actions">
          <button type="button" className="ty-btn ty-btn-paper" onClick={close}>
            Hủy
          </button>
          <button type="button" className="ty-btn ty-btn-gold" onClick={() => startGame(count)}>
            Bắt đầu
          </button>
        </div>
      </div>
    </div>
  );
}
