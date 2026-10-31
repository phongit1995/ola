import { useEffect, useRef, useState, type KeyboardEvent } from 'react';
import botIcon from '../../assets/icons/ic-bot.svg';
import plusIcon from '../../assets/icons/ic-plus.svg';
import userMinusIcon from '../../assets/icons/ic-user-minus.svg';
import { handleModalKeyDown } from '../../components/modalKeyboard';
import { PlayerAvatar } from '../../components/PlayerAvatar';
import type { BotLevel } from '../../logic/bot';
import { TURN_SECONDS } from '../../logic/constants.gen';
import {
  BOT_LEVELS,
  MAX_BOTS,
  addBot,
  botLevelHint,
  botName,
  createBot,
  removeBot,
  setBotLevel,
  type BotSetupItem,
} from '../../helpers/practice';
import { useThirteen } from '../../store/useThirteen';

function initialBots(): BotSetupItem[] {
  let bots: BotSetupItem[] = [createBot([], 'bot-1')];
  for (let i = 2; i <= MAX_BOTS; i += 1) bots = addBot(bots, `bot-${i}`);
  return bots;
}

function LevelPicker({ name, level, onChange }: { name: string; level: BotLevel; onChange: (level: BotLevel) => void }) {
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
    <div className="tl-practice-levels" role="radiogroup" aria-label={`Mức độ của ${name}`} onKeyDown={onKeyDown}>
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
            className={'tl-practice-level' + (checked ? ' active' : '')}
            onClick={() => onChange(item.value)}
          >
            {item.label}
          </button>
        );
      })}
    </div>
  );
}

export function PracticeSetupModal({ onClose }: { onClose: () => void }) {
  const startPractice = useThirteen((s) => s.startPractice);
  const nextId = useRef(MAX_BOTS);
  const listRef = useRef<HTMLUListElement>(null);
  const [bots, setBots] = useState<BotSetupItem[]>(initialBots);
  const [focusId, setFocusId] = useState<string | null>(null);
  const full = bots.length >= MAX_BOTS;
  const single = bots.length <= 1;

  useEffect(() => {
    if (!focusId) return;
    listRef.current?.querySelector<HTMLButtonElement>(`[data-bot-id="${focusId}"] [aria-checked="true"]`)?.focus();
    setFocusId(null);
  }, [focusId]);

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
    <div className="tl-modal-backdrop tl-lobby-modal-backdrop" onClick={(e) => e.target === e.currentTarget && onClose()}>
      <form
        className="tl-modal tl-lobby-modal tl-practice-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="tl-practice-title"
        onSubmit={(event) => {
          event.preventDefault();
          startPractice(bots);
          onClose();
        }}
        onKeyDown={(event) => handleModalKeyDown(event, onClose)}
      >
        <div className="tl-practice-head">
          <span className="tl-practice-emblem" aria-hidden="true">
            <img src={botIcon} alt="" />
          </span>
          <div id="tl-practice-title" className="tl-modal-title">
            Chơi với máy
          </div>
          <p className="tl-practice-sub">Chọn đối thủ và độ khó cho ván tập</p>
        </div>
        <div className="tl-practice-list-head">
          <span id="tl-practice-list-label" className="tl-field-label">
            Đối thủ{' '}
            <b className="tl-practice-count" aria-live="polite">
              {bots.length}/{MAX_BOTS}
            </b>
          </span>
          <button type="button" className="tl-practice-add" disabled={full} onClick={add}>
            <img src={plusIcon} alt="" />
            <span>Thêm máy</span>
          </button>
        </div>
        <ul ref={listRef} className="tl-practice-list" aria-labelledby="tl-practice-list-label">
          {bots.map((bot, index) => {
            const name = botName(index);
            return (
              <li key={bot.id} className="tl-practice-row" data-bot-id={bot.id} data-level={bot.level}>
                <PlayerAvatar name={name} vipType={bot.vipType} size="sm" />
                <span className="tl-practice-who">
                  <span className="tl-practice-label">
                    <span className="tl-practice-name">{name}</span>
                    <span className="tl-practice-hint">{botLevelHint(bot.level)}</span>
                  </span>
                  <LevelPicker name={name} level={bot.level} onChange={(level) => setBots((list) => setBotLevel(list, bot.id, level))} />
                </span>
                <button
                  type="button"
                  className="tl-practice-remove"
                  aria-label={single ? 'Cần ít nhất 1 máy' : `Xóa ${name}`}
                  disabled={single}
                  onClick={() => remove(bot.id)}
                >
                  <img src={userMinusIcon} alt="" />
                </button>
              </li>
            );
          })}
        </ul>
        <ul className="tl-practice-rules" aria-label="Luật ván tập">
          <li>
            Bàn {bots.length + 1} người: bạn + {bots.length} máy
          </li>
          <li>{TURN_SECONDS} giây/lượt</li>
          <li>Không cược</li>
          <li>Không cộng EXP</li>
        </ul>
        <div className="tl-modal-actions">
          <button type="button" className="tl-btn tl-btn-ghost" onClick={onClose}>
            Hủy
          </button>
          <button type="submit" className="tl-btn tl-btn-gold" autoFocus>
            Bắt đầu
          </button>
        </div>
      </form>
    </div>
  );
}
