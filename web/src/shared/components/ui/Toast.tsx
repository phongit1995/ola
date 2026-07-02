import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import { cn, portalRoot } from '@lib';
import { useToastStore, type ToastItem, type ToastType } from '@/store/toastStore';

const AUTO_DISMISS_MS = 3000;

const toastStyles: Record<ToastType, string> = {
  error: 'bg-ola-error text-white',
  success: 'bg-ola-primary-dark text-white',
  info: 'bg-black/80 text-white',
};

function ToastRow({ toast, onDismiss }: { toast: ToastItem; onDismiss: (id: number) => void }) {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const enter = window.setTimeout(() => setVisible(true), 10);
    const leave = window.setTimeout(() => onDismiss(toast.id), AUTO_DISMISS_MS);
    return () => {
      window.clearTimeout(enter);
      window.clearTimeout(leave);
    };
  }, [toast.id, onDismiss]);

  return (
    <button
      type="button"
      onClick={() => onDismiss(toast.id)}
      className={cn(
        'pointer-events-auto max-w-[90%] rounded-full px-4 py-2 text-center text-sm shadow-[0_4px_16px_rgba(0,0,0,0.3)] transition-all duration-200',
        toastStyles[toast.type],
        visible ? 'translate-y-0 opacity-100' : 'translate-y-2 opacity-0'
      )}
    >
      {toast.message}
    </button>
  );
}

export function ToastViewport() {
  const toasts = useToastStore((state) => state.toasts);
  const dismiss = useToastStore((state) => state.dismiss);

  if (toasts.length === 0) return null;

  return createPortal(
    <div className="pointer-events-none fixed inset-x-0 bottom-24 z-[130] flex flex-col items-center gap-2 px-4">
      {toasts.map((item) => (
        <ToastRow key={item.id} toast={item} onDismiss={dismiss} />
      ))}
    </div>,
    portalRoot()
  );
}
