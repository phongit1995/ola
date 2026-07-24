import { assetBg, type AssetKey } from './assets';

interface ConfirmModalProps {
  open: boolean;
  text: string;
  icon?: AssetKey;
  confirmLabel?: string;
  cancelLabel?: string;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmModal({
  open,
  text,
  icon = 'confirmDoor',
  confirmLabel = 'Thoát',
  cancelLabel = 'Hủy',
  onConfirm,
  onCancel,
}: ConfirmModalProps) {
  return (
    <div
      className={'confirm-modal' + (open ? '' : ' hidden')}
      onClick={(e) => e.target === e.currentTarget && onCancel()}
    >
      <div className="confirm-card" style={assetBg('confirmBg')}>
        <div className="confirm-title" style={assetBg('confirmTitle')}>
          <span>Xác nhận</span>
        </div>
        <div className="confirm-body">
          <div className="confirm-icon" style={assetBg(icon)} />
          <p className="confirm-text">{text}</p>
          <div className="confirm-actions">
            <button type="button" className="confirm-btn danger" style={assetBg('btnRed')} onClick={onConfirm}>
              <span>{confirmLabel}</span>
            </button>
            <button type="button" className="confirm-btn" style={assetBg('btnNavy')} onClick={onCancel}>
              <span>{cancelLabel}</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
