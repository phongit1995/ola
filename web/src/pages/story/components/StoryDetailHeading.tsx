import type { ReactNode } from 'react';

export function StoryDetailHeading({ children }: { children: ReactNode }) {
  return (
    <h2 className="flex items-center gap-2 text-[15px] font-bold text-black/87">
      <span
        aria-hidden="true"
        className="h-4 w-1 shrink-0 rounded-full bg-linear-to-b from-ola-primary to-ola-primary-dark"
      />
      {children}
    </h2>
  );
}
