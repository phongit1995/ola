import { useEffect, useId, useRef, useState, type FormEvent } from 'react';
import { useShallow } from 'zustand/react/shallow';
import kenUrl from '../assets/lobby/ill-ken.webp';
import { formatKen } from '../helpers/format';
import { ROOM_PASSWORD_MAX_LENGTH, ROOM_PLAYER_OPTIONS, createRoomError, formatBetInput, parseBetInput } from '../helpers/room';
import { useRoomList } from '../store/useRoomList';
import { useTycoon } from '../store/useTycoon';
import { ModalCloseButton, PasswordInput, RoomFieldError, SwitchRow } from './RoomFields';
import { useDialogFocus } from './useDialogFocus';

const BET_MAX_DIGITS = 12;

export function CreateRoomModal() {
  const { ken, maxBet } = useTycoon(useShallow((s) => ({ ken: s.profile?.ken ?? 0, maxBet: s.profile?.maxBet ?? null })));
  const { players, error, errorSeq, pending, setPlayers, setError, close, submit } = useRoomList(
    useShallow((s) => ({
      players: s.createPlayers,
      error: s.createError,
      errorSeq: s.errorSeq,
      pending: s.pendingId === 'create',
      setPlayers: s.setCreatePlayers,
      setError: s.setCreateError,
      close: s.closeCreate,
      submit: s.submitCreate,
    })),
  );
  const [betText, setBetText] = useState('0');
  const [locked, setLocked] = useState(false);
  const [password, setPassword] = useState('');
  const [allowSpectators, setAllowSpectators] = useState(false);
  const betRef = useRef<HTMLInputElement>(null);
  const passwordRef = useRef<HTMLInputElement>(null);
  const titleId = useId();
  const playersId = useId();
  const betId = useId();
  const betHintId = useId();
  const betErrorId = useId();
  const passwordId = useId();
  const passwordErrorId = useId();
  const modalRef = useDialogFocus<HTMLFormElement>({ onEscape: close });
  const bet = parseBetInput(betText);
  const betError = error?.field === 'bet' ? error.text : null;
  const passwordError = error?.field === 'password' ? error.text : null;

  useEffect(() => {
    if (!error) return;
    (error.field === 'bet' ? betRef : passwordRef).current?.focus();
  }, [error, errorSeq]);

  useEffect(() => {
    if (locked) passwordRef.current?.focus();
  }, [locked]);

  const changeBet = (text: string) => {
    setBetText(formatBetInput(text.replace(/\D/g, '').slice(0, BET_MAX_DIGITS)));
    if (betError) setError(null);
  };

  const changePassword = (text: string) => {
    setPassword(text);
    if (passwordError) setError(null);
  };

  const toggleLocked = (next: boolean) => {
    setLocked(next);
    if (next) return;
    setPassword('');
    if (passwordError) setError(null);
  };

  const onSubmit = (event: FormEvent) => {
    event.preventDefault();
    if (pending) return;
    const input = { maxPlayers: players, bet, password: locked ? password : '', allowSpectators };
    const invalid = createRoomError(input, locked, ken, maxBet);
    if (invalid) {
      setError(invalid);
      return;
    }
    void submit(input);
  };

  return (
    <div className="ty-backdrop" role="presentation" onClick={close}>
      <form
        ref={modalRef}
        className="ty-modal ty-room-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        tabIndex={-1}
        noValidate
        onSubmit={onSubmit}
        onClick={(event) => event.stopPropagation()}
      >
        <div className="ty-room-modal-head ty-room-modal-head-center">
          <h2 className="ty-modal-title" id={titleId}>
            Tạo bàn
          </h2>
          <ModalCloseButton variant="bold" onClick={close} disabled={pending} />
        </div>

        <fieldset className="ty-room-fields" disabled={pending}>
          <div className="ty-room-group">
            <span className="ty-room-label" id={playersId}>
              Số người
            </span>
            <div className="ty-room-players" role="radiogroup" aria-labelledby={playersId}>
              {ROOM_PLAYER_OPTIONS.map((option) => (
                <button
                  key={option}
                  type="button"
                  role="radio"
                  className={`ty-chip-btn ${players === option ? 'ty-chip-btn-active' : ''}`}
                  aria-checked={players === option}
                  aria-label={`${option} người`}
                  data-dialog-initial-focus={players === option ? '' : undefined}
                  onClick={() => setPlayers(option)}
                >
                  {option}
                </button>
              ))}
            </div>
          </div>

          <div className="ty-room-group">
            <label className="ty-room-label" htmlFor={betId}>
              Số KEN cược
            </label>
            <div className={betError ? 'ty-room-input ty-room-input-invalid' : 'ty-room-input'}>
              <img className="ty-room-input-ken" src={kenUrl} alt="" draggable={false} />
              <input
                ref={betRef}
                id={betId}
                className="ty-room-bet-input"
                type="text"
                inputMode="numeric"
                autoComplete="off"
                value={betText}
                placeholder="0"
                aria-invalid={betError ? true : undefined}
                aria-describedby={betError ? `${betErrorId} ${betHintId}` : betHintId}
                onChange={(event) => changeBet(event.target.value)}
                onFocus={(event) => event.target.select()}
              />
            </div>
            {betError ? <RoomFieldError id={betErrorId} text={betError} /> : null}
            <span className="ty-room-hint" id={betHintId}>
              {bet > 0 ? `Bạn có ${formatKen(ken)} KEN` : '0 = bàn giao lưu, không mất KEN'}
            </span>
          </div>

          <SwitchRow label="Khóa bàn" hint="Người vào chơi phải nhập mật khẩu" checked={locked} onChange={toggleLocked} />

          {locked ? (
            <div className="ty-room-group ty-room-expand">
              <label className="ty-room-label" htmlFor={passwordId}>
                Mật khẩu
              </label>
              <PasswordInput
                id={passwordId}
                value={password}
                onChange={changePassword}
                maxLength={ROOM_PASSWORD_MAX_LENGTH}
                errorId={passwordError ? passwordErrorId : undefined}
                inputRef={passwordRef}
              />
              {passwordError ? <RoomFieldError id={passwordErrorId} text={passwordError} /> : null}
            </div>
          ) : null}

          <SwitchRow
            label="Cho người khác xem"
            hint="Người ngoài bàn xem được ván, không thao tác được"
            checked={allowSpectators}
            onChange={setAllowSpectators}
          />
        </fieldset>

        <div className="ty-modal-actions ty-room-actions">
          <button type="button" className="ty-btn ty-btn-paper" onClick={close} disabled={pending}>
            Hủy
          </button>
          <button type="submit" className="ty-btn ty-btn-gold" aria-busy={pending || undefined} aria-disabled={pending || undefined}>
            Tạo bàn
          </button>
        </div>
      </form>
    </div>
  );
}
