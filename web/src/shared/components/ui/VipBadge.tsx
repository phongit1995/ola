import { vipIconUrl } from '@lib';
import smileyIcon from '@/assets/icons/chat/ola_smiley_online.png';

interface VipBadgeProps {
  typeId?: number | null;
  className?: string;
}

export function VipBadge({ typeId, className = 'h-6 w-6' }: VipBadgeProps) {
  const src = typeId != null ? vipIconUrl(typeId) : smileyIcon;
  return (
    <img src={src} alt="" className={`${className} shrink-0 object-contain`} />
  );
}
