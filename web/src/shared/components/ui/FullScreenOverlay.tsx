import type { ReactNode } from 'react';

interface FullScreenOverlayProps {
  position?: 'fixed' | 'absolute';
  z?: 40 | 50 | 60;
  className?: string;
  keepMegaphone?: boolean;
  children: ReactNode;
}

export function FullScreenOverlay({
  position = 'fixed',
  z = 40,
  className = '',
  keepMegaphone = false,
  children,
}: FullScreenOverlayProps) {
  const positionClass = position === 'absolute' ? 'absolute' : 'fixed';
  const zClass = z === 60 ? 'z-[100]' : z === 50 ? 'z-50' : 'z-40';
  return (
    <div
      data-megaphone-cover={keepMegaphone ? undefined : ''}
      className={`${positionClass} ${zClass} inset-0 flex flex-col bg-ola-surface-cool ${className}`}
    >
      {children}
    </div>
  );
}
