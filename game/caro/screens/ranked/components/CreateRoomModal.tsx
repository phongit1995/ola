import { useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from '../../../assets';
import { formatKen } from '../../../helpers/format';
import { ROOM_PASSWORD_MAX_LENGTH, roomCreationError } from '../../../helpers/room';
import { handleDialogKeyDown, useDialogFocus } from '../../../helpers/dialog';
import { useRanked } from '../useRanked';

interface CreateRoomModalProps {
  open: boolean;
  availableKen: number;
  maxBet: number | null;
  onClose: () => void;
  onSubmit: (bet: number, password?: string) => void;
}

export function CreateRoomModal({ open, availableKen, maxBet, onClose, onSubmit }: CreateRoomModalProps) {
  const betInputRef = useRef<HTMLInputElement>(null);
  const cardRef = useRef<HTMLDivElement>(null);
  const { bet, createPassword, createError, setBet, setCreatePassword, setCreateError } = useRanked(
    useShallow((state) => ({
      bet: state.bet,
      createPassword: state.createPassword,
      createError: state.createError,
      setBet: state.setBet,
      setCreatePassword: state.setCreatePassword,
      setCreateError: state.setCreateError,
    })),
  );

  useDialogFocus(open, cardRef, betInputRef);

  const submit = (): void => {
    const amount = Number(bet.replace(/\D/g, '')) || 0;
    const password = createPassword.trim();
    const error = roomCreationError(amount, password, availableKen, maxBet);
    if (error) {
      setCreateError(error);
      return;
    }
    setCreateError(null);
    onSubmit(amount, password || undefined);
  };

  return (
    <div
      id="ranked-create-modal"
      className={open ? '' : 'hidden'}
      role="dialog"
      aria-modal="true"
      aria-labelledby="create-room-title"
      onClick={(event) => event.target === event.currentTarget && onClose()}
      onKeyDown={(event) => handleDialogKeyDown(event, cardRef, onClose)}
    >
      <div ref={cardRef} id="create-card" style={assetBg('createPanel')}>
        <div className="create-title" style={assetBg('createTitleFrame')}>
          <span id="create-room-title">Tạo bàn</span>
        </div>
        <button type="button" id="create-close" style={assetBg('createBtnClose')} aria-label="Đóng" onClick={onClose}>
          <img src={assetSrc('createIcX')} alt="" />
        </button>
        <div className="create-body">
          <div className="create-label" style={assetBg('createLabelFrame')}>
            <span>Số Ken</span>
          </div>
          <div className="create-input" style={assetBg('createInputFrame')}>
            <input
              id="create-bet"
              ref={betInputRef}
              type="text"
              inputMode="numeric"
              value={bet}
              onChange={(event) => {
                const digits = event.target.value.replace(/\D/g, '');
                setBet(digits ? formatKen(Number(digits)) : '0');
                setCreateError(null);
              }}
            />
          </div>
          <div className="create-label" style={assetBg('createLabelFrame')}>
            <span>Mật khẩu</span>
          </div>
          <div className="create-input" style={assetBg('createInputFrame')}>
            <input
              id="create-password"
              type="text"
              autoComplete="off"
              placeholder="Để trống nếu không khóa"
              maxLength={ROOM_PASSWORD_MAX_LENGTH}
              value={createPassword}
              onChange={(event) => {
                setCreatePassword(event.target.value);
                setCreateError(null);
              }}
              onKeyDown={(event) => event.key === 'Enter' && submit()}
            />
          </div>
          {createError && (
            <p className="create-error" role="alert">
              {createError}
            </p>
          )}
        </div>
        <button type="button" id="create-ok" style={assetBg('createBtnOk')} onClick={submit}>
          <span>OK</span>
        </button>
      </div>
    </div>
  );
}
