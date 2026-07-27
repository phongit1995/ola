import { useRef, useState } from 'react';
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
  const passwordInputRef = useRef<HTMLInputElement>(null);
  const cardRef = useRef<HTMLDivElement>(null);
  const [passwordEnabled, setPasswordEnabled] = useState(false);
  const [passwordVisible, setPasswordVisible] = useState(false);
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

  const resetPasswordControls = (): void => {
    setPasswordEnabled(false);
    setPasswordVisible(false);
    setCreatePassword('');
  };

  const close = (): void => {
    resetPasswordControls();
    setCreateError(null);
    onClose();
  };

  const togglePassword = (): void => {
    const nextEnabled = !passwordEnabled;
    setPasswordEnabled(nextEnabled);
    setPasswordVisible(false);
    setCreatePassword('');
    setCreateError(null);

    if (nextEnabled) {
      requestAnimationFrame(() => passwordInputRef.current?.focus());
    }
  };

  const submit = (): void => {
    const amount = Number(bet.replace(/\D/g, '')) || 0;
    const password = passwordEnabled ? createPassword.trim() : '';
    if (passwordEnabled && !password) {
      setCreateError('Vui lòng nhập mật khẩu');
      passwordInputRef.current?.focus();
      return;
    }
    const error = roomCreationError(amount, password, availableKen, maxBet);
    if (error) {
      setCreateError(error);
      return;
    }
    setCreateError(null);
    resetPasswordControls();
    onSubmit(amount, password || undefined);
  };

  return (
    <div
      id="ranked-create-modal"
      className={open ? '' : 'hidden'}
      role="dialog"
      aria-modal="true"
      aria-labelledby="create-room-title"
      aria-hidden={!open}
      onClick={(event) => event.target === event.currentTarget && close()}
      onKeyDown={(event) => handleDialogKeyDown(event, cardRef, close)}
    >
      <div ref={cardRef} id="create-card" style={assetBg('createPanel')}>
        <div className="create-title" style={assetBg('createTitleFrame')}>
          <span id="create-room-title">Tạo bàn</span>
        </div>
        <button type="button" id="create-close" style={assetBg('createBtnClose')} aria-label="Đóng" onClick={close}>
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
              onKeyDown={(event) => event.key === 'Enter' && submit()}
            />
          </div>
          <button
            type="button"
            className={`create-password-toggle${passwordEnabled ? ' is-on' : ''}`}
            role="switch"
            aria-checked={passwordEnabled}
            aria-controls="create-password-field"
            aria-expanded={passwordEnabled}
            onClick={togglePassword}
          >
            <img className="create-password-lock" src={assetSrc('createPasswordLock')} alt="" />
            <span className="create-password-copy">
              <strong>Mật khẩu</strong>
              <small>(Tùy chọn)</small>
            </span>
            <span className="create-password-switch" aria-hidden="true">
              <span className="create-password-switch-text">{passwordEnabled ? 'Bật' : 'Tắt'}</span>
              <span className="create-password-switch-knob" />
            </span>
          </button>
          {passwordEnabled && (
            <div id="create-password-field" className="create-password-field">
              <label htmlFor="create-password">Nhập mật khẩu</label>
              <div className="create-password-input-row">
                <input
                  id="create-password"
                  ref={passwordInputRef}
                  type={passwordVisible ? 'text' : 'password'}
                  autoComplete="new-password"
                  spellCheck={false}
                  placeholder="••••••"
                  maxLength={ROOM_PASSWORD_MAX_LENGTH}
                  value={createPassword}
                  onChange={(event) => {
                    setCreatePassword(event.target.value);
                    setCreateError(null);
                  }}
                  onKeyDown={(event) => event.key === 'Enter' && submit()}
                />
                <button
                  type="button"
                  className={`create-password-visibility${passwordVisible ? ' is-visible' : ''}`}
                  aria-label={passwordVisible ? 'Ẩn mật khẩu' : 'Hiện mật khẩu'}
                  aria-pressed={passwordVisible}
                  onClick={() => setPasswordVisible((visible) => !visible)}
                >
                  <img src={assetSrc('createPasswordEye')} alt="" />
                </button>
              </div>
            </div>
          )}
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
