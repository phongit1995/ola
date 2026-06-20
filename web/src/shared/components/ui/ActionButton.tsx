import type { ButtonHTMLAttributes, ReactNode } from 'react';

interface ActionButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'filled' | 'outline';
  children: ReactNode;
}

const VARIANTS: Record<'filled' | 'outline', string> = {
  filled: 'bg-ola-primary text-white',
  outline: 'border border-ola-primary text-ola-primary',
};

export function ActionButton({
  variant = 'filled',
  type = 'button',
  className = '',
  children,
  ...rest
}: ActionButtonProps) {
  return (
    <button
      type={type}
      className={`shrink-0 rounded-full px-3 py-1 text-sm font-medium disabled:opacity-50 ${VARIANTS[variant]} ${className}`}
      {...rest}
    >
      {children}
    </button>
  );
}
