import charmIcon from '@/assets/icons/profile/charm/charm-07-double-heart.webp';
import { cn } from '@lib';

interface CharmIconProps {
  className?: string;
}

export function CharmIcon({ className }: CharmIconProps) {
  return (
    <img
      src={charmIcon}
      alt=""
      aria-hidden="true"
      className={cn('inline-block h-4 w-4 shrink-0 object-contain', className)}
    />
  );
}
