import type { SVGProps } from 'react';

const paths = {
  back: 'M15 18l-6-6 6-6',
  arrow: 'M5 12h14m-5-5 5 5-5 5',
  down: 'M12 5v14m-5-5 5 5 5-5',
  book: 'M12 5v15M3 4h5a4 4 0 0 1 4 2 4 4 0 0 1 4-2h5v15h-5a4 4 0 0 0-4 2 4 4 0 0 0-4-2H3z',
  trophy: 'M8 21h8m-4-4v4M7 3h10v6a5 5 0 0 1-10 0V3Zm10 2h3v2a3 3 0 0 1-3 3M7 5H4v2a3 3 0 0 0 3 3',
  help: 'M9.1 9a3 3 0 0 1 5.8 1c0 2-3 2-3 4m0 3h.01',
  link: 'm10 13 4-4m-6 6-1 1a4 4 0 0 1-6-6l4-4a4 4 0 0 1 6 0m2 2 1-1a4 4 0 0 1 6 6l-4 4a4 4 0 0 1-6 0',
  check: 'm5 12 4 4L19 6',
  close: 'm6 6 12 12M6 18 18 6',
  lock: 'M7 10V7a5 5 0 0 1 10 0M5 10h14v11H5zm7 5v2',
  spark: 'm12 3 2.5 6.5L21 12l-6.5 2.5L12 21l-2.5-6.5L3 12l6.5-2.5z',
} as const;
export type WordChainIconName = keyof typeof paths;

export function WordChainIcon({ name, className = 'h-5 w-5', ...props }: SVGProps<SVGSVGElement> & { name: WordChainIconName }) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true" className={className} {...props}>
      {name === 'help' && <circle cx="12" cy="12" r="10" />}
      <path d={paths[name]} />
    </svg>
  );
}