import { useEffect, useId, useRef, useState, type FormEvent } from 'react';
import { useShallow } from 'zustand/react/shallow';
import kenUrl from '../assets/lobby/ken.png';
import { avatarIconUrl } from '../helpers/player';
import { ROOM_PASSWORD_MAX_LENGTH, roomBetLabel, roomSeatsLabel, type TycoonRoom } from '../helpers/room';
import { useRoomList } from '../store/useRoomList';
import { ModalCloseButton, PasswordInput, RoomFieldError } from './RoomFields';
import { RoomIcon } from './RoomIcon';
import { useDialogFocus } from './useDialogFocus';

export function JoinLockedModal({ room }: { room: TycoonRoom }) {
  const { error, errorSeq, pending, submit, clearError, close } = useRoomList(
    useShallow((s) => ({
      error: s.lockedError,
      errorSeq: s.errorSeq,
      pending: s.pendingId === room.id,
      submit: s.submitPassword,
      clearError: s.clearLockedError,
      close: s.closeLocked,
    })),
  );
  const [password, setPassword] = useState('');
  const inputRef = useRef<HTMLInputElement>(null);
  const titleId = useId();
  const passwordId = useId();
  const errorId = useId();
  const modalRef = useDialogFocus<HTMLFormElement>({ onEscape: close });

  useEffect(() => {
    if (!error) return;
    inputRef.current?.focus();
    inputRef.current?.select();
  }, [error, errorSeq]);

  const changePassword = (value: string) => {
    setPassword(value);
    clearError();
  };

  const onSubmit = (event: FormEvent) => {
    event.preventDefault();
    if (pending || !password) return;
    void submit(password);
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
        <div className="ty-room-modal-head ty-room-modal-head-divided">
          <span className="ty-modal-emblem">
            <RoomIcon name="lock-solid" width={20} height={25} />
          </span>
          <h2 className="ty-modal-title" id={titleId}>
            Vào bàn khóa
          </h2>
          <ModalCloseButton variant="thin" onClick={close} disabled={pending} />
        </div>

        <div className="ty-join-room">
          <img className="ty-join-avatar" src={avatarIconUrl(room.ownerVipType)} alt="" draggable={false} />
          <div className="ty-join-copy">
            <p className="ty-join-owner">Bàn của @{room.owner}</p>
            <div className="ty-join-chips">
              <span className="ty-join-bet">
                {room.bet > 0 ? <img src={kenUrl} alt="" draggable={false} /> : null}
                {roomBetLabel(room.bet)}
              </span>
              <span className="ty-room-seats">
                {roomSeatsLabel(room)}
                <span className="ty-visually-hidden"> chỗ</span>
              </span>
            </div>
          </div>
        </div>

        <fieldset className="ty-room-fields" disabled={pending}>
          <div className="ty-room-group">
            <label className="ty-room-label" htmlFor={passwordId}>
              Mật khẩu
            </label>
            <PasswordInput
              id={passwordId}
              value={password}
              onChange={changePassword}
              maxLength={ROOM_PASSWORD_MAX_LENGTH}
              errorId={error ? errorId : undefined}
              shakeKey={errorSeq}
              initialFocus
              inputRef={inputRef}
            />
            {error ? <RoomFieldError id={errorId} text={error} /> : null}
          </div>
        </fieldset>

        <div className="ty-modal-actions ty-room-actions">
          <button type="button" className="ty-btn ty-btn-paper" onClick={close} disabled={pending}>
            Hủy
          </button>
          <button
            type="submit"
            className="ty-btn ty-btn-gold"
            disabled={!password && !pending}
            aria-busy={pending || undefined}
            aria-disabled={pending || undefined}
          >
            Vào bàn
          </button>
        </div>
      </form>
    </div>
  );
}
