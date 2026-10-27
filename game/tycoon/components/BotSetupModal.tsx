import { useEffect, useId, useRef, useState, type KeyboardEvent } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { vipIconUrl } from '@ola/shared/lib/vip';
import botUrl from '../assets/lobby/ill-bot.webp';
import closeUrl from '../assets/bot-setup/close-navy.svg';
import minusUrl from '../assets/bot-setup/minus-circle.svg';
import minusOffUrl from '../assets/bot-setup/minus-circle-disabled.svg';
import plusUrl from '../assets/bot-setup/plus-circle.svg';
import plusOffUrl from '../assets/bot-setup/plus-circle-disabled.svg';
import usersUrl from '../assets/bot-setup/users-blue.svg';
import { BOT_LEVELS, MAX_BOTS, addBot, botName, createBot, removeBot, setBotLevel, type BotSetupItem } from '../helpers/bot';
import { MAX_ROUNDS, TIME_LIMIT_MS, TURN_SECONDS } from '../logic/constants';
import type { BotLevel } from '../logic/types';
import { useTycoon } from '../store/useTycoon';
import { useDialogFocus } from './useDialogFocus';

const HINT = `Tối đa ${MAX_ROUNDS} vòng hoặc ${TIME_LIMIT_MS / 60000} phút, mỗi hành động ${TURN_SECONDS} giây. Máy đi tự động.`;

interface LevelPickerProps {
  name: string;
  level: BotLevel;
  initialFocus: boolean;
  onChange: (level: BotLevel) => void;
}

function LevelPicker({ name, level, initialFocus, onChange }: LevelPickerProps) {
  const onKeyDown = (event: KeyboardEvent<HTMLDivElement>) => {
    const step = event.key === 'ArrowRight' || event.key === 'ArrowDown' ? 1 : event.key === 'ArrowLeft' || event.key === 'ArrowUp' ? -1 : 0;
    if (!step) return;
    event.preventDefault();
    const index = BOT_LEVELS.findIndex((item) => item.value === level);
    const next = BOT_LEVELS[(index + step + BOT_LEVELS.length) % BOT_LEVELS.length];
    onChange(next.value);
    event.currentTarget.querySelector<HTMLButtonElement>(`[data-level="${next.value}"]`)?.focus();
  };

  return (
    <div className="ty-bot-levels" role="radiogroup" aria-label={`Mức độ của ${name}`} onKeyDown={onKeyDown}>
      {BOT_LEVELS.map((item) => {
        const checked = item.value === level;
        return (
          <button
            key={item.value}
            type="button"
            role="radio"
            aria-checked={checked}
            tabIndex={checked ? 0 : -1}
            data-level={item.value}
            data-dialog-initial-focus={checked && initialFocus ? '' : undefined}
            className={checked ? 'ty-bot-level ty-bot-level-on' : 'ty-bot-level'}
            onClick={() => onChange(item.value)}
          >
            {item.label}
          </button>
        );
      })}
    </div>
  );
}

export function BotSetupModal() {
  const { startGame, setSetupOpen } = useTycoon(useShallow((s) => ({ startGame: s.startGame, setSetupOpen: s.setSetupOpen })));
  const nextId = useRef(1);
  const [bots, setBots] = useState<BotSetupItem[]>(() => [createBot([], 'bot-1')]);
  const [focusId, setFocusId] = useState<string | null>(null);
  const titleId = useId();
  const listId = useId();
  const lastHintId = useId();
  const close = () => setSetupOpen(false);
  const modalRef = useDialogFocus<HTMLDivElement>({ onEscape: close });
  const full = bots.length >= MAX_BOTS;
  const single = bots.length <= 1;

  useEffect(() => {
    if (!focusId) return;
    modalRef.current?.querySelector<HTMLButtonElement>(`[data-bot-id="${focusId}"] [aria-checked="true"]`)?.focus();
    setFocusId(null);
  }, [focusId, modalRef]);

  const add = () => {
    if (full) return;
    nextId.current += 1;
    const id = `bot-${nextId.current}`;
    setBots((list) => addBot(list, id));
    setFocusId(id);
  };

  const remove = (id: string) => {
    if (single) return;
    const index = bots.findIndex((bot) => bot.id === id);
    const left = removeBot(bots, id);
    setBots(left);
    setFocusId(left[Math.min(index, left.length - 1)]?.id ?? null);
  };

  return (
    <div className="ty-backdrop" onClick={close}>
      <div
        ref={modalRef}
        className="ty-modal ty-bot-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        tabIndex={-1}
        onClick={(event) => event.stopPropagation()}
      >
        <div className="ty-bot-head">
          <img src={botUrl} alt="" aria-hidden="true" draggable={false} />
          <h2 className="ty-modal-title" id={titleId}>
            Chơi với máy
          </h2>
          <button type="button" className="ty-bot-close" aria-label="Đóng" onClick={close}>
            <img src={closeUrl} alt="" aria-hidden="true" draggable={false} />
          </button>
        </div>

        <div className="ty-bot-body">
          <div className="ty-bot-list-head">
            <span id={listId}>Danh sách bot</span>
            <span className="ty-bot-count" aria-live="polite">
              {bots.length}/{MAX_BOTS} bot
            </span>
          </div>

          <ul className="ty-bot-list" aria-labelledby={listId}>
            {bots.map((bot, index) => {
              const name = botName(index);
              return (
                <li key={bot.id} className="ty-bot-row" data-bot-id={bot.id}>
                  <img className="ty-bot-avatar" src={vipIconUrl(bot.vip)} alt="" aria-hidden="true" draggable={false} />
                  <span className="ty-bot-name">{name}</span>
                  <LevelPicker
                    name={name}
                    level={bot.level}
                    initialFocus={index === 0}
                    onChange={(level) => setBots((list) => setBotLevel(list, bot.id, level))}
                  />
                  <button
                    type="button"
                    className="ty-bot-remove"
                    aria-label={single ? 'Không thể xóa bot cuối cùng' : `Xóa ${name}`}
                    aria-describedby={single ? lastHintId : undefined}
                    disabled={single}
                    onClick={() => remove(bot.id)}
                  >
                    <img src={single ? minusOffUrl : minusUrl} alt="" aria-hidden="true" draggable={false} />
                  </button>
                </li>
              );
            })}
          </ul>
          <span id={lastHintId} className="ty-visually-hidden">
            Cần ít nhất 1 bot để bắt đầu
          </span>

          <button type="button" className="ty-bot-add" disabled={full} onClick={add}>
            <img src={full ? plusOffUrl : plusUrl} alt="" aria-hidden="true" draggable={false} />
            <span>Thêm bot</span>
          </button>
          {full ? <p className="ty-bot-full">Đã đủ {MAX_BOTS} bot</p> : null}

          <div className="ty-bot-summary">
            <p className="ty-bot-summary-title">
              <img src={usersUrl} alt="" aria-hidden="true" draggable={false} />
              <span>
                Ván {bots.length + 1} người: bạn và {bots.length} bot
              </span>
            </p>
            <p className="ty-bot-summary-hint">{HINT}</p>
          </div>
        </div>

        <div className="ty-bot-actions">
          <button type="button" className="ty-bot-btn ty-bot-btn-paper" onClick={close}>
            Hủy
          </button>
          <button type="button" className="ty-bot-btn ty-bot-btn-gold" onClick={() => startGame(bots)}>
            Bắt đầu
          </button>
        </div>
      </div>
    </div>
  );
}
