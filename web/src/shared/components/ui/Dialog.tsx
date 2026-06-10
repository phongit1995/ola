import { useEffect, type ButtonHTMLAttributes, type ReactNode } from 'react';
import { createPortal } from 'react-dom';
import { cn } from '@lib';

interface DialogProps {
  open: boolean;
  onClose: () => void;
  title?: ReactNode;
  icon?: ReactNode;
  dismissOnBackdrop?: boolean;
  children: ReactNode;
  footer?: ReactNode;
}

export function Dialog({
  open,
  onClose,
  title,
  icon,
  dismissOnBackdrop = true,
  children,
  footer,
}: DialogProps) {
  useEffect(() => {
    if (!open) return;
    function handleKey(event: KeyboardEvent) {
      if (event.key === 'Escape') onClose();
    }
    document.addEventListener('keydown', handleKey);
    return () => document.removeEventListener('keydown', handleKey);
  }, [open, onClose]);

  if (!open) return null;

  return createPortal(
    <div
      role="presentation"
      onClick={dismissOnBackdrop ? onClose : undefined}
      className="fixed inset-0 z-50 grid place-items-center bg-black/60 p-4"
    >
      <div
        role="dialog"
        aria-modal="true"
        onClick={(event) => event.stopPropagation()}
        className="w-full min-w-[280px] max-w-sm overflow-hidden rounded-[5px] bg-white shadow-[0_6px_24px_rgba(0,0,0,0.35)]"
      >
        {title != null && (
          <div className="flex min-h-[38px] items-center gap-[5px] border-b border-[#d1cece] bg-gradient-to-b from-[#f1f1f1] to-[#e4e4e4] px-2 py-1">
            {icon != null && (
              <span className="flex h-[34px] w-[34px] shrink-0 items-center justify-center">
                {icon}
              </span>
            )}
            <span className="truncate text-xl font-bold text-[#3a3839]">
              {title}
            </span>
          </div>
        )}
        <div className="m-2 min-h-[50px] text-sm leading-relaxed text-[#616163]">
          {children}
        </div>
        {footer != null && (
          <div className="flex gap-2 px-1 pb-2">{footer}</div>
        )}
      </div>
    </div>,
    document.body
  );
}

type DialogButtonVariant = 'default' | 'green' | 'danger';

interface DialogButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: DialogButtonVariant;
}

const dialogButtonVariants: Record<DialogButtonVariant, string> = {
  default: 'border border-black/10 bg-white text-black/87 hover:bg-gray-50',
  green:
    'min-w-16 border border-ola-primary-dark bg-ola-button text-white hover:opacity-90',
  danger: 'bg-[#dd4b39] text-white hover:opacity-90',
};

export function DialogButton({
  variant = 'default',
  className,
  ...props
}: DialogButtonProps) {
  return (
    <button
      className={cn(
        'min-h-7 min-w-14 flex-1 rounded-[2px] px-1 py-[5px] text-sm transition-colors focus:outline-none focus:ring-2 focus:ring-ola-primary/40 disabled:opacity-50',
        dialogButtonVariants[variant],
        className
      )}
      {...props}
    />
  );
}
