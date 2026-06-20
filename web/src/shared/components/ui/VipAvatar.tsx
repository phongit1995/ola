import { vipIconUrl } from '@lib';
import smileyIcon from '@/assets/icons/chat/ola_smiley_online.png';

interface VipAvatarProps {
  typeId?: number | null;
  className?: string;
}

export function VipAvatar({ typeId, className = 'h-10 w-10' }: VipAvatarProps) {
  const src = typeId != null ? vipIconUrl(typeId) : smileyIcon;
  return <img src={src} alt="" className={`${className} shrink-0 object-contain`} />;
}
