interface ConfirmModalProps {
  title: string;
  text: string;
  confirmLabel: string;
  cancelLabel: string | null;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmModal({ title, text, confirmLabel, cancelLabel, onConfirm, onCancel }: ConfirmModalProps) {
  return (
    <div
      className="tl-modal-backdrop"
      role="dialog"
      aria-modal="true"
      onClick={(e) => e.target === e.currentTarget && onCancel()}
    >
      <div className="tl-modal">
        <div className="tl-modal-title">{title}</div>
        <p className="tl-modal-text">{text}</p>
        <div className="tl-modal-actions">
          {cancelLabel != null && (
            <button type="button" className="tl-btn tl-btn-ghost" onClick={onCancel}>
              {cancelLabel}
            </button>
          )}
          <button type="button" className="tl-btn tl-btn-gold" onClick={onConfirm}>
            {confirmLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
