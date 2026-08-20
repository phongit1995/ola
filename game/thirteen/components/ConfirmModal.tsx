import { useId } from 'react';
import { handleModalKeyDown } from './modalKeyboard';

interface ConfirmModalProps {
  title: string;
  text: string;
  confirmLabel: string;
  cancelLabel: string | null;
  onConfirm: () => void;
  onCancel: () => void;
  style02?: boolean;
}

export function ConfirmModal({
  title,
  text,
  confirmLabel,
  cancelLabel,
  onConfirm,
  onCancel,
  style02 = false,
}: ConfirmModalProps) {
  const titleId = useId();
  return (
    <div
      className={`tl-modal-backdrop${style02 ? ' tl-lobby-modal-backdrop' : ''}`}
      onClick={(e) => e.target === e.currentTarget && onCancel()}
    >
      <div
        className={`tl-modal${style02 ? ' tl-lobby-modal' : ''}`}
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        onKeyDown={(event) => handleModalKeyDown(event, onCancel)}
      >
        {style02 && <span className="tl-modal-accent" aria-hidden="true" />}
        <div id={titleId} className="tl-modal-title">
          {title}
        </div>
        <p className="tl-modal-text">{text}</p>
        <div className="tl-modal-actions">
          {cancelLabel != null && (
            <button type="button" className="tl-btn tl-btn-ghost" onClick={onCancel} autoFocus>
              {cancelLabel}
            </button>
          )}
          <button type="button" className="tl-btn tl-btn-gold" onClick={onConfirm} autoFocus={cancelLabel == null}>
            {confirmLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
