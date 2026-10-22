import { useEffect, useId, useRef, useState, type Ref } from 'react';
import { RoomIcon } from './RoomIcon';
import { TyIcon } from './TyIcon';

const SHAKE_FRAMES: Keyframe[] = [
  { transform: 'translateX(0)' },
  { transform: 'translateX(-6px)' },
  { transform: 'translateX(6px)' },
  { transform: 'translateX(-4px)' },
  { transform: 'translateX(4px)' },
  { transform: 'translateX(0)' },
];

export function RoomFieldError({ id, text }: { id: string; text: string }) {
  return (
    <p className="ty-room-error" id={id} role="alert">
      <RoomIcon name="warning-coral" />
      <span>{text}</span>
    </p>
  );
}

export function ModalCloseButton({ variant, onClick, disabled }: { variant: 'bold' | 'thin'; onClick: () => void; disabled?: boolean }) {
  return (
    <button type="button" className="ty-room-close" aria-label="Đóng" onClick={onClick} disabled={disabled}>
      <RoomIcon name={variant === 'bold' ? 'close-bold' : 'close-thin'} />
    </button>
  );
}

interface SwitchRowProps {
  label: string;
  hint: string;
  checked: boolean;
  onChange: (checked: boolean) => void;
}

export function SwitchRow({ label, hint, checked, onChange }: SwitchRowProps) {
  const labelId = useId();
  const hintId = useId();
  return (
    <div className="ty-room-switch-row">
      <div className="ty-room-switch-copy">
        <span className="ty-room-label" id={labelId}>
          {label}
        </span>
        <span className="ty-room-hint" id={hintId}>
          {hint}
        </span>
      </div>
      <button
        type="button"
        role="switch"
        className="ty-room-switch"
        aria-checked={checked}
        aria-labelledby={labelId}
        aria-describedby={hintId}
        onClick={() => onChange(!checked)}
      >
        <span className="ty-room-switch-text" aria-hidden="true">
          {checked ? 'Bật' : 'Tắt'}
        </span>
        <span className="ty-room-switch-knob" aria-hidden="true" />
      </button>
    </div>
  );
}

interface PasswordInputProps {
  id: string;
  value: string;
  onChange: (value: string) => void;
  maxLength: number;
  errorId?: string;
  shakeKey?: number;
  initialFocus?: boolean;
  inputRef?: Ref<HTMLInputElement>;
}

export function PasswordInput({ id, value, onChange, maxLength, errorId, shakeKey, initialFocus, inputRef }: PasswordInputProps) {
  const [visible, setVisible] = useState(false);
  const boxRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!shakeKey || !errorId) return;
    if (window.matchMedia?.('(prefers-reduced-motion: reduce)').matches) return;
    boxRef.current?.animate(SHAKE_FRAMES, { duration: 300, easing: 'ease-out' });
  }, [shakeKey, errorId]);

  return (
    <div ref={boxRef} className={errorId ? 'ty-room-input ty-room-input-invalid' : 'ty-room-input'}>
      <input
        ref={inputRef}
        id={id}
        type={visible ? 'text' : 'password'}
        value={value}
        maxLength={maxLength}
        placeholder="Nhập mật khẩu"
        autoComplete="off"
        autoCapitalize="off"
        spellCheck={false}
        aria-invalid={errorId ? true : undefined}
        aria-describedby={errorId}
        data-dialog-initial-focus={initialFocus ? '' : undefined}
        onChange={(event) => onChange(event.target.value)}
      />
      <button type="button" className="ty-room-eye" aria-label="Hiện mật khẩu" aria-pressed={visible} onClick={() => setVisible((shown) => !shown)}>
        <TyIcon name={visible ? 'eye-off' : 'eye'} size={24} />
      </button>
    </div>
  );
}
