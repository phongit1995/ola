import type { ReactNode } from 'react';

export function HomeHeader({ children }: { children: ReactNode }) {
  return (
    <header className="flex h-12 shrink-0 items-center bg-ola-primary px-2 text-ola-on-primary shadow-[0_1px_0_rgba(0,0,0,.12)]">
      {children}
    </header>
  );
}
