import { useId, useRef } from 'react';
import { assetBg, type AssetKey } from '../assets';
import { handleDialogKeyDown, useDialogFocus } from '../helpers/dialog';

interface ConfirmModalProps {
  open: boolean;
  text: string;
  title?: string;
  icon?: AssetKey;
  confirmLabel?: string;
  cancelLabel?: string | null;
  confirmTone?: 'danger' | 'primary';
  dismissOnBackdrop?: boolean;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmModal({
  open,
  text,
  title = 'Xác nhận',
  icon = 'confirmDoor',
  confirmLabel = 'Thoát',
  cancelLabel = 'Hủy',
  confirmTone = 'danger',
  dismissOnBackdrop = true,
  onConfirm,
  onCancel,
}: ConfirmModalProps) {
  const cardRef = useRef<HTMLDivElement>(null);
  const titleId = useId();
  const descriptionId = useId();
  useDialogFocus(open, cardRef);

  return (
    <div
      className={'confirm-modal' + (open ? '' : ' hidden')}
      role="dialog"
      aria-modal="true"
      aria-labelledby={titleId}
      aria-describedby={descriptionId}
      aria-hidden={!open}
      onClick={(e) => dismissOnBackdrop && e.target === e.currentTarget && onCancel()}
      onKeyDown={(event) => handleDialogKeyDown(event, cardRef, onCancel)}
    >
      <div ref={cardRef} className="confirm-card" style={assetBg('confirmBg')}>
        <div className="confirm-title" style={assetBg('confirmTitle')}>
          <span id={titleId}>{title}</span>
        </div>
        <div className="confirm-body">
          <div className="confirm-icon" style={assetBg(icon)} />
          <p id={descriptionId} className="confirm-text">{text}</p>
          <div className="confirm-actions">
            <button
              type="button"
              className={'confirm-btn' + (confirmTone === 'danger' ? ' danger' : '')}
              style={assetBg(confirmTone === 'danger' ? 'btnRed' : 'btnNavy')}
              onClick={onConfirm}
            >
              <span>{confirmLabel}</span>
            </button>
            {cancelLabel != null && (
              <button type="button" className="confirm-btn" style={assetBg('btnNavy')} onClick={onCancel}>
                <span>{cancelLabel}</span>
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
