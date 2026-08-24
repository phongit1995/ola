import { useId } from 'react';
import { ModalHeading } from './ModalHeading';
import { useDialogFocus } from './useDialogFocus';

interface ConfirmModalProps {
  title: string;
  body: string;
  okLabel: string;
  danger?: boolean;
  onOk: () => void;
  onCancel: () => void;
}

export function ConfirmModal({ title, body, okLabel, danger, onOk, onCancel }: ConfirmModalProps) {
  const titleId = useId();
  const bodyId = useId();
  const modalRef = useDialogFocus<HTMLDivElement>({ onEscape: onCancel });

  return (
    <div className="xq-backdrop" role="presentation" onClick={onCancel}>
      <div
        ref={modalRef}
        className={`xq-modal xq-confirm-modal ${danger ? 'xq-modal-danger' : ''}`}
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={bodyId}
        tabIndex={-1}
        onClick={(event) => event.stopPropagation()}
      >
        <ModalHeading
          eyebrow={danger ? 'Hành động quan trọng' : 'Xác nhận'}
          title={title}
          icon={danger ? 'warning' : 'check'}
          titleId={titleId}
        />
        <p className="xq-modal-body" id={bodyId}>{body}</p>
        <div className="xq-modal-actions">
          <button type="button" className="xq-btn xq-btn-paper" onClick={onCancel} data-dialog-initial-focus={danger ? '' : undefined}>
            Hủy
          </button>
          <button
            type="button"
            className={`xq-btn ${danger ? 'xq-btn-danger' : 'xq-btn-gold'}`}
            onClick={onOk}
            data-dialog-initial-focus={danger ? undefined : ''}
          >
            {okLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
