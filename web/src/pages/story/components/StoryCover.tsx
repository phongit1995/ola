import type { ReactNode } from 'react';
import { cn, colorForName } from '@lib';
import { READER_FONTS } from '../constants';

type CoverSize = 'sm' | 'md' | 'lg';

const TITLE_CLASS: Record<CoverSize, string> = {
  sm: 'line-clamp-4 text-[9px] leading-[11px]',
  md: 'line-clamp-4 text-xs leading-4',
  lg: 'line-clamp-5 text-base leading-5',
};

interface StoryCoverProps {
  title: string;
  coverUrl?: string | null;
  size?: CoverSize;
  className?: string;
  children?: ReactNode;
}

export function StoryCover({
  title,
  coverUrl,
  size = 'md',
  className,
  children,
}: StoryCoverProps) {
  const color = colorForName(title);
  return (
    <div
      className={cn(
        'relative aspect-[3/4] overflow-hidden rounded-md shadow-[0_2px_6px_rgba(0,0,0,.25)]',
        className
      )}
      style={
        coverUrl
          ? undefined
          : {
              background: `linear-gradient(160deg, ${color}, color-mix(in srgb, ${color} 45%, #000))`,
            }
      }
    >
      {coverUrl ? (
        <img src={coverUrl} alt="" className="h-full w-full object-cover" />
      ) : (
        <>
          <span className="absolute inset-y-0 left-[8%] w-px bg-white/30" />
          <span
            className={cn(
              'absolute inset-x-0 top-[16%] px-[14%] text-center font-bold text-white [text-shadow:0_1px_2px_rgba(0,0,0,.35)]',
              TITLE_CLASS[size]
            )}
            style={{ fontFamily: READER_FONTS.serif.family }}
          >
            {title}
          </span>
        </>
      )}
      {children}
    </div>
  );
}
