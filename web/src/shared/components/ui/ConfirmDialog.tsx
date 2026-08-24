import type { ReactNode } from 'react';
import infoIcon from '@/assets/icons/chat/ic_dialog_indicate_info.png';
import { Dialog, DialogButton } from './Dialog';

function InfoIcon() {
  return <img src={infoIcon} alt="" className="h-8 w-8 object-contain" />;
}

interface ConfirmDialogProps {
  open: boolean;
  title: ReactNode;
  message: ReactNode;
  confirmLabel: string;
  cancelLabel: string;
  hideCancel?: boolean;
  danger?: boolean;
  showIcon?: boolean;
  checkboxLabel?: string;
  checked?: boolean;
  onCheckedChange?: (value: boolean) => void;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmDialog({
  open,
  title,
  message,
  confirmLabel,
  cancelLabel,
  hideCancel = false,
  danger = false,
  showIcon = true,
  checkboxLabel,
  checked = false,
  onCheckedChange,
  onConfirm,
  onCancel,
}: ConfirmDialogProps) {
  return (
    <Dialog
      open={open}
      onClose={onCancel}
      title={title}
      icon={showIcon ? <InfoIcon /> : undefined}
      footer={
        <>
          <DialogButton
            variant={danger ? 'danger' : 'green'}
            onClick={onConfirm}
          >
            {confirmLabel}
          </DialogButton>
          {!hideCancel && (
            <DialogButton variant="default" onClick={onCancel}>
              {cancelLabel}
            </DialogButton>
          )}
        </>
      }
    >
      <p>{message}</p>
      {checkboxLabel != null && (
        <label className="mt-3 flex items-center gap-2 text-sm text-[#616163]">
          <input
            type="checkbox"
            checked={checked}
            onChange={(event) => onCheckedChange?.(event.target.checked)}
            className="h-4 w-4 accent-ola-primary"
          />
          {checkboxLabel}
        </label>
      )}
    </Dialog>
  );
}
