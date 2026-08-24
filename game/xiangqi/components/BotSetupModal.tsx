import { useId, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOT_DIFFICULTY_LABEL, type BotDifficulty } from '../logic/bot';
import { SIDE_BLACK, SIDE_RED } from '../logic/board';
import { useXiangqi } from '../store/useXiangqi';
import { ModalHeading } from './ModalHeading';
import { useDialogFocus } from './useDialogFocus';

const DIFFICULTIES: BotDifficulty[] = ['easy', 'medium', 'hard'];

const DIFFICULTY_HELP: Record<BotDifficulty, string> = {
  easy: 'Đi nhanh và có thể bỏ lỡ chiến thuật.',
  medium: 'Biết ưu tiên ăn quân và phòng thủ.',
  hard: 'Tính trước nhiều nước, phù hợp người đã quen cờ.',
};

export function BotSetupModal() {
  const { currentDifficulty, currentSide, closeBotSetup, startBotGame } = useXiangqi(
    useShallow((state) => ({
      currentDifficulty: state.botDifficulty,
      currentSide: state.botPlayerSide,
      closeBotSetup: state.closeBotSetup,
      startBotGame: state.startBotGame,
    })),
  );
  const [difficulty, setDifficulty] = useState<BotDifficulty>(currentDifficulty);
  const [playerSide, setPlayerSide] = useState(currentSide);
  const titleId = useId();
  const modalRef = useDialogFocus<HTMLDivElement>({ onEscape: closeBotSetup });

  return (
    <div className="xq-backdrop" onClick={closeBotSetup}>
      <div
        ref={modalRef}
        className="xq-modal xq-bot-setup"
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        tabIndex={-1}
        onClick={(event) => event.stopPropagation()}
      >
        <ModalHeading eyebrow="Luyện tập không cược" title="Chơi với máy" icon="reaction" titleId={titleId} />

        <div className="xq-bot-duel" aria-hidden="true">
          <span className="xq-logo-piece xq-piece-red">帥</span>
          <strong>VS</strong>
          <span className="xq-logo-piece xq-piece-black">將</span>
        </div>

        <fieldset className="xq-bot-fieldset">
          <legend>Độ khó</legend>
          <div className="xq-bot-options xq-bot-difficulties">
            {DIFFICULTIES.map((item) => (
              <button
                key={item}
                type="button"
                className={`xq-chip-btn ${difficulty === item ? 'xq-chip-btn-active' : ''}`}
                aria-pressed={difficulty === item}
                onClick={() => setDifficulty(item)}
                data-dialog-initial-focus={difficulty === item ? '' : undefined}
              >
                {BOT_DIFFICULTY_LABEL[item]}
              </button>
            ))}
          </div>
          <p className="xq-bot-help">{DIFFICULTY_HELP[difficulty]}</p>
        </fieldset>

        <fieldset className="xq-bot-fieldset">
          <legend>Chọn bên</legend>
          <div className="xq-bot-options">
            <button
              type="button"
              className={`xq-bot-side ${playerSide === SIDE_RED ? 'xq-bot-side-active' : ''}`}
              aria-pressed={playerSide === SIDE_RED}
              onClick={() => setPlayerSide(SIDE_RED)}
            >
              <span className="xq-bot-side-glyph xq-piece-red">帥</span>
              <span><strong>Đỏ</strong><small>Đi trước</small></span>
            </button>
            <button
              type="button"
              className={`xq-bot-side ${playerSide === SIDE_BLACK ? 'xq-bot-side-active' : ''}`}
              aria-pressed={playerSide === SIDE_BLACK}
              onClick={() => setPlayerSide(SIDE_BLACK)}
            >
              <span className="xq-bot-side-glyph xq-piece-black">將</span>
              <span><strong>Đen</strong><small>Máy đi trước</small></span>
            </button>
          </div>
        </fieldset>

        <p className="xq-bot-note">Ván luyện tập không tính KEN, lịch sử hoặc bảng xếp hạng.</p>
        <div className="xq-modal-actions">
          <button type="button" className="xq-btn xq-btn-paper" onClick={closeBotSetup}>Hủy</button>
          <button type="button" className="xq-btn xq-btn-jade" onClick={() => startBotGame(difficulty, playerSide)}>
            Bắt đầu
          </button>
        </div>
      </div>
    </div>
  );
}
