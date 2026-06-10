import type { ReactNode } from 'react';
import { Dialog, DialogButton } from './Dialog';

function InfoIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-8 w-8" aria-hidden="true">
      <circle cx="12" cy="12" r="10" fill="#4a90d9" />
      <rect x="11" y="10" width="2" height="7" rx="1" fill="#fff" />
      <circle cx="12" cy="7" r="1.3" fill="#fff" />
    </svg>
  );
}

interface ConfirmDialogProps {
  open: boolean;
  title: ReactNode;
  message: ReactNode;
  confirmLabel: string;
  cancelLabel: string;
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
          <DialogButton variant="default" onClick={onCancel}>
            {cancelLabel}
          </DialogButton>
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
