import type { ReactNode } from 'react';
import kenIcon from '@/assets/icons/apps/ken.png';

const KEN_STYLES = {
  pill: 'mx-0.5 inline-flex items-center gap-1 rounded-full bg-amber-50 px-2 py-px align-middle font-semibold text-amber-700 ring-1 ring-amber-200',
  plain: 'ml-1 inline-flex items-center gap-1 align-middle font-semibold',
} as const;

export function WordChainKen({
  children,
  tone = 'pill',
}: {
  children?: ReactNode;
  tone?: keyof typeof KEN_STYLES;
}) {
  return (
    <span className={KEN_STYLES[tone]}>
      {children}
      <img src={kenIcon} alt="KEN" className="h-4 w-4 object-contain" />
    </span>
  );
}
