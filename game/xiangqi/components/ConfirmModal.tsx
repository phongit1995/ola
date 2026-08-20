import { useEffect, useRef } from 'react';

interface ConfirmModalProps {
  title: string;
  body: string;
  okLabel: string;
  danger?: boolean;
  onOk: () => void;
  onCancel: () => void;
}

export function ConfirmModal({ title, body, okLabel, danger, onOk, onCancel }: ConfirmModalProps) {
  const okRef = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    okRef.current?.focus();
    const onKey = (event: KeyboardEvent) => {
      if (event.key === 'Escape') onCancel();
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [onCancel]);

  return (
    <div className="xq-backdrop" role="presentation" onClick={onCancel}>
      <div className="xq-modal" role="dialog" aria-modal="true" aria-label={title} onClick={(event) => event.stopPropagation()}>
        <h2 className="xq-modal-title">{title}</h2>
        <p className="xq-modal-body">{body}</p>
        <div className="xq-modal-actions">
          <button type="button" className="xq-btn xq-btn-paper" onClick={onCancel}>
            Hủy
          </button>
          <button type="button" ref={okRef} className={`xq-btn ${danger ? 'xq-btn-danger' : 'xq-btn-gold'}`} onClick={onOk}>
            {okLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
