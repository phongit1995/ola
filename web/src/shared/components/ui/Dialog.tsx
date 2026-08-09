import {
  useEffect,
  useRef,
  type ButtonHTMLAttributes,
  type ReactNode,
} from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { cn, portalRoot } from '@lib';

interface DialogProps {
  open: boolean;
  onClose: () => void;
  title?: ReactNode;
  icon?: ReactNode;
  showClose?: boolean;
  dismissOnBackdrop?: boolean;
  children: ReactNode;
  footer?: ReactNode;
}

export function Dialog({
  open,
  onClose,
  title,
  icon,
  showClose = false,
  dismissOnBackdrop = true,
  children,
  footer,
}: DialogProps) {
  const { t } = useTranslation();
  const backdropDownRef = useRef(false);

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
      onMouseDown={(event) => {
        backdropDownRef.current = event.target === event.currentTarget;
      }}
      onClick={(event) => {
        if (!dismissOnBackdrop) return;
        if (event.target === event.currentTarget && backdropDownRef.current)
          onClose();
      }}
      className="fixed inset-0 z-[110] grid place-items-center bg-black/60 p-4"
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
            <span className="min-w-0 flex-1 truncate text-xl font-bold text-[#3a3839]">
              {title}
            </span>
            {showClose && (
              <button
                type="button"
                onClick={onClose}
                aria-label={t('dialog.close')}
                className="-mr-1 flex h-8 w-8 shrink-0 items-center justify-center rounded text-[#3a3839] hover:bg-black/10"
              >
                <svg
                  viewBox="0 0 24 24"
                  className="h-4 w-4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  aria-hidden="true"
                >
                  <path d="M6 6l12 12M18 6L6 18" strokeLinecap="round" />
                </svg>
              </button>
            )}
          </div>
        )}
        <div className="m-2 min-h-[50px] text-sm leading-relaxed text-[#616163]">
          {children}
        </div>
        {footer != null && <div className="flex gap-2 px-1 pb-2">{footer}</div>}
      </div>
    </div>,
    portalRoot()
  );
}

type DialogButtonVariant = 'default' | 'green' | 'danger';

interface DialogButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: DialogButtonVariant;
}

const dialogButtonVariants: Record<DialogButtonVariant, string> = {
  default: 'border border-black/10 bg-white text-black/87 hover:bg-gray-50',
  green:
    'min-w-16 border border-ola-primary-dark bg-ola-button text-ola-on-primary hover:opacity-90',
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
