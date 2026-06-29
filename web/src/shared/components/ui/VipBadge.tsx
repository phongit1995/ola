import { vipIconUrl } from '@lib';
import defaultVipIcon from '@/assets/icons/apps/vip.png';

interface VipBadgeProps {
  typeId?: number | null;
  className?: string;
}

export function VipBadge({ typeId, className = 'h-6 w-6' }: VipBadgeProps) {
  const src = typeId != null ? vipIconUrl(typeId) : defaultVipIcon;
  return <img src={src} alt="" className={`${className} shrink-0 object-contain`} />;
}
