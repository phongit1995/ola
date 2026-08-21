import { useEffect, useId, useRef } from 'react';

interface ConfirmModalProps {
  title: string;
  body: string;
  okLabel: string;
  danger?: boolean;
  onOk: () => void;
  onCancel: () => void;
}

export function ConfirmModal({ title, body, okLabel, danger, onOk, onCancel }: ConfirmModalProps) {
  const modalRef = useRef<HTMLDivElement>(null);
  const cancelRef = useRef<HTMLButtonElement>(null);
  const okRef = useRef<HTMLButtonElement>(null);
  const titleId = useId();
  const bodyId = useId();

  useEffect(() => {
    const previousFocus = document.activeElement instanceof HTMLElement ? document.activeElement : null;
    (danger ? cancelRef.current : okRef.current)?.focus();
    const onKey = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        onCancel();
        return;
      }
      if (event.key !== 'Tab' || !modalRef.current) return;
      const focusable = Array.from(modalRef.current.querySelectorAll<HTMLButtonElement>('button:not(:disabled)'));
      const first = focusable[0];
      const last = focusable.at(-1);
      if (!first || !last) return;
      if (event.shiftKey && document.activeElement === first) {
        event.preventDefault();
        last.focus();
      } else if (!event.shiftKey && document.activeElement === last) {
        event.preventDefault();
        first.focus();
      }
    };
    window.addEventListener('keydown', onKey);
    return () => {
      window.removeEventListener('keydown', onKey);
      previousFocus?.focus();
    };
  }, [danger, onCancel]);

  return (
    <div className="xq-backdrop" role="presentation" onClick={onCancel}>
      <div
        ref={modalRef}
        className="xq-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={bodyId}
        onClick={(event) => event.stopPropagation()}
      >
        <h2 className="xq-modal-title" id={titleId}>{title}</h2>
        <p className="xq-modal-body" id={bodyId}>{body}</p>
        <div className="xq-modal-actions">
          <button type="button" ref={cancelRef} className="xq-btn xq-btn-paper" onClick={onCancel}>
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
