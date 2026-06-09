import type { ButtonHTMLAttributes } from 'react';
import { cn } from '@/lib/utils';

type Variant = 'primary' | 'accent' | 'outline';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: Variant;
}

const variants: Record<Variant, string> = {
  primary: 'bg-ola-primary text-white hover:bg-ola-primary-dark',
  accent: 'bg-ola-accent text-white hover:opacity-90',
  outline:
    'border border-gray-300 text-gray-800 hover:border-ola-primary hover:text-ola-primary',
};

export function Button({
  variant = 'primary',
  className,
  ...props
}: ButtonProps) {
  return (
    <button
      className={cn(
        'inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-ola-primary/50 disabled:opacity-50',
        variants[variant],
        className
      )}
      {...props}
    />
  );
}
